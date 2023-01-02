/datum/shuttle/autodock/overmap/snz
	name = "SNZ Speedboat"
	warmup_time = 5
	dock_target = "snz_shuttle"
	current_location = "nav_hangar_snz"
	range = 1
	shuttle_area = /area/ship/snz
	fuel_consumption = 7
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling/merc

/obj/machinery/computer/shuttle_control/explore/away_farfleet/snz
	name = "SNZ Shuttle control console"
	req_access = list(access_away_iccgn)
	shuttle_tag = "SNZ Speedboat"

/obj/effect/overmap/visitable/ship/landable/snz
	scanner_name = "SNZ Speedboat"
	scanner_desc = @{"[i]Registration[/i]: ICCGN Speedboat
[i]Class[/i]: Shuttle
[i]Transponder[/i]: Transmitting (MIL), ICCG
[b]Notice[/b]: SNZ-250 Speedboat. Space and atmosphere assault craft. The standard mass military production model of the Shipyards of Novaya Zemlya."}
	shuttle = "SNZ Speedboat"
	fore_dir = NORTH
	color = "#ff7300"
	vessel_mass = 11000
	vessel_size = SHIP_SIZE_SMALL
	contact_class = /decl/ship_contact_class/destroyer_escort

/area/ship/snz
	name = "\improper Fore Compartment"
	icon_state = "yellow"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	req_access = list(access_away_iccgn)

/obj/effect/shuttle_landmark/snz/start
	name = "SNZ Hangar"
	landmark_tag = "nav_hangar_snz"
	base_area = /area/ship/farfleet/command/snz_exterior_dock
	base_turf = /turf/simulated/floor/reinforced

/obj/effect/shuttle_landmark/snz/altdock
	name = "Docking Port"
	landmark_tag = "nav_hangar_snzalt"

/obj/effect/shuttle_landmark/snz/dock
	name = "NSV Sierra Dock"
	landmark_tag = "nav_snz_dock"
	docking_controller = "nuke_shuttle_dock_airlock"


	////////
	//TAGS//
	////////

/*/obj/effect/shuttle_landmark/reaper/hangar
	name = "Reaper Hangar"
	landmark_tag = "nav_hangar_reaper"
	base_area = /area/ship/patrol/command/hangar
	base_turf = /turf/simulated/floor/plating

/obj/effect/shuttle_landmark/reaper/transit
	name = "In transit"
	landmark_tag = "nav_transit_reaper"

/obj/effect/shuttle_landmark/reaper/tdock
	name = "SEV Torch Dock"
	landmark_tag = "nav_reaper_dock"
	docking_controller = "nuke_shuttle_dock_airlock" */
