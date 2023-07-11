//Engine control and monitoring console

/obj/machinery/computer/ship/engines
	name = "engine control console"
	icon_keyboard = "tech_key"
	icon_screen = "engines"
	machine_name = "engine control console"
	machine_desc = "Allows remote control of a spacecraft's gas thrusters, and displays information about remaining fuel."
	var/display_state = "status"

/obj/machinery/computer/ship/engines/adv
	icon_keyboard = null
	icon_state = "adv_engines"
	icon_screen = "adv_engines_screen"
	light_color = "#05A6A8"
	base_type = /obj/machinery/computer/ship/engines

/obj/machinery/computer/ship/engines/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/ship/engines/tgui_interact(mob/user, var/datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ShipEngines", name)
		ui.open()

/obj/machinery/computer/ship/engines/tgui_data(mob/user)

	var/data = list()
	var/mob/living/silicon/silicon = user
	data["viewing_silicon"] = ismachinerestricted(silicon)
	data["global_state"] = linked.engines_state
	data["global_limit"] = round(linked.thrust_limit*100)
	var/total_thrust = 0

	var/list/engines = list()
	for(var/datum/ship_engine/E in linked.engines)
		var/list/rdata = list()
		rdata["eng_type"] = E.name
		rdata["eng_on"] = E.is_on()
		rdata["eng_thrust"] = E.get_thrust()
		rdata["eng_thrust_limiter"] = round(E.get_thrust_limit()*100)
		rdata["eng_status"] = E.get_status()
		rdata["eng_reference"] = "\ref[E]"
		total_thrust += E.get_thrust()
		engines.Add(list(rdata))

	data["engines"] = engines
	data["total_thrust"] = total_thrust

	return data

/obj/machinery/computer/ship/engines/tgui_act(action, list/params)
	. = ..()
	if(.)
		return

	.=TRUE
	add_fingerprint(usr)

	switch(action)
		if("global_toggle")
			linked.engines_state = !linked.engines_state
			for(var/datum/ship_engine/E in linked.engines)
				if(linked.engines_state == !E.is_on())
					E.toggle()
			return TOPIC_REFRESH
		if("set_global_limit")
			linked.thrust_limit = params["new_limit"]
			for(var/datum/ship_engine/E in linked.engines)
				E.set_thrust_limit(linked.thrust_limit)
			return TOPIC_REFRESH
		if("global_limit")
			linked.thrust_limit += params["adjust"]
			for(var/datum/ship_engine/E in linked.engines)
				E.set_thrust_limit(linked.thrust_limit)
			return TOPIC_REFRESH
		if("set_limit")
			var/datum/ship_engine/E = locate(params["ref"])
			var/limit = params["new_limit"]
			if(istype(E))
				E.set_thrust_limit(limit)
			return TOPIC_REFRESH
		if("limit")
			var/datum/ship_engine/E = locate(params["ref"])
			var/limit = text2num(params["adjust"])
			if(istype(E))
				var/oldlimit = E.get_thrust_limit()
				E.set_thrust_limit(oldlimit+limit)
			return TOPIC_REFRESH
		if("toggle")
			var/datum/ship_engine/E = locate(params["ref"])
			if(istype(E))
				E.toggle()
			return TOPIC_REFRESH

	return TOPIC_NOACTION
