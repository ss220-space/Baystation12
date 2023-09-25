#include "medical_ship_areas.dm"
#include "medical_ship_jobs.dm"
#include "medical_ship_access.dm"

/obj/effect/submap_landmark/joinable_submap/medical_ship
	name = "Medical Ship"
	archetype = /decl/submap_archetype/derelict/bearcat

/decl/submap_archetype/derelict/medical_ship
	descriptor = "Medical Ship"
	map = "Search and Rescue Vessel"
	crew_jobs = list(
		/datum/job/submap/medical_ship_pilot,
		/datum/job/submap/medical_ship_technician
		/datum/job/submap/medical_ship_medic
	)

/obj/effect/overmap/visitable/ship/medical_ship
	name = "SRV"
	scanner_name = "SRV [pick("Flamingo", "Archimedes", "Mockbird", "Dove")], \a [name]"
	color = "#00ffff"
	vessel_mass = 60
	max_speed = 1/(10 SECONDS)
	burn_delay = 5 SECONDS
	contact_class = /decl/ship_contact_class/ship
	initial_restricted_waypoints = list(
		"Exploration Shuttle" = list("nav_bearcat_port_dock_shuttle"),
	)

/datum/map_template/ruin/away_site/medical_ship
	name = "Medical Ship"
	id = "awaysite_medical_ship"
	description = "An emergency rescue ship on a patrol mission."
	prefix = "maps/away_inf/"
	suffixes = list("medical_ship.dmm")
	spawn_cost = 0.5 // INF, WAS 1
	player_cost = 4 // Нынешнее значение основано на количестве игроков в авейке ~bear1ake
	spawn_weight = 1 // INF, spawn_weight = 0.67
	// todo:
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/exploration)
	area_usage_test_exempted_root_areas = list(/area/medical_ship)


/obj/machinery/power/apc/derelict/medical_ship
	cell_type = /obj/item/cell/crap
	lighting = 1
	equipment = 1
	environ = 1
	locked = 1
	coverlocked = 1

/obj/machinery/door/airlock/autoname/command
	door_color = COLOR_COMMAND_BLUE

/obj/machinery/door/airlock/autoname/engineering
	door_color = COLOR_AMBER

//todolist:
/datum/shuttle/autodock/overmap/exploration
	name = "Exploration Shuttle"
	shuttle_area = list(/area/ship/scrap/shuttle/outgoing)
	dock_target = "bearcat_shuttle"
	current_location = "nav_bearcat_port_dock_shuttle"
	logging_home_tag = "nav_bearcat_port_dock_shuttle"
	logging_access = access_bearcat
	range = 1
	fuel_consumption = 3
	warmup_time = 7
	defer_initialisation = TRUE

/obj/machinery/computer/shuttle_control/explore/bearcat
	name = "shuttle console"
	shuttle_tag = "Exploration Shuttle"

/obj/effect/shuttle_landmark/bearcat_shuttle
	name = "Port Shuttle Dock"
	landmark_tag = "nav_bearcat_port_dock_shuttle"
	docking_controller = "bearcat_dock_port"

/obj/effect/shuttle_landmark/bearcat_shuttle/sierra
	name = "Fore Shuttle Dock"
	landmark_tag = "nav_deck3_bearcat"
	docking_controller = "nuke_shuttle_dock_airlock"
