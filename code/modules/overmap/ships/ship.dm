var/const/OVERMAP_SPEED_CONSTANT = (1 SECOND)
#define SHIP_MOVE_RESOLUTION 0.00001
#define MOVING(speed) abs(speed) >= min_speed
#define SANITIZE_SPEED(speed) SIGN(speed) * Clamp(abs(speed), 0, max_speed)
#define CHANGE_SPEED_BY(speed_var, v_diff) \
	v_diff = SANITIZE_SPEED(v_diff);\
	if(!MOVING(speed_var + v_diff)) \
		{speed_var = 0};\
	else \
		{speed_var = SANITIZE_SPEED((speed_var + v_diff)/(1 + speed_var*v_diff/(max_speed ** 2)))}
// Uses Lorentzian dynamics to avoid going too fast.

#define SENSOR_COEFFICENT 5

/obj/effect/overmap/visitable/ship
	name = "spacecraft"
	scanner_name = "spacecraft"
	desc = "This marker represents a spaceship. Scan it for more information."
	scanner_desc = "Unknown spacefaring vessel."
	icon_state = "ship"
	alpha = 255

	var/contact_icon_state
	var/class = "spacefaring vessel"
	var/moving_state = "ship_moving"
	var/transponder_active = FALSE //do we instantly identify ourselves to any ship?
	var/list/consoles

	var/sensor_visiblity //chance of showing up on sensors at all
	var/base_sensor_visibility
	var/identification_difficulty = 100 //How difficult are we to tick up identification on?

	var/vessel_mass = 10000             // tonnes, arbitrary number, affects acceleration provided by engines
	var/vessel_size = SHIP_SIZE_LARGE	// arbitrary number, affects how likely are we to evade meteors
	var/max_speed = 1/(1 SECOND)        // "speed of light" for the ship, in turfs/tick.
	var/min_speed = 1/(2 MINUTES)       // Below this, we round speed to 0 to avoid math errors.
	var/max_autopilot = 1 / (20 SECONDS) // The maximum speed any attached helm can try to autopilot at.
	var/list/linked_computers = list() //Linked computers, used for ease of communication between computers.
	var/list/known_ships = list() //List of ships known at roundstart - put types here.

	var/list/speed = list(0,0)          // speed in x,y direction
	var/list/position = list(0,0)       // position within a tile.
	var/last_burn = 0                   // worldtime when ship last acceleated
	var/burn_delay = 1 SECOND           // how often ship can do burns

	var/last_combat_roll = 0
	var/last_combat_turn = 0

	var/list/engines = list()
	var/engines_state = 0 //global on/off toggle for all engines
	var/thrust_limit = 1  //global thrust limit for all engines, 0..1
	var/halted = 0        //admin halt or other stop.
	var/skill_needed = SKILL_ADEPT  //piloting skill needed to steer it without going in random dir
	var/operator_skill


	var/ship_target = null
	var/planet_target = null
	var/missile_target
	var/planet_x = 1
	var/planet_y = 1
	var/coord_target_x = 10
	var/coord_target_y = 10

/obj/effect/overmap/visitable/ship/Initialize()
	. = ..()
	contact_icon_state = initial(icon_state)
	icon_state = "blank"
	glide_size = world.icon_size
	min_speed = round(min_speed, SHIP_MOVE_RESOLUTION)
	max_speed = round(max_speed, SHIP_MOVE_RESOLUTION)
	SSshuttle.ships += src
	START_PROCESSING(SSobj, src)
	base_sensor_visibility = get_base_sensor_visibility()

/obj/effect/overmap/visitable/ship/Destroy()
	STOP_PROCESSING(SSobj, src)
	SSshuttle.ships -= src

	for(var/obj/machinery/computer/ship/console in linked_computers)
		if(console.linked == src)
			console.linked = null
	linked_computers.Cut()

	for(var/obj/machinery/computer/ship/sensors/console in SSmachines.machinery)
		var/datum/overmap_contact/record = console.contact_datums[src]
		if(record)
			console.contact_datums[src] = null
			console.contact_datums -= null
			qdel(record)

	if(LAZYLEN(consoles))
		for(var/obj/machinery/computer/ship/machine in consoles)
			if(machine.linked == src)
				machine.linked = null
		consoles = null
	. = ..()

/obj/effect/overmap/visitable/ship/relaymove(mob/user, direction, accel_limit)
	accelerate(direction, accel_limit)
	update_operator_skill(user)


