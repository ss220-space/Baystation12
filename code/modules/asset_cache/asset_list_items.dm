/datum/asset/nanoui
	var/list/common = list()

	var/list/common_dirs = list(
		"nano/css/",
		"nano/images/",
		"nano/images/status_icons/",
		"nano/images/modular_computers/",
		"nano/js/"
	)
	var/list/uncommon_dirs = list(
		"nano/templates/"
	)

/datum/asset/nanoui/register()
	// Crawl the directories to find files.
	for (var/path in common_dirs)
		var/list/filenames = flist(path)
		for(var/filename in filenames)
			if(copytext(filename, length(filename)) != "/") // Ignore directories.
				if(fexists(path + filename))
					common[filename] = fcopy_rsc(path + filename)
					register_asset(filename, common[filename])

	for (var/path in uncommon_dirs)
		var/list/filenames = flist(path)
		for(var/filename in filenames)
			if(copytext(filename, length(filename)) != "/") // Ignore directories.
				if(fexists(path + filename))
					register_asset(filename, fcopy_rsc(path + filename))

	var/list/mapnames = list()
	for(var/z in GLOB.using_map.map_levels)
		mapnames += map_image_file_name(z)

	var/list/filenames = flist(MAP_IMAGE_PATH)
	for(var/filename in filenames)
		if(copytext(filename, length(filename)) != "/") // Ignore directories.
			var/file_path = MAP_IMAGE_PATH + filename
			if((filename in mapnames) && fexists(file_path))
				common[filename] = fcopy_rsc(file_path)
				register_asset(filename, common[filename])

/datum/asset/nanoui/send(client, uncommon)
	if(!islist(uncommon))
		uncommon = list(uncommon)

	send_asset_list(client, uncommon)
	send_asset_list(client, common)




/datum/asset/group/goonchat
	children = list(
		/datum/asset/simple/jquery,
		/datum/asset/simple/goonchat,
		/datum/asset/simple/fontawesome
	)

/datum/asset/simple/jquery
	assets = list(
		"jquery.min.js"            = file("code/modules/goonchat/browserassets/js/jquery.min.js")
	)

/datum/asset/simple/goonchat
	assets = list(
		"json2.min.js"             = file("code/modules/goonchat/browserassets/js/json2.min.js"),
		"browserOutput.js"         = file("code/modules/goonchat/browserassets/js/browserOutput.js"),
		"browserOutput.css"	       = file("code/modules/goonchat/browserassets/css/browserOutput.css"),
		"browserOutput_white.css"  = file("code/modules/goonchat/browserassets/css/browserOutput_white.css")
	)

/datum/asset/simple/fontawesome
	assets = list(
		"fa-regular-400.eot"  = file("html/font-awesome/webfonts/fa-regular-400.eot"),
		"fa-regular-400.woff" = file("html/font-awesome/webfonts/fa-regular-400.woff"),
		"fa-solid-900.eot"    = file("html/font-awesome/webfonts/fa-solid-900.eot"),
		"fa-solid-900.woff"   = file("html/font-awesome/webfonts/fa-solid-900.woff"),
		"font-awesome.css"    = file("html/font-awesome/css/all.min.css"),
		"v4shim.css"          = file("html/font-awesome/css/v4-shims.min.css")
	)

/datum/asset/simple/tgui
		assets = list(
		"tgui.bundle.js" = file("tgui/public/tgui.bundle.js"),
		"tgui.bundle.css" = file("tgui/public/tgui.bundle.css"),
	)

/datum/asset/simple/tgfont
	assets = list(
		"tgfont.eot" = file("tgui/packages/tgfont/dist/tgfont.eot"),
		"tgfont.woff2" = file("tgui/packages/tgfont/dist/tgfont.woff2"),
		"tgfont.css" = file("tgui/packages/tgfont/dist/tgfont.css"),
	)


/datum/asset/spritesheet/vending
	name = "vending"

/datum/asset/spritesheet/vending/register()
	populate_vending_products()
	for(var/atom/item as anything in GLOB.vending_products)
		if(!ispath(item, /atom))
			continue

		var/icon_file = initial(item.icon)
		var/icon_state = initial(item.icon_state)

		// I really don't like the fact that I have to do this, but what the hell else *can* I do to make all of these
		// random special items work? - VOREStation
		if(ispath(item, /obj/item/reagent_containers/food/drinks/glass2) && !ispath(item, /obj/item/reagent_containers/food/drinks/glass2/fitnessflask))
			var/obj/item/reagent_containers/food/drinks/glass2/G = item
			icon_state = initial(G.base_icon)
		if (ispath(item, /obj/item/reagent_containers/syringe))
			var/obj/item/reagent_containers/syringe/S = item
			icon_state = initial(S.item_state)
		if(ispath(item, /obj/item/reagent_containers/hypospray/autoinjector))
			icon_state += "0"
		if(ispath(item, /obj/item/soap))
			icon_state = "soap-oval"

		var/icon/I

		var/icon_states_list = icon_states(icon_file)
		if(icon_state in icon_states_list)
			I = icon(icon_file, icon_state, SOUTH)
			var/c = initial(item.color)
			if(!isnull(c) && c != "#FFFFFF")
				I.Blend(c, ICON_MULTIPLY)
		else
			var/icon_states_string
			for(var/an_icon_state in icon_states_list)
				if(!icon_states_string)
					icon_states_string = "[json_encode(an_icon_state)](\ref[an_icon_state])"
				else
					icon_states_string += ", [json_encode(an_icon_state)](\ref[an_icon_state])"
			stack_trace("[item] does not have a valid icon state, icon=[icon_file], icon_state=[json_encode(icon_state)](\ref[icon_state]), icon_states=[icon_states_string]")
			I = icon('icons/turf/floors.dmi', "", SOUTH)

		var/imgid = replacetext(replacetext("[item]", "/obj/item/", ""), "/", "-")

		Insert(imgid, I)
	return ..()

// this is cursed but necessary or else vending product icons can be missing
// basically, if there's any vending machines that aren't already mapped in, our register() will not know
// that they exist, and therefore can't generate the entries in the spritesheet for them
// and since assets are unique and can't be reloaded later, we have to make sure that GLOB.vending_products
// is populated with every single type of vending machine
// As this is only done at runtime, we have to create all the vending machines in existence and force them
// to register their products when this asset initializes.
/datum/asset/spritesheet/vending/proc/populate_vending_products()
	SSatoms.map_loader_begin()
	for(var/path in subtypesof(/obj/machinery/vending))
		var/obj/machinery/vending/x = new path(null)
		// force an inventory build; with map_loader_begin active, init isn't called
		x.build_inventory()
		qdel(x)
	SSatoms.map_loader_stop()
