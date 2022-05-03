/obj/cart
	name = "Cargo cart."
	desc = "Simple cart for heavy things.\n<font size=1px>(Ctrl+Alt+RMB to change wheels state)</font>"
	icon = 'icons/obj/cart.dmi'
	icon_state = "cart"
	w_class = ITEM_SIZE_LARGE
	haswheels = TRUE
	var/atom/movable/load

/obj/cart/Move()
	. = ..()
	if(load && !istype(load, /datum/vehicle_dummy_load))
		load.set_glide_size(src.glide_size)
		load.forceMove(src.loc)
		load.set_dir(src.dir)

	var/sound
	if(haswheels)
		sound = pick(list(
			'sound/effects/cart1.ogg',
			'sound/effects/cart2.ogg',
			'sound/effects/cart3.ogg'
		))
	else
		sound = pick(list(
			'sound/effects/metalscrape1.ogg',
			'sound/effects/metalscrape2.ogg',
			'sound/effects/metalscrape3.ogg'
		))

	playsound(src, sound, 50, 1, 10)


/obj/cart/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	if(!CanPhysicallyInteract(user) || !user.Adjacent(C) || !istype(C) || (user == C))
		return

	if(haswheels)
		to_chat(user, SPAN_WARNING("You cant place somethink on cart before you has folded the wheels!"))
		return

	if(do_after(usr, 5 SECONDS, src))
		if(!load(C))
			to_chat(user, "<span class='warning'>You were unable to load [C] on [src].</span>")
			return

/obj/cart/attack_hand(mob/user as mob)
	if(user.stat || user.restrained() || !Adjacent(user))
		return 0

	if(load)
		unload(user)
	else
		return 0

/obj/cart/verb/turn_wheels()
	set src in view(1)
	set name = "Release wheels"
	set category = "Object"
	usr.visible_message(SPAN_NOTICE("You have [haswheels ? "folded" : "released"] wheels."), SPAN_NOTICE("[usr] [haswheels ? "folded" : "released"] wheels on [src]"))
	haswheels = !haswheels

/obj/cart/CtrlAltClick(mob/user)
	. = ..()
	turn_wheels()

/obj/cart/proc/load(var/atom/movable/C)
	if(ismob(C))
		return 0
	if(!istype(C,/obj/machinery) && !istype(C,/obj/structure/closet) && !istype(C,/obj/structure/largecrate) && !istype(C,/obj/structure/reagent_dispensers) && !istype(C,/obj/structure/ore_box))
		return 0

	//if there are any items you don't want to be able to interact with, add them to this check
	// ~no more shielded, emitter armed death trains
	if(istype(C, /obj/machinery))
		load_object(C)
	else
		if(!isturf(C.loc)) //To prevent loading things from someone's inventory, which wouldn't get handled properly.
			return 0
		if(load || C.anchored)
			return 0

		// if a create/closet, close before loading
		var/obj/structure/closet/crate = C
		if(istype(crate) && crate.opened && !crate.close())
			return 0

		C.forceMove(loc)
		C.set_dir(dir)
		C.anchored = TRUE

		load = C

		C.plane = plane
		C.layer = VEHICLE_LOAD_LAYER		//so it sits above the vehicle

		C.pixel_y += 2

	if(load)
		var/obj/O = load
		cargoweight = between(0, O.w_class, ITEM_SIZE_GARGANTUAN)
		return 1

/obj/cart/proc/load_object(var/atom/movable/C)
	if(!isturf(C.loc)) //To prevent loading things from someone's inventory, which wouldn't get handled properly.
		return 0
	if(load || C.anchored)
		return 0

	var/datum/vehicle_dummy_load/dummy_load = new()
	load = dummy_load

	if(!load)
		return
	dummy_load.actual_load = C
	C.forceMove(src)

	C.pixel_y += 2
	C.plane = plane
	C.layer = VEHICLE_LOAD_LAYER

	overlays += C

	//we can set these back now since we have already cloned the icon into the overlay
	C.pixel_y = initial(C.pixel_y)
	C.reset_plane_and_layer()

/obj/cart/proc/unload(var/mob/user, var/direction)
	if(istype(load, /datum/vehicle_dummy_load))
		var/datum/vehicle_dummy_load/dummy_load = load
		load = dummy_load.actual_load
		dummy_load.actual_load = null
		qdel(dummy_load)
		overlays.Cut()

	if(!load)
		return

	var/turf/dest = null

	//find a turf to unload to
	if(direction)	//if direction specified, unload in that direction
		dest = get_step(src, direction)
	else if(user)	//if a user has unloaded the vehicle, unload at their feet
		dest = get_turf(user)

	if(!dest)
		dest = get_step_to(src, get_step(src, turn(dir, 90))) //try unloading to the side of the vehicle first if neither of the above are present

	//if these all result in the same turf as the vehicle or nullspace, pick a new turf with open space
	if(!dest || dest == get_turf(src))
		var/list/options = new()
		for(var/test_dir in GLOB.alldirs)
			var/new_dir = get_step_to(src, get_step(src, test_dir))
			if(new_dir && load.Adjacent(new_dir))
				options += new_dir
		if(options.len)
			dest = pick(options)
		else
			dest = get_turf(src)	//otherwise just dump it on the same turf as the vehicle

	if(!isturf(dest))	//if there still is nowhere to unload, cancel out since the vehicle is probably in nullspace
		return 0

	load.forceMove(dest)
	load.set_dir(get_dir(loc, dest))
	load.anchored = FALSE		//we can only load non-anchored items, so it makes sense to set this to false
	load.pixel_y = initial(load.pixel_y)
	load.reset_plane_and_layer()

	cargoweight = null
	load = null
	update_icon()

	return 1