/**
 * Updates `operator_skill` to match the current user's skill level, or to null if no user is provided.
 * Will skip observers to avoid allowing unintended external influences on flight.
 */
/obj/effect/overmap/visitable/ship/proc/update_operator_skill(mob/user)
	if (isobserver(user))
		return
	operator_skill = user?.get_skill_value(SKILL_PILOT)


/obj/effect/overmap/visitable/ship/proc/is_still()
	return !MOVING(speed[1]) && !MOVING(speed[2])

/obj/effect/overmap/visitable/ship/get_scan_data(mob/user)
	. = ..()
	var/decl/ship_contact_class/class = decls_repository.get_decl(contact_class)
	. += "<br>Class: [class.class_long], mass [vessel_mass] tons."
	if(!is_still())
		. += {"\n<i>Heading</i>: [get_heading_degrees()]\n<i>Velocity</i>: [get_speed() * 1000]"}
	else
		. += {"\n<i>Vessel was stationary at time of scan.</i>\n"}

	var/life = 0

	for(var/mob/living/L in GLOB.living_mob_list_)
		if(L.z in map_z) //Things inside things we'll consider shielded, otherwise we'd want to use get_z(L)
			life++

	. += {"<i>Life Signs</i>: [life ? life : "None"]"}

//Projected acceleration based on information from engines
/obj/effect/overmap/visitable/ship/proc/get_acceleration()
	return round(get_total_thrust()/get_vessel_mass(), SHIP_MOVE_RESOLUTION)

//Does actual burn and returns the resulting acceleration
/obj/effect/overmap/visitable/ship/proc/get_burn_acceleration()
	return round(burn() / get_vessel_mass(), SHIP_MOVE_RESOLUTION)

/obj/effect/overmap/visitable/ship/proc/get_vessel_mass()
	. = vessel_mass
	for(var/obj/effect/overmap/visitable/ship/ship in src)
		. += ship.get_vessel_mass()

/obj/effect/overmap/visitable/ship/proc/get_speed()
	return round(sqrt(speed[1] ** 2 + speed[2] ** 2), SHIP_MOVE_RESOLUTION)

/obj/effect/overmap/visitable/ship/proc/get_heading()
	var/res = 0
	if(MOVING(speed[1]))
		if(speed[1] > 0)
			res |= EAST
		else
			res |= WEST
	if(MOVING(speed[2]))
		if(speed[2] > 0)
			res |= NORTH
		else
			res |= SOUTH
	return res

/obj/effect/overmap/visitable/ship/proc/get_heading_angle()
	var/res = 0
	if (MOVING(speed[1]) || MOVING(speed[2]))
		res = (round(Atan2(speed[1], -speed[2])) + 450)%360
	return res

/obj/effect/overmap/visitable/ship/proc/adjust_speed(n_x, n_y)
	CHANGE_SPEED_BY(speed[1], n_x)
	CHANGE_SPEED_BY(speed[2], n_y)
	for(var/zz in map_z)
		if(is_still())
			toggle_move_stars(zz)
		else
			toggle_move_stars(zz, fore_dir)
	update_icon()

/obj/effect/overmap/visitable/ship/proc/get_brake_path()
	if(!get_acceleration())
		return INFINITY
	if(is_still())
		return 0
	if(!burn_delay)
		return 0
	if(!get_speed())
		return 0
	var/num_burns = get_speed()/get_acceleration() + 2 //some padding in case acceleration drops form fuel usage
	var/burns_per_grid = 1/ (burn_delay * get_speed())
	return round(num_burns/burns_per_grid)

/obj/effect/overmap/visitable/ship/proc/decelerate(accel_limit)
	if ((!speed[1] && !speed[2]) || !can_burn())
		return
	last_burn = world.time
	var/delta = accel_limit ? min(get_burn_acceleration(), accel_limit) : get_burn_acceleration()
	var/mag = sqrt(speed[1] ** 2 + speed[2] ** 2)
	if (delta >= mag)
		adjust_speed(-speed[1], -speed[2])
	else
		adjust_speed(-(speed[1] * delta) / mag, -(speed[2] * delta) / mag)

/obj/effect/overmap/visitable/ship/proc/accelerate(direction, accel_limit)
	if (!direction || !can_burn())
		return
	last_burn = world.time
	var/delta = accel_limit ? min(get_burn_acceleration(), accel_limit) : get_burn_acceleration()
	var/dx = (direction & EAST) ? 1 : ((direction & WEST) ? -1 : 0)
	var/dy = (direction & NORTH) ? 1 : ((direction & SOUTH) ? -1 : 0)
	if (dx && dy)
		dx *= 0.5
		dy *= 0.5
	adjust_speed(delta * dx, delta * dy)

