/obj/machinery/computer/shuttle_control/multi

/obj/machinery/computer/shuttle_control/multi/get_ui_data(var/datum/shuttle/autodock/multi/shuttle)
	. = ..()
	if(istype(shuttle))
		. += list(
			"destination_name" = shuttle.next_location? shuttle.next_location.name : "No destination set.",
			"can_pick" = shuttle.moving_status == SHUTTLE_IDLE,
		)
/obj/machinery/computer/shuttle_control/multi/handle_topic_href(var/datum/shuttle/autodock/multi/shuttle, action, list/params)
	.=..()

	switch(action)
		if("pick")
			var/dest_key = input("Choose shuttle destination", "Shuttle Destination") as null|anything in shuttle.get_destinations()
			if(dest_key)
				shuttle.set_destination(dest_key, usr)
			return TOPIC_REFRESH

/obj/machinery/computer/shuttle_control/multi/antag/get_ui_data(var/datum/shuttle/autodock/multi/antag/shuttle)
	. = ..()
	if(istype(shuttle))
		. += list(
			"cloaked" = shuttle.cloaked,
		)

/obj/machinery/computer/shuttle_control/multi/antag/handle_topic_href(var/datum/shuttle/autodock/multi/antag/shuttle, action, list/params)
	.=..()
	switch(action)
		if("toggle_cloaked")
			shuttle.cloaked = !shuttle.cloaked
			return TOPIC_REFRESH
