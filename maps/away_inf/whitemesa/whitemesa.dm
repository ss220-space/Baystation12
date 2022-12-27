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
		"nav_blueriv_1",
	)
	initial_restricted_waypoints = list(
		"Cometa" = list("nav_blueriver_shuttle"),
	)

/obj/effect/overmap/visitable/sector/whitemesa/New(nloc, max_x, max_y)
	name = "[generate_planet_name()], \a [name]"
	..()

/datum/map_template/ruin/away_site/whitemesa
	name = "White Mesa"
	id = "awaysite_mesa"
	description = "Half Life inspired underground base"
	spawn_cost = 1 // WAS 0.5
	prefix = "maps/away_inf/"
	suffixes = list("whitemesa/white_mesa1.dmm", "whitemesa/white_mesa2.dmm", "whitemesa/white_mesa3.dmm")
	shuttles_to_initialise = list(/datum/shuttle/autodock/multi/antag/mesa_shuttle)

/datum/shuttle/autodock/multi/antag/mesa_shuttle
	name = "Mesa Shuttle"
	warmup_time = 7
	defer_initialisation = TRUE
	destination_tags = list(
		"nav_whitemesa_shuttle_dock",
		"nav_mesa_shuttle_start"
		)
	shuttle_area = /area/map_template/mesa_shuttle/start
	dock_target = "rescue_shuttle"
	current_location = "nav_mesa_shuttle_start"
	landmark_transition = "nav_mesa_shuttle_transition"
	home_waypoint = "nav_mesa_shuttle_start"
	announcer = "Proximity Sensor Array"
	arrival_message = "Attention, vessel detected entering vessel proximity."
	departure_message = "Attention, vessel detected leaving vessel proximity."
	ceiling_type = /turf/simulated/floor/shuttle_ceiling

/obj/effect/shuttle_landmark/mesa_shuttle/start
	name = "White Mesa Landing Zone"
	landmark_tag = "nav_mesa_shuttle_start"
	docking_controller = "rescue_base"
	base_turf = /turf/unsimulated/floor/rescue_base

/obj/effect/shuttle_landmark/whitemesa/internim
	name = "In transit"
	landmark_tag = "nav_mesa_shuttle_transition"

/obj/effect/shuttle_landmark/whitemesa/dock
	name = "Sierra Docking Port"
	landmark_tag = "nav_whitemesa_shuttle_dock"
	docking_controller = "rescue_shuttle_dock_airlock"

/area/map_template/mesa_shuttle/start
	name = "\improper Mesa Shuttle Start"
	icon_state = "shuttlered"
	req_access = list(access_cent_general)
	base_turf = /turf/unsimulated/floor/rescue_base

	//////////
	//TURFS///
	/////////

/turf/simulated/floor/away_inf/whitemesa/Zen_acid
	name = "Green Acid"
	desc = "It's unsafe to touch"
	icon = 'acid.dmi'
	icon_state = "riverwater_motion"
	temperature = 233

/turf/simulated/floor/away_inf/whitemesa/Zen/Initialize()
	.=..()

	set_light(0.7, 1, 5, l_color = "#3cff00")

/turf/simulated/floor/away_inf/whitemesa/Zen_floor
	name = "Xen floor"
	desc = "Am I really here?"
	icon = 'xen_turfs.dmi'
	icon_state = "xen_turf"
	temperature = 233
	color = "#23685c"

/turf/unsimulated/wall/away_inf/whitemesa/Zen
	name = "alien wall"
	desc = "You feel a sense of dread from just looking at this wall. Its surface seems to be constantly moving, as if it were breathing."
	icon = 'riverturfs.dmi'
	icon_state = "evilwall_1"
	opacity = TRUE
	density = TRUE
	temperature = 233
	color = "#3cff00"

/turf/unsimulated/wall/away_inf/blueriver/livingwall/Initialize()
	.=..()

	if(prob(80))
		icon_state = "evilwall_[rand(1,8)]"
