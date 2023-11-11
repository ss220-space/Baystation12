#include "raider_vessel_areas.dm"

/obj/effect/overmap/visitable/sector/raider_vessel
	scanner_name = "Raider Vessel"
	scanner_desc = @{"<br>
		<i>Registration</i>: UNKNOWN<br>
		<i>Class</i>: Gunboat<br>
		<i>Transponder</i>: None Detected<br>
		<i>Note</i>: A vessel with a lot of debris on its hull and no signs of activity on board."}
	icon_state = "ship"
	color = "#354018"
	known = 0

	initial_generic_waypoints = list(
	"nav_raider_vessel_1",
	"nav_raider_vessel_2",
	"nav_raider_vessel_3",
	"nav_raider_vessel_antag"
	)

/datum/map_template/ruin/away_site/raider_vessel
	name = "Raider Vessel"
	id = "awaysite_raider_vessel"
	description = "Raider Vessel."
	prefix = "maps/away_inf/"
	suffixes = list("raider_vessel/raider_vessel.dmm")
	spawn_cost = 1
	area_usage_test_exempted_root_areas = list(/area/raider_vessel)

/obj/effect/shuttle_landmark/raider_vessel/nav1
	name = "Raider Vessel #1"
	landmark_tag = "nav_raider_vessel_1"

/obj/effect/shuttle_landmark/raider_vessel/nav2
	name = "Raider Vessel #2"
	landmark_tag = "nav_raider_vessel_2"

/obj/effect/shuttle_landmark/raider_vessel/nav3
	name = "Raider Vessel #3"
	landmark_tag = "nav_raider_vessel_3"

/obj/effect/shuttle_landmark/raider_vessel/navantag
	name = "Raider Vessel #4"
	landmark_tag = "nav_raider_vessel_antag"