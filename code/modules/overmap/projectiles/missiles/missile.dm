/*
	welcome to space war kiddo

	These are overmap capable missiles. Upon being activated, they appear on the overmap and travel along it until it enters a tile with associated z levels.
	Then it appears on the z level and travels on it. Maybe it hits something, maybe not. When it hits the z level edge, it'll disappear into the overmap again.

	The missiles are intended to be very modular, and thus do very little on their own except for handling the missile-overmap object interaction and calling appropriate procs on the missile equipment contained inside.

	Also note that while they're called missiles, it's a bit of a misleading name since the missile behavior is almost wholly determined by what equipment it has.
	Check equipment/missile_equipment.dm for more info.
*/

/obj/structure/missile
	name = "MK3 Universal Missile"
	desc = "A development on the MK2, this missile frame allows various modular components to be installed that define what the missile can and cannot do. "
	icon = 'icons/obj/bigmissile.dmi'
	icon_state = "base"

	density = 1
	w_class = ITEM_SIZE_HUGE
	dir = WEST
	does_spin = FALSE

	var/overmap_name = "missile"

	var/maintenance_hatch_open = FALSE
	var/active = FALSE
	var/entered_away = FALSE
	var/list/equipment = list()
	var/obj/effect/overmap/projectile/overmap_missile = null
	var/lifetime = 60 SECONDS
	var/obj/effect/overmap/origin = null

/obj/structure/missile/proc/get_additional_info()
	var/list/info = list("Detected components:<ul>")
	for(var/obj/item/missile_equipment/E in equipment)
		info += ("<li>" + E.name)
	info += "</ul>"
	return JOINTEXT(info)

/obj/structure/missile/Initialize()
	. = ..()

	for(var/i = 1; i <= LAZYLEN(equipment); i++)
		var/path = equipment[i]
		equipment[i] = new path(src)

	update_icon()

/obj/structure/missile/Destroy()
	. = ..()

	walk(src, 0)
	QDEL_NULL_LIST(equipment)

	if(!QDELETED(overmap_missile))
		QDEL_NULL(overmap_missile)
	overmap_missile = null

/obj/structure/missile/Move()
	. = ..()

	// for some reason, touch_map_edge doesn't always trigger like it should
	// this ensures that it does
	if(x < TRANSITIONEDGE || x > world.maxx - TRANSITIONEDGE || y < TRANSITIONEDGE || y > world.maxy - TRANSITIONEDGE)
		touch_map_edge()

/obj/structure/missile/Bump(var/atom/obstacle)
	..()
	detonate(obstacle)

/obj/structure/missile/proc/expire()
	Destroy()

// Move to the overmap until we encounter a new z
/obj/structure/missile/touch_map_edge()

	addtimer(CALLBACK(src, .proc/expire), lifetime)

	//Missile destroyed if it fails to hit something
	if(entered_away)
		Destroy()
		return
	// In case the proc is called normally alongside the call in Move()
	if(loc == overmap_missile)
		return

	for(var/obj/item/missile_equipment/E in equipment)
		E.on_touch_map_edge(overmap_missile)

	// didn't activate the missile in time, so it drifts off into space harmlessly or something
	if(!active)
		Destroy()
		return

	if(overmap_missile.dangerous)
		log_and_message_admins("A dangerous missile has entered the overmap (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[overmap_missile.x];Y=[overmap_missile.y];Z=[overmap_missile.z]'>JMP</a>)")
		addtimer(CALLBACK(src, .proc/sendsignal), rand(1 SECONDS, 3 SECONDS))


	origin = map_sectors["[z]"]
	overmap_missile.SetName("[origin.scanner_name]'s [overmap_name]")
	// Abort walk
	walk(src, 0)
	forceMove(overmap_missile)
	overmap_missile.set_moving(TRUE)


/obj/structure/missile/proc/sendsignal()
	for (var/obj/machinery/computer/ship/missiles/S in SSmachines.machinery)
		S.announce()


/obj/structure/missile/attackby(var/obj/item/I, var/mob/user)

	if(isScrewdriver(I))
		maintenance_hatch_open = !maintenance_hatch_open
		to_chat(user, "You [maintenance_hatch_open ? "open" : "close"] the maintenance hatch of \the [src].")

		update_icon()
		return

	if(maintenance_hatch_open)
		if(istype(I, /obj/item/missile_equipment))
			if(istype(I, /obj/item/missile_equipment/payload))
				for(var/obj/item/missile_equipment/payload/L in equipment)
					to_chat(user, "\The [src] can only have one payload.")
					return

			if(istype(I, /obj/item/missile_equipment/thruster))
				for(var/obj/item/missile_equipment/thruster/T in equipment)
					to_chat(user, "\The [src] can only have one thruster.")
					return

			if(!user.unEquip(I, src))
				return
			equipment += I
			to_chat(user, "You install \the [I] into \the [src].")

			update_icon()
			return

		if(isCrowbar(I))
			var/obj/item/missile_equipment/removed_component = input("Which component would you like to remove?") as null|obj in equipment
			if(removed_component)
				to_chat(user, "You remove \the [removed_component] from \the [src].")
				user.put_in_hands(removed_component)
				equipment -= removed_component

				update_icon()
			return

	..()

