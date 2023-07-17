/obj/machinery/computer/shuttle_control
	name = "shuttle control console"
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "atmos_key"
	icon_screen = "shuttle"
	base_type = /obj/machinery/computer/shuttle_control
	machine_name = "basic shuttle console"
	machine_desc = "A simple control system for small spacecraft, allowing automated movement from one navigation point to another."

	var/shuttle_tag  // Used to coordinate data in shuttle controller.
	var/hacked = 0   // Has been emagged, no access restrictions.

	var/ui_template = "ShuttleControlConsole"

/* TGUI */

/obj/machinery/computer/shuttle_control/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/shuttle_control/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src,  ui_template, "[shuttle_tag] Shuttle Control") // 420, 530
		ui.open()


/obj/machinery/computer/shuttle_control/tgui_data(mob/user)
	var/datum/shuttle/autodock/shuttle = SSshuttle.shuttles[shuttle_tag]
	if (!istype(shuttle))
		to_chat(user,"<span class='warning'>Unable to establish link with the shuttle.</span>")
		return

	var/list/data = get_ui_data(shuttle)
	var/mob/living/silicon/silicon = user
	data["viewing_silicon"] = ismachinerestricted(silicon)
	return data

/obj/machinery/computer/shuttle_control/tgui_act(action, list/params)
	UI_ACT_CHECK
	handle_topic_href(SSshuttle.shuttles[shuttle_tag], action, params)


/* Наследуемые методы классовых консолей */

/obj/machinery/computer/shuttle_control/proc/get_ui_data(var/datum/shuttle/autodock/shuttle)
	var/shuttle_state = "ERROR"
	switch(shuttle.moving_status)
		if(SHUTTLE_IDLE) shuttle_state = "IDLE"
		if(SHUTTLE_WARMUP) shuttle_state = "STARTING IGNITION"
		if(SHUTTLE_INTRANSIT) shuttle_state = "ENGAGED"

	var/timeleft  = "NONE"
	switch(shuttle.moving_status)
		if(SHUTTLE_WARMUP) shuttle_state = "CALIBRATING"
		if(SHUTTLE_INTRANSIT)
			if(max(round((shuttle.arrive_time - world.time) / 10, 1), 0) > 0)
				timeleft = max(round((shuttle.arrive_time - world.time) / 10, 1), 0)
			else
				timeleft = "IMMTNENT"

	var/shuttle_status
	switch (shuttle.process_state)
		if(IDLE_STATE)
			var/cannot_depart = shuttle.current_location.cannot_depart(shuttle)
			if (shuttle.in_use)
				shuttle_status = "Busy."
			else if(cannot_depart)
				shuttle_status = cannot_depart
			else
				shuttle_status = "Standing-by at \the [shuttle.get_location_name()]."

		if(WAIT_LAUNCH, FORCE_LAUNCH)
			shuttle_status = "Shuttle has received command and will depart shortly."
		if(WAIT_ARRIVE)
			shuttle_status = "Proceeding to \the [shuttle.get_destination_name()]."
		if(WAIT_FINISH)
			shuttle_status = "Arriving at destination now."

	var/data = list()
	var/docking_status = shuttle.shuttle_docking_controller? shuttle.shuttle_docking_controller.get_docking_status() : null
	var/docking_override = shuttle.shuttle_docking_controller? shuttle.shuttle_docking_controller.override_enabled : null
	data["docking_status"] = "ERROR"
	switch(docking_status)
		if("docked")
			data["docking_status"] = "DOCKED"
		if("docking")
			if (docking_override)
				data["docking_status"] = "DOCKING"
			else
				data["docking_status"] = "DOCKING-MANUAL"
		if("undocking")
			if(docking_override)
				data["docking_status"] = "UNDOCKING"
			else
				data["docking_status"] = "UNDOCKING-MANUAL"
		if("undocked")
			data["docking_status"] = "UNDOCKED"

	data["shuttle_status"] = shuttle_status
	data["shuttle_state"] = shuttle_state
	data["has_docking"] = shuttle.shuttle_docking_controller
	data["can_launch"] = shuttle.can_launch()
	data["can_cancel"] = shuttle.can_cancel()
	data["can_force"] = shuttle.can_force()
	data["timeleft"] = timeleft
	data["docking_codes"] = shuttle.docking_codes
	data["is_docking_codes"] = TRUE
	return data


/obj/machinery/computer/shuttle_control/proc/handle_topic_href(var/datum/shuttle/autodock/shuttle, action, list/params)
	.=TRUE

	switch(action)
		if("move")
			if(can_move(shuttle, usr))
				shuttle.launch(src)
				return TOPIC_REFRESH
			return TOPIC_HANDLED

		if("force")
			if(can_move(shuttle, usr))
				shuttle.force_launch(src)
				return TOPIC_REFRESH
			return TOPIC_HANDLED

		if("cancel")
			shuttle.cancel_launch(src)
			return TOPIC_REFRESH

		if("set_codes")
			var/newcode = input("Input new docking codes", "Docking codes", shuttle.docking_codes) as text|null
			if (newcode)
				shuttle.set_docking_codes(uppertext(newcode))
			return TOPIC_REFRESH

// This is a subset of the actual checks; contains those that give messages to the user.
/obj/machinery/computer/shuttle_control/proc/can_move(var/datum/shuttle/autodock/shuttle, var/user)
	var/cannot_depart = shuttle.current_location.cannot_depart(shuttle)
	if(cannot_depart)
		to_chat(user, SPAN_WARNING(cannot_depart))
		return FALSE
	if(!shuttle.next_location.is_valid(shuttle))
		to_chat(user, SPAN_WARNING("Destination zone is invalid or obstructed."))
		return FALSE
	return TRUE

/obj/machinery/computer/shuttle_control/emag_act(var/remaining_charges, var/mob/user)
	if (!hacked)
		req_access = list()
		hacked = 1
		to_chat(user, "You short out the console's ID checking system. It's now available to everyone!")
		return 1

/obj/machinery/computer/shuttle_control/bullet_act(var/obj/item/projectile/Proj)
	visible_message("\The [Proj] ricochets off \the [src]!")

/obj/machinery/computer/shuttle_control/ex_act()
	return

/obj/machinery/computer/shuttle_control/emp_act()
	return
