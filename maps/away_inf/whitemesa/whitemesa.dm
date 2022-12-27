//#include "whitemesa_areas.dm"
//#include "whitemesa_shuttle.dm"

/obj/effect/overmap/visitable/sector/whitemesa
	scanner_name = "Deserted planetoid"
	scanner_desc = @{"[i]Stellar Body[/i]: UNKNOWN
[i]Class[/i]: L-Class Planetoid
[i]Habitability[/i]: Moderate (Medium Temperature)
[b]Notice[/b]: Sensor array detects an deserted planet with an encrypted NanoTrasen sygnal coming from the planet's surface. Scans further indicate EMI fields below the planet's surface."}
	sector_flags = 0
	color = "#fc0404"
	icon_state = "globe"
	start_x = 20
	start_y = 20
	initial_generic_waypoints = list(
		"nav_whitemesa_shuttle_dock",
		"nav_mesa_shuttle_start",
		"nav_mesa_shuttle_transition"
	)

/obj/effect/overmap/visitable/sector/whitemesa/New(nloc, max_x, max_y)
	name = "[generate_planet_name()], \a [name]"
	..()

/datum/map_template/ruin/away_site/whitemesa
	name = "White Mesa"
	id = "awaysite_mesa"
	description = "Half Life inspired underground base"
	spawn_cost = 0.01 // WAS 0.5
	prefix = "maps/away_inf/"
	suffixes = list("whitemesa/white_mesa1.dmm", "whitemesa/white_mesa2.dmm", "whitemesa/white_mesa3.dmm")
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/mesamule)

// Submap shuttles.
// Mule - Shuttle One, Port Side
/obj/effect/overmap/visitable/ship/landable/mesamule
	shuttle = "MesaMule"
	scanner_name = "Unknown Shuttle"
	scanner_desc = @{"[i]Registration[/i]: PRIVATE
[i]Class[/i]: Small Shuttle
[i]Transponder[/i]: Transmitting (CIV), non-hostile
[b]Notice[/b]: Small private vessel"}
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = WEST
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_SMALL

/obj/machinery/computer/shuttle_control/explore/mesamule
	name = "shuttle control console"
	shuttle_tag = "MesaMule"

/area/white_mesa/mesamule
	name = "Mesa Mule Area"
	icon_state = "yellow"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	req_access = list()

/obj/effect/shuttle_landmark/mesamule/start
	name = "MesaMule Docked"
	landmark_tag = "nav_mesamule_start"
	docking_controller = "mesamule_port_dock"
//	base_area = /area/liberia/DockingHall
//	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/datum/shuttle/autodock/overmap/mesamule
	name = "MesaMule"
	warmup_time = 5
	current_location = "nav_mesamule_start"
	range = 2
	dock_target = "mesamule_port_shuttle_dock"
	shuttle_area = list(/area/white_mesa/mesamule)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling

	//////////
	//TURFS///
	/////////

/turf/unsimulated/floor/away_inf/whitemesa/Zen_acid
	name = "Green Acid"
	desc = "It's unsafe to touch"
	icon = 'acid.dmi'
	icon_state = "riverwater_motion"
	temperature = 293
	color = "#33ff00"

/turf/unsimulated/floor/away_inf/whitemesa/Zen_acid/Initialize()
	.=..()

	set_light(0.7, 1, 5, l_color = "#3cff00")

/turf/unsimulated/floor/away_inf/whitemesa/Zen_floor
	name = "Xen floor"
	desc = "Am I really here?"
	icon = 'xen_turfs.dmi'
	icon_state = "xen_turf"
	temperature = 293

/turf/unsimulated/wall/away_inf/whitemesa/Zen
	name = "alien wall"
	desc = "You feel a sense of dread from just looking at this wall. Its surface seems to be constantly moving, as if it were breathing."
	icon = 'riverturfs.dmi'
	icon_state = "evilwall_1"
	opacity = TRUE
	density = TRUE
	temperature = 293
	color = "#3cff00"

/turf/unsimulated/wall/away_inf/whitemesa/Zen/Initialize()
	.=..()

	if(prob(80))
		icon_state = "evilwall_[rand(1,8)]"
