/datum/map_template/ruin/antag_spawn/mercenary
	name = "Mercenary Base"
	suffixes = list("mercenary/mercenary_base_inf.dmm")
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/merc_shuttle)

/obj/effect/overmap/visitable/merc_base
	name = "TCV Tersten Tenacity"
	desc = "Sensor array detects a medium cargo vessel with high structural damage."
	sector_flags = OVERMAP_SECTOR_IN_SPACE
	icon_state = "ship"
	hide_from_reports = TRUE
	initial_generic_waypoints = list(
		"nav_merc_start",
		"nav_merc_1",
		"nav_merc_2",
		"nav_merc_3",
		"nav_merc_4"
	)
	has_distress_beacon = "SOS - multiple breaches, possible hostiles"

/obj/effect/overmap/visitable/ship/landable/merc
	desc = "Spacefaring vessel. No IFF detected."
	scanner_desc = @{"[i]Registration[/i]: UNKNOWN
[i]Class[/i]: UNKNOWN
[i]Transponder[/i]: None Detected
[b]Notice[/b]: Unregistered vessel"}
	shuttle = "Desperado"
	fore_dir = NORTH
	vessel_size = SHIP_SIZE_SMALL
	vessel_mass = 14000
	contact_class = /decl/ship_contact_class/destroyer_escort

/obj/effect/overmap/visitable/ship/landable/merc/New()
	var/list/desperado_name = list(
		"Desperado",
		"SEV Torch",
		"SEV Icarus",
		"Yacht",
		"Lar Maria",
		"SRV Verne",
		"SRV Catfish",
		"IEV Vagrant",
		"Cometa",
		"Guppy",
		"Charon",
		"Liberia",
		"Mule",
		"Knight",
		"Los Zetas",
		"Trinitario",
		"Mayhem",
		"Emperor",
		"Blasphemy",
		"Malign",
		"Nifelheim",
		"Gorgoroth",
		"Ndrangheta",
		"Penose",
		"Zevallos",
		"Eagle",
		"Artistas",
		"Red-Wa",
		"SFV Cavalry",
		"SFV Helios",
		"SFV Terror"
	)
	scanner_name = pick(desperado_name)
	for(var/area/map_template/merc_shuttle/A)
		A.name = "\improper [name] - [A.name]"
		GLOB.using_map.area_purity_test_exempt_areas += A.type
	..()

/*    на случай, если понадобится сделать выбор имён из списка для базы тоже
/obj/effect/overmap/visitable/merc_base/New()
	name = "SFV [pick("alfa","beta","gamma")], \a [name]"
	for(var/area/map_template/merc_spawn/A)
		A.name = "\improper [name] - [A.name]"
		GLOB.using_map.area_purity_test_exempt_areas += A.type
	..()
*/
/datum/shuttle/autodock/overmap/merc_shuttle
	name = "Desperado"
	shuttle_area = list(/area/map_template/merc_shuttle,/area/map_template/merc_shuttle/rear)
	dock_target = "merc_shuttle"
	current_location = "nav_merc_start"
	defer_initialisation = TRUE
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/merc
	warmup_time = 5
	range = 1
	fuel_consumption = 7
	skill_needed = SKILL_BASIC

/turf/simulated/floor/shuttle_ceiling/merc
	color = COLOR_RED

/obj/machinery/computer/shuttle_control/explore/merc_shuttle
	name = "shuttle control console"
	shuttle_tag = "Desperado"

/obj/effect/shuttle_landmark/merc/start
	name = "TCV Tersten Tenacity - Breach"
	landmark_tag = "nav_merc_start"

/obj/effect/shuttle_landmark/merc/nav1
	name = "TCV Tersten Tenacity - South-West"
	landmark_tag = "nav_merc_1"

/obj/effect/shuttle_landmark/merc/nav2
	name = "TCV Tersten Tenacity - South-East"
	landmark_tag = "nav_merc_2"

/obj/effect/shuttle_landmark/merc/nav3
	name = "TCV Tersten Tenacity - North-East"
	landmark_tag = "nav_merc_3"

/obj/effect/shuttle_landmark/merc/nav4
	name = "TCV Tersten Tenacity - North-West"
	landmark_tag = "nav_merc_4"

/obj/effect/shuttle_landmark/merc/dock
	name = "Docking Port"
	landmark_tag = "nav_merc_dock"

/obj/effect/shuttle_landmark/transit/merc
	name = "In transit"
	landmark_tag = "nav_transit_merc"

//Areas

/area/map_template/merc_spawn
	name = "\improper TCV Tersten Tenacity"
	icon_state = "syndie-ship"
	req_access = list(access_syndicate)
	area_flags = AREA_FLAG_IS_NOT_PERSISTENT

/area/map_template/merc_shuttle
	name = "\improper Fore Compartment"
	icon_state = "yellow"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_syndicate)

/area/map_template/merc_shuttle/rear
	name = "\improper Rear Compartment"
	icon_state = "green"

//[INF]
/obj/machinery/vending/medical/torch
	req_access = list(access_medical)
//[/INF]
