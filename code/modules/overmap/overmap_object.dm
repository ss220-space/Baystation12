/obj/effect/overmap
	name = "map object"
	icon = 'icons/obj/overmap.dmi'
	icon_state = "object"
	color = "#fffffe"

	var/known = 1		//shows up on nav computers automatically
	var/scannable       //if set to TRUE will show up on ship sensors for detailed scans
	var/scanner_name	//name for scans, replaces name once scanned
	var/scanner_desc	//description for scans
	var/overmap_effect_state //Our overmap effect state.

	var/list/map_z = list()

	var/start_x			//Coordinates for self placing
	var/start_y			//will use random values if unset

	var/sector_flags = OVERMAP_SECTOR_KNOWN|OVERMAP_SECTOR_IN_SPACE

//Overlay of how this object should look on other skyboxes
/obj/effect/overmap/proc/get_skybox_representation()
	return

/obj/effect/overmap/proc/get_scan_data(mob/user)
	if(scanner_name && (name != scanner_name)) //A silly check, but 'name' is part of appearance, so more expensive than you might think
		name = scanner_name

	var/dat = {"<b>Scan conducted at</b>: <br>[stationtime2text()] [stationdate2text()] <b>Grid coordinates</b>:<br> [x],[y]\n\n[scanner_desc]"}

	return dat

/obj/effect/overmap/Initialize()
	. = ..()
	if(!GLOB.using_map.use_overmap)
		return INITIALIZE_HINT_QDEL

	if(known)
		layer = ABOVE_LIGHTING_LAYER
		plane = EFFECTS_ABOVE_LIGHTING_PLANE
		for(var/obj/machinery/computer/ship/helm/H in SSmachines.machinery)
			H.get_known_sectors()
	overmap_effect_state = icon_state
	icon_state = "blank"
	update_icon()

/obj/effect/overmap/Crossed(var/obj/effect/overmap/visitable/other)
	if(istype(other))
		for(var/obj/effect/overmap/visitable/O in loc)
			SSskybox.rebuild_skyboxes(O.map_z)

/obj/effect/overmap/Uncrossed(var/obj/effect/overmap/visitable/other)
	if(istype(other))
		SSskybox.rebuild_skyboxes(other.map_z)
		for(var/obj/effect/overmap/visitable/O in loc)
			SSskybox.rebuild_skyboxes(O.map_z)

/obj/effect/overmap/on_update_icon()
	filters = filter(type="drop_shadow", color = color + "F0", size = 2, offset = 1,x = 0, y = 0)


/**
 * Flags the effect as `known` and runs relevant update procs. Intended for admin event usage.
 */
/obj/effect/overmap/proc/make_known(notify = FALSE)
	if (!known)
		known = TRUE
		update_known_connections(notify)


/**
 * Runs any relevant code needed for updating anything connected to known overmap effects, such as helms.
 */
/obj/effect/overmap/proc/update_known_connections(notify = FALSE)
	return
