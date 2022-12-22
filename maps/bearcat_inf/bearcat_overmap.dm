/obj/effect/overmap/visitable/ship/bearcat
	name = "FTV Bearcat"
	scanner_name = "FTV Bearcat"
	color = "#00ffff"
	start_x = 4
	start_y = 4
	sector_flags = OVERMAP_SECTOR_KNOWN|OVERMAP_SECTOR_IN_SPACE|OVERMAP_SECTOR_BASE
	vessel_mass = 60
	max_speed = 1/(10 SECONDS)
	burn_delay = 10 SECONDS

	initial_generic_waypoints = list(
		"nav_bearcat_below_bow",
		"bearcat_starboard_dock",
		"bearcat_dock_port",
		"nav_bearcat_starboard_dock_pod",
		"nav_bearcat_port_dock_shuttle",
		"nav_bearcat_below_starboardastern",
		"nav_skipjack_deck1",
		"nav_skipjack_deck2",
		"nav_skipjack_deck3",
		"nav_skipjack_dock"
		)

	initial_restricted_waypoints = list(
		"Exploration Pod" = list("nav_bearcat_starboard_dock_pod"),
		"Exploration Shuttle" = list("nav_bearcat_port_dock_shuttle")
		)