/obj/structure/missile/on_update_icon()
	overlays.Cut()

	for(var/obj/item/missile_equipment/E in equipment)
		overlays += E.icon_state
	overlays += "panel[maintenance_hatch_open ? "_open" : ""]"

// primes the missile and puts it on the overmap
/obj/structure/missile/proc/activate()
	if(active)
		return 0

	var/obj/effect/overmap/start_object = waypoint_sector(src)
	if(!start_object)
		return 0

	active = TRUE

	overmap_missile = new /obj/effect/overmap/projectile(null, start_object.x, start_object.y)
	overmap_missile.set_missile(src)

	for(var/obj/item/missile_equipment/E in equipment)
		E.on_missile_activated(overmap_missile)

	return 1

/obj/structure/missile/proc/detonate(var/atom/obstacle)
	if(!active)
		return

	// missile equipment triggers before the missile itself
	for(var/obj/item/missile_equipment/E in equipment)
		E.on_trigger(obstacle)

	// stop moving
	walk(src, 0)
	active = FALSE
	Destroy()

// Figure out where to pop in and set the missile flying
/obj/structure/missile/proc/enter_level(var/z_level, var/target_fore_dir, var/target_dir)


	// prevent the missile from moving on the overmap
	overmap_missile.set_moving(FALSE)
	entered_away = TRUE
	var/heading = overmap_missile.dir
	if(!heading)
		heading = random_dir() // To prevent the missile from popping into the middle of the map and sitting there

	var/start_x = Floor(world.maxx / 2) + rand(-10, 10)
	var/start_y = Floor(world.maxy / 2) + rand(-10, 10)


	//Normalizes this to just be NWES. If you want to do the fuckery required to make this better, be my guest.
	if(heading in GLOB.cornerdirs)
		if(heading == NORTHEAST)
			heading = pick(NORTH, EAST)
		if(heading == NORTHWEST)
			heading = pick(NORTH, WEST)
		if(heading == SOUTHEAST)
			heading = pick(SOUTH, EAST)
		if(heading == SOUTHWEST)
			heading = pick(SOUTH, WEST)

	if(target_dir in GLOB.cornerdirs)
		if(target_dir == NORTHEAST)
			target_dir = pick(NORTH, EAST)
		if(target_dir == NORTHWEST)
			target_dir = pick(NORTH, WEST)
		if(target_dir == SOUTHEAST)
			target_dir = pick(SOUTH, EAST)
		if(target_dir == SOUTHWEST)
			target_dir = pick(SOUTH, WEST)

	if(heading == target_dir)
		if(target_fore_dir == NORTH)
			start_y = TRANSITIONEDGE + 2
			heading = NORTH
		else if(target_fore_dir == SOUTH)
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH
		else if(target_fore_dir == WEST)
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST
		else
			start_x = TRANSITIONEDGE + 2
			heading = EAST

	else if(heading == GLOB.reverse_dir[target_dir])
		if(target_fore_dir == NORTH)
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH
		else if(target_fore_dir == SOUTH)
			start_y = TRANSITIONEDGE + 2
			heading = NORTH
		else if(target_fore_dir == WEST)
			start_x = TRANSITIONEDGE + 2
			heading = EAST
		else
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST

	else if(heading == GLOB.cw_dir[target_dir])
		if(target_fore_dir == NORTH)
			start_x = TRANSITIONEDGE + 2
			heading = EAST
		else if(target_fore_dir == SOUTH)
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST
		else if(target_fore_dir == WEST)
			start_y = TRANSITIONEDGE + 2
			heading = NORTH
		else
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH

	else if(heading == GLOB.ccw_dir[target_dir])
		if(target_fore_dir == NORTH)
			start_x = world.maxx - TRANSITIONEDGE - 2
			heading = WEST
		else if(target_fore_dir == SOUTH)
			start_x = TRANSITIONEDGE + 2
			heading = EAST
		else if(target_fore_dir == WEST)
			start_y = world.maxy - TRANSITIONEDGE - 2
			heading = SOUTH
		else
			start_y = TRANSITIONEDGE + 2
			heading = NORTH

	var/turf/start = locate(start_x, start_y, z_level)


	if(overmap_missile.dangerous)
		log_and_message_admins("A dangerous missile has entered z level [z_level] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)")


	// if we enter into a dense place, just detonate immediately
	if(start.contains_dense_objects())
		forceMove(start)
		detonate()
		return

	forceMove(start)

	// let missile equipment decide a target
	var/list/goal_coords = null
	for(var/obj/item/missile_equipment/E in equipment)
		var/list/coords = E.on_enter_level(z_level)
		if(coords)
			goal_coords = coords
			break

	// if a piece of equipment gave us a target, move towards that
	if(!isnull(goal_coords))
		var/turf/goal = locate(goal_coords[1], goal_coords[2], z_level)
		if(goal)
			walk_towards(src, goal, 1)
			return
	walk(src, heading, 1)
