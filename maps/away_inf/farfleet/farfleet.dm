#include "farfleet_areas.dm"
#include "farfleet_crew.dm"
#include "farfleet_items.dm"
#include "farfleet_presets.dm"
#include "farfleet_shuttle.dm"
#include "farfleet_structures.dm"
#include "farfleet_turbolift.dm"

	///////////
	//OVERMAP//
	///////////

/obj/effect/overmap/visitable/ship/farfleet
	name = "Farfleet Reconnaissance Craft"
	scanner_name = "Farfleet Reconnaissance Craft"
	scanner_desc = @{"[i]Registration[/i]: ICCGN Farfleet Reconnaissance Craft
[i]Transponder[/i]: Transmitting (MIL), ICCG
[b]Notice[/b]: Proect-2880 Gagarin-Class Farfleet Reconnaissance Craft. This Craft has ICCGN Farfleet designation. Future scanning of ship internals scrambled."}
	contact_class = /decl/ship_contact_class/gagarin
	color = "#fc7a00"
	fore_dir = WEST
	vessel_mass = 27500
	known_ships = list(/obj/effect/overmap/visitable/ship/landable/snz)
	vessel_size = SHIP_SIZE_SMALL
	start_x = 39
	start_y = 39

	initial_generic_waypoints = list(
		"nav_farfleet_1",
		"nav_farfleet_2",
		"nav_farfleet_3",
		"nav_farfleet_4",
		"nav_dock_snz"
		)

	initial_restricted_waypoints = list(
	"SNZ-250" = list("nav_dock_snz")
		)


/obj/effect/overmap/visitable/ship/farfleet/New()
	scanner_name = "FRC [pick("Onyx","Zircon","Grad","Zirkel","Odessa","Gomel","Uragan","Shilka","Omsk","Krondstatt","Topol","Iron Dmitry","Buratino","Kerch","Kherson","Proryv","Triumph","Sochi","Elisarov","Engels","Magnitogorsk")], \a [name]"
	for(var/area/ship/farfleet/A)
		A.name = "\improper [name] - [A.name]"
		GLOB.using_map.area_purity_test_exempt_areas += A.type
	..()


/datum/map_template/ruin/away_site/farfleet
	name = "Farfleet Reconnaissance Craft (FRC)"
	id = "awaysite_recon_ship"
	description = "Proect-2880 Gagarin-Class Farfleet Reconnaissance Craft."
	prefix = "maps/away_inf/"
	suffixes = list("farfleet/farfleet-1.dmm", "farfleet/farfleet-2.dmm")
	spawn_cost = 0.5
	player_cost = 7 // Нынешнее значение основано на количестве игроков в авейке ~bear1ake
	spawn_weight = 1 // INF, spawn_weight = 0.5
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/snz)


/obj/effect/shuttle_landmark/nav_farfleet/nav1
	name = "Recon Ship Fore"
	landmark_tag = "nav_farfleet_1"

/obj/effect/shuttle_landmark/nav_farfleet/nav2
	name = "Recon Ship Aft"
	landmark_tag = "nav_farfleet_2"

/obj/effect/shuttle_landmark/nav_farfleet/nav3
	name = "Recon Ship Port"
	landmark_tag = "nav_farfleet_3"

/obj/effect/shuttle_landmark/nav_farfleet/nav4
	name = "Recon Ship Starboard"
	landmark_tag = "nav_farfleet_4"

/obj/effect/submap_landmark/joinable_submap/farfleet
	name = "ICCGN Farfleet Ship"
	archetype = /decl/submap_archetype/away_iccgn_farfleet

//obj/machinery/door/airlock/autoname/command
	//req_access = list(access_heads)

//obj/machinery/door/airlock/autoname/engineering
	//req_access = list(access_engine)

//obj/machinery/door/airlock/autoname/marine
	//req_access = list(access_security)

/* TCOMMS
 * ======
 */

/obj/machinery/telecomms/allinone/iccgn
	listening_freqs = list(ICCGN_FREQ)
	channel_color = COMMS_COLOR_ICCG
	channel_name = "ICGN Ship"
	circuitboard = /obj/item/stock_parts/circuitboard/telecomms/allinone/iccgn


//Items
/obj/item/device/radio/headset/iccgn
	name = "iccgn headset"
	desc = "Headset belonging to an ICCGN operative."
	icon_state = "syndie_headset"
	item_state = "headset"
	ks1type = /obj/item/device/encryptionkey/iccgn

/obj/item/device/radio/headset/iccgn/Initialize()
	. = ..()
	set_frequency(ICCGN_FREQ)

/obj/item/device/encryptionkey/iccgn
	name = "\improper ICCGN radio encryption key"
	channels = list("ICGN Ship" = 1)

/obj/item/stock_parts/circuitboard/telecomms/allinone/iccgn
	build_path = /obj/machinery/telecomms/allinone/iccgn

/decl/ship_contact_class/gagarin
	class_short = "GRC"
	class_long = "Gagarin-Class recon craft"
	max_ship_mass = 20000