/obj/effect/overmap/visitable/ship/Process()
	if(!halted && !is_still())
		var/list/deltas = list(0,0)
		for(var/i = 1 to 2)
			if(MOVING(speed[i]))
				position[i] += speed[i] * OVERMAP_SPEED_CONSTANT
				if(position[i] < 0)
					deltas[i] = ceil(position[i])
				else if(position[i] > 0)
					deltas[i] = Floor(position[i])
				if(deltas[i] != 0)
					position[i] -= deltas[i]
					position[i] += (deltas[i] > 0) ? -1 : 1

		update_icon()
		var/turf/newloc = locate(x + deltas[1], y + deltas[2], z)
		if(newloc && loc != newloc)
			Move(newloc)
			handle_wraparound()
		update_icon()
	sensor_visiblity = get_total_sensor_vis()

/obj/effect/overmap/visitable/ship/on_update_icon()
	pixel_x = position[1] * (world.icon_size/2)
	pixel_y = position[2] * (world.icon_size/2)
	if(!is_still())
		contact_icon_state = moving_state
		dir = get_heading()
	else
		contact_icon_state = initial(icon_state)
	for(var/obj/machinery/computer/ship/machine in consoles)
		if(machine.z in map_z)
			for(var/weakref/W in machine.viewers)
				var/mob/M = W.resolve()
				if(istype(M) && M.client)
					M.client.pixel_x = pixel_x
					M.client.pixel_y = pixel_y
	..()

/obj/effect/overmap/visitable/ship/proc/burn()
	for(var/datum/ship_engine/E in engines)
		. += E.burn()

/obj/effect/overmap/visitable/ship/proc/get_total_thrust()
	for(var/datum/ship_engine/E in engines)
		. += E.get_thrust()

/obj/effect/overmap/visitable/ship/proc/can_burn()
	if(halted)
		return 0
	if (world.time < last_burn + burn_delay)
		return 0
	for(var/datum/ship_engine/E in engines)
		. |= E.can_burn()

//deciseconds to next step
/obj/effect/overmap/visitable/ship/proc/ETA()
	. = INFINITY
	for(var/i = 1 to 2)
		if(MOVING(speed[i]))
			. = min(., ((speed[i] > 0 ? 1 : -1) - position[i]) / speed[i])
	. = max(ceil(.),0)

/obj/effect/overmap/visitable/ship/proc/handle_wraparound()
	var/nx = x
	var/ny = y
	var/low_edge = 1
	var/high_edge = GLOB.using_map.overmap_size - 1

	if((dir & WEST) && x == low_edge)
		nx = high_edge
	else if((dir & EAST) && x == high_edge)
		nx = low_edge
	if((dir & SOUTH)  && y == low_edge)
		ny = high_edge
	else if((dir & NORTH) && y == high_edge)
		ny = low_edge
	if((x == nx) && (y == ny))
		return //we're not flying off anywhere

	var/turf/T = locate(nx,ny,z)
	if(T)
		forceMove(T)

/obj/effect/overmap/visitable/ship/proc/halt()
	adjust_speed(-speed[1], -speed[2])
	halted = 1

/obj/effect/overmap/visitable/ship/proc/unhalt()
	if(!SSshuttle.overmap_halted)
		halted = 0

/obj/effect/overmap/visitable/ship/Bump(var/atom/A)
	if(istype(A,/turf/unsimulated/map/edge))
		handle_wraparound()
	..()

/obj/effect/overmap/visitable/ship/proc/get_helm_skill()//delete this mover operator skill to overmap obj
	return operator_skill

/obj/effect/overmap/visitable/ship/populate_sector_objects()
	..()
	for(var/obj/machinery/computer/ship/S in SSmachines.machinery)
		S.attempt_hook_up(src)
	for(var/datum/ship_engine/E in ship_engines)
		if(check_ownership(E.holder))
			engines |= E

/obj/effect/overmap/visitable/ship/proc/get_landed_info()
	return "This ship cannot land."


/obj/effect/overmap/visitable/ship/proc/check_target(obj/effect/overmap/target)
	if(target in view(7, src))
		return TRUE
	return FALSE

