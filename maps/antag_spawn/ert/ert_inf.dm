/datum/map_template/ruin/antag_spawn/ert
	name = "ERT Base"
	suffixes = list("ert/ert_base_inf.dmm")
	shuttles_to_initialise = list(/datum/shuttle/autodock/multi/antag/rescue)
	apc_test_exempt_areas = list(
		/area/map_template/rescue_base = NO_SCRUBBER|NO_VENT|NO_APC
	)

/datum/shuttle/autodock/multi/antag/rescue
	name = "Rescue"
	warmup_time = 7
	defer_initialisation = TRUE
	destination_tags = list(
		"nav_ert_dock",
		"nav_ert_start"
		)
	shuttle_area = /area/map_template/rescue_base/start
	dock_target = "rescue_shuttle"
	current_location = "nav_ert_start"
	landmark_transition = "nav_ert_transition"
	home_waypoint = "nav_ert_start"
	announcer = "Proximity Sensor Array"
	arrival_message = "Attention, vessel detected entering vessel proximity."
	departure_message = "Attention, vessel detected leaving vessel proximity."
	ceiling_type = /turf/simulated/floor/shuttle_ceiling

/obj/effect/shuttle_landmark/ert/start
	name = "Response Team Base"
	landmark_tag = "nav_ert_start"
	docking_controller = "rescue_base"
	base_turf = /turf/unsimulated/floor/rescue_base

/obj/effect/shuttle_landmark/ert/internim
	name = "In transit"
	landmark_tag = "nav_ert_transition"

/obj/effect/shuttle_landmark/ert/dock
	name = "Docking Port"
	landmark_tag = "nav_ert_dock"
	docking_controller = "rescue_shuttle_dock_airlock"

// Areas

/area/map_template/rescue_base
	name = "\improper Response Team Base"
	icon_state = "yellow"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT

/area/map_template/rescue_base/base
	name = "\improper Barracks"
	icon_state = "yellow"
	req_access = list(access_cent_general)
	dynamic_lighting = 0

/area/map_template/rescue_base/office
	name = "\improper Office"
	icon_state = "red"
	req_access = list(access_cent_captain)
	dynamic_lighting = 0

/area/map_template/rescue_base/torture
	name = "\improper Torture"
	icon_state = "red"

/area/map_template/rescue_base/start
	name = "\improper Response Team Base"
	icon_state = "shuttlered"
	req_access = list(access_cent_general)
	base_turf = /turf/unsimulated/floor/rescue_base

//Objects

/obj/item/device/radio/headset/ert
	name = "emergency response team radio headset"
	desc = "The headset of the boss's boss."
	icon_state = "com_headset"
	item_state = "headset"
	ks1type = /obj/item/device/encryptionkey/ert

/obj/item/device/radio/headset/ert/Initialize()
	. = ..()
	set_frequency(ERT_FREQ)

/obj/item/stock_parts/circuitboard/telecomms/allinone/ert
	build_path = /obj/machinery/telecomms/allinone/ert

/obj/machinery/telecomms/allinone/ert
	listening_freqs = list(ERT_FREQ)
	channel_color = COMMS_COLOR_CENTCOMM
	channel_name = "Response Team"
	circuitboard = /obj/item/stock_parts/circuitboard/telecomms/allinone/ert

/obj/item/clothing/accessory/ert
	name = "NT asset protection patch"
	desc = "A combination of patches carrying insignia of NanoTrasen forward base Kodai-624, tasked with emergency response operations."
	icon = 'icons/obj/clothing/obj_accessories.dmi'
	accessory_icons = list(slot_w_uniform_str = 'icons/mob/onmob/onmob_accessories.dmi', slot_wear_suit_str = 'icons/mob/onmob/onmob_accessories.dmi')
	icon_state = "ert"
	w_class = ITEM_SIZE_TINY
	slot = ACCESSORY_SLOT_INSIGNIA	
	on_rolled = list("down" = "none")

/obj/item/clothing/accessory/ert/sec
	name = "ERT security insignia"
	desc = "Insignia denoting a security member of the emergency response team."
	icon_state = "ert_sec"
	slot = ACCESSORY_SLOT_DEPT

/obj/item/clothing/accessory/ert/lead
	name = "ERT leader insignia"
	desc = "Insignia denoting a leader of the emergency response team."
	icon_state = "ert_lead"
	slot = ACCESSORY_SLOT_DEPT

/obj/item/clothing/accessory/ert/eng
	name = "ERT engineering insignia"
	desc = "Insignia denoting an engineer of the emergency response team."
	icon_state = "ert_eng"
	slot = ACCESSORY_SLOT_DEPT

/obj/item/clothing/accessory/ert/med
	name = "ERT medical insignia"
	desc = "Insignia denoting a medic of the emergency response team."
	icon_state = "ert_med"
	slot = ACCESSORY_SLOT_DEPT