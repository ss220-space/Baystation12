/datum/map_template/ruin/antag_spawn/paramount
	name = "Paramount Base"
	suffixes = list("paramount/paramount_base.dmm")
	apc_test_exempt_areas = list(
		/area/map_template/paramount_den = NO_SCRUBBER|NO_VENT|NO_APC
	)


// Areas
/area/map_template/paramount_den
	name = "\improper Paramount Base"
	icon_state = "green"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	req_access = list(access_syndicate)

/area/map_template/paramount_den/den
	name = "\improper Paramount Base"
	dynamic_lighting = 0