/obj/effect/overmap/visitable/ship/proc/get_target(var/target_type)
	if(target_type == TARGET_SHIP)
		if(ship_target && check_target(ship_target))
			return ship_target

	if(target_type == TARGET_MISSILE)
		if(missile_target && check_target(missile_target))
			return missile_target

	if(target_type == TARGET_POINT)
		return list(coord_target_x, coord_target_y)

	if(target_type == TARGET_PLANET)
		if(planet_target && check_target(planet_target))
			return list(planet_target, planet_x, planet_y)
		else
			return list(null, planet_x, planet_y)

	if(target_type == TARGET_PLANETCOORD)
		return list(planet_x, planet_y)

	return null

/obj/effect/overmap/visitable/ship/proc/set_target(var/target_type, var/obj/effect/overmap/target, var/target_x, var/target_y)
	if(target_type == TARGET_SHIP)
		if(target && check_target(target))
			ship_target = target
			return TRUE

	if(target_type == TARGET_MISSILE)
		if(target && check_target(target))
			missile_target = target
			return TRUE

	if(target_type == TARGET_POINT)
		coord_target_x = target_x
		coord_target_y = target_y

	if(target_type == TARGET_PLANET)
		if(target && check_target(target))
			planet_target = target
			planet_x = target_x
			planet_y = target_y
			return TRUE
		else
			planet_x = target_x
			planet_y = target_y

	return FALSE



obj/effect/overmap/visitable/ship/proc/get_base_sensor_visibility()
	var/sensor_vis

	sensor_vis = round((vessel_mass/SENSOR_COEFFICENT),1)

	return sensor_vis

/obj/effect/overmap/visitable/ship/proc/get_engine_sensor_increase()
	var/thrust_calc
	for(var/datum/ship_engine/E in engines)
		if(E.is_on())
			thrust_calc += (E.get_thrust_limit() * 2)

	return min(thrust_calc, 50) //Engines should never increase sensor visibility by more than 50.

/obj/effect/overmap/visitable/ship/proc/get_total_sensor_vis()
	var/new_sensor_vis = (base_sensor_visibility + get_engine_sensor_increase())

	return min(new_sensor_vis, 100)

// Get heading in degrees (like a compass heading)
/obj/effect/overmap/visitable/ship/proc/get_heading_degrees()
	return (Atan2(speed[2], speed[1]) + 360) % 360 // Yes ATAN2(y, x) is correct to get clockwise degrees

/obj/effect/overmap/visitable/ship/get_distress_info()
	var/turf/T = get_turf(src) // Usually we're on the turf, but sometimes we might be landed or something.
	var/x_to_use = T?.x || "UNK"
	var/y_to_use = T?.y || "UNK"
	return "\[X:[x_to_use], Y:[y_to_use], VEL:[get_speed() * 1000], HDG:[get_heading_degrees()]\]"

/obj/effect/overmap/visitable/ship/proc/can_combat_roll()
	if(!can_burn())
		return FALSE
	var/cooldown = min(vessel_mass / 100, 100) SECONDS
	if(world.time >= (last_combat_roll + cooldown))
		return TRUE
	return FALSE

/obj/effect/overmap/visitable/ship/proc/can_combat_turn()
	if(!can_burn())
		return FALSE
	var/cooldown = min(vessel_mass / 200, 20) SECONDS
	if(world.time >= (last_combat_turn + cooldown))
		return TRUE
	return FALSE

/obj/effect/overmap/visitable/ship/proc/combat_roll(var/new_dir)
	burn()
	forceMove(get_step(src, new_dir))
	for(var/mob/living/L in GLOB.living_mob_list_)
		if(L.z in map_z)
			to_chat(L, SPAN_DANGER("<font size=4>The ship rapidly inclines under your feet!</font>"))
			if(!L.buckled)
				var/turf/T = get_step_away(get_turf(L), get_step(L, new_dir), 10)
				L.throw_at(T, 4, 3)
			shake_camera(L, 2 SECONDS, 10)
			sound_to(L, sound('sound/effects/combatroll.ogg'))
	last_combat_roll = world.time

/obj/effect/overmap/visitable/ship/proc/combat_turn(var/new_dir)
	burn()
	var/angle = 45
	if(new_dir == WEST)
		angle = -45
	dir = turn(dir, angle)
	for(var/mob/living/L in GLOB.living_mob_list_)
		if(L.z in map_z)
			to_chat(L, SPAN_DANGER("The ship rapidly turns under your feet!"))
			if(!L.buckled)
				L.Weaken(3)
			shake_camera(L, 1 SECOND, 2)
			sound_to(L, sound('sound/machines/thruster.ogg'))
	last_combat_turn = world.time

#undef MOVING
#undef SANITIZE_SPEED
#undef CHANGE_SPEED_BY
