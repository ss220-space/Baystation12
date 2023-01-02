//Engine control and monitoring console

/obj/machinery/computer/ship/missiles
	name = "missile control console"
	icon_keyboard = "tech_key"
	icon_screen = "mass_driver"
	var/display_state = "status"
	var/handled_sensors_range = 0


/obj/machinery/computer/ship/missiles/proc/handle_sensors_range()
	for(var/obj/machinery/computer/ship/sensors/sensor in linked.linked_computers)
		handled_sensors_range = sensor.get_scanner_range()
		//message_admins(handled_sensors_range)


/obj/machinery/computer/ship/missiles/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(!linked)
		display_reconnect_dialog(user, "sensors")
		return

	handle_sensors_range()
	var/data[0]
	var/list/contacts_ships = list()
	var/list/contacts_planets = list()
	var/list/contacts_missiles = list()
	var/obj/target_temp
	for(var/obj/effect/overmap/O in view(src.handled_sensors_range, linked))
		if(linked == O)
			continue
		if(!O.scannable)
			continue
		var/bearing = round(90 - Atan2(O.x - linked.x, O.y - linked.y),5)
		if(bearing < 0)
			bearing += 360

		if(istype(O, /obj/effect/overmap/visitable/ship))
			contacts_ships.Add(list(list("name"=O.scanner_name, "ref"="\ref[O]", "bearing"=bearing)))

		else if(istype(O, /obj/effect/overmap/visitable/sector/exoplanet))
			contacts_planets.Add(list(list("name"=O.scanner_name, "ref"="\ref[O]", "bearing"=bearing)))

		else if(istype(O, /obj/effect/overmap/projectile))
			contacts_missiles.Add(list(list("name"=O.scanner_name, "ref"="\ref[O]", "bearing"=bearing)))

	if(contacts_ships.len)
		data["contacts_ships"] = contacts_ships

	if(contacts_planets.len)
		data["contacts_planets"] = contacts_planets

	if(contacts_missiles.len)
		data["contacts_missiles"] = contacts_missiles

	data["planet_x"] = linked.get_target(TARGET_PLANETCOORD)[1]
	data["planet_y"] = linked.get_target(TARGET_PLANETCOORD)[2]
	data["point_x"] = linked.get_target(TARGET_POINT)[1]
	data["point_y"] = linked.get_target(TARGET_POINT)[2]
	data["target_ship"] = null
	if(linked.get_target(TARGET_PLANET)[1])
		target_temp = linked.get_target(TARGET_PLANET)[1]
		data["target_planet"] = target_temp.name
	if(linked.get_target(TARGET_SHIP))
		target_temp = linked.get_target(TARGET_SHIP)
		data["target_ship"] = target_temp.name
	if(linked.get_target(TARGET_MISSILE))
		target_temp = linked.get_target(TARGET_MISSILE)
		data["target_missile"] = target_temp.name

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "target.tmpl", "[linked.scanner_name] Target Control", 700, 545)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)


/obj/machinery/computer/ship/missiles/OnTopic(var/mob/user, var/list/href_list, state) //TODO: FIX THIS
	if(..())
		return TOPIC_HANDLED

	if (!linked)
		return TOPIC_NOACTION

	if (href_list["ship_lock"])
		var/obj/effect/overmap/O = locate(href_list["ship_lock"])
		if(istype(O) && !QDELETED(O) && (O in view(handled_sensors_range, linked)))
			if(linked.set_target(TARGET_SHIP, O))
				visible_message(SPAN_NOTICE("[src] states, 'TARGET LOCKED: [O.scanner_name]'"))
				playsound(loc, "sound/machines/sensors/target_lock.ogg", 30, 1)
			else
				visible_message(SPAN_NOTICE("[src] states, 'TARGET LOCK FAILED'"))
		return TOPIC_HANDLED

	if (href_list["missile_lock"])
		var/obj/effect/overmap/O = locate(href_list["missile_lock"])
		if(istype(O) && !QDELETED(O) && (O in view(handled_sensors_range, linked)))
			if(linked.set_target(TARGET_MISSILE, O))
				visible_message(SPAN_NOTICE("[src] states, 'MISSILE LOCKED: [O.scanner_name]'"))
				playsound(loc, "sound/machines/sensors/target_lock.ogg", 30, 1)
			else
				visible_message(SPAN_NOTICE("[src] states, 'MISSILE LOCK FAILED'"))
		return TOPIC_HANDLED

	if (href_list["planet_lock"])
		var/obj/effect/overmap/O = locate(href_list["planet_lock"])
		if(istype(O) && !QDELETED(O) && (O in view(handled_sensors_range, linked)))
			if(linked.set_target(TARGET_PLANET, O, linked.get_target(TARGET_PLANET)[2], linked.get_target(TARGET_PLANET)[3]))
				visible_message(SPAN_NOTICE("[src] states, 'PLANET LOCKED: [O.scanner_name]'"))
				playsound(loc, "sound/machines/sensors/target_lock.ogg", 30, 1)
			else
				visible_message(SPAN_NOTICE("[src] states, 'PLANET LOCK FAILED'"))
		return TOPIC_HANDLED

	if (href_list["set_planetx"])
		var/input = input("Set new planet X target", "Planet X", linked.get_target(TARGET_PLANETCOORD)[1]) as num|null
		if(!CanInteract(user,state))
			return TOPIC_NOACTION
		if (input)
			linked.set_target(TARGET_PLANET, linked.get_target(TARGET_PLANET)[1], Clamp(input,1, world.maxx-8), linked.get_target(TARGET_PLANET)[3])
		return TOPIC_REFRESH

	if (href_list["set_planety"])
		var/input = input("Set new planet Y target", "Planet Y", linked.get_target(TARGET_PLANETCOORD)[2]) as num|null
		if(!CanInteract(user,state))
			return TOPIC_NOACTION
		if (input)
			linked.set_target(TARGET_PLANET, linked.get_target(TARGET_PLANET)[1], linked.get_target(TARGET_PLANET)[2], Clamp(input,1, world.maxy-8))
		return TOPIC_REFRESH


	if (href_list["set_pointx"])
		var/input = input("Set new point X target", "Planet X", linked.get_target(TARGET_POINT)[1]) as num|null
		if(!CanInteract(user,state))
			return TOPIC_NOACTION
		if (input)
			linked.set_target(TARGET_POINT, null, Clamp(input, 1, 40), linked.get_target(TARGET_POINT)[2])
		return TOPIC_REFRESH

	if (href_list["set_pointy"])
		var/input = input("Set new point Y target", "Planet Y", linked.get_target(TARGET_POINT)[2]) as num|null
		if(!CanInteract(user,state))
			return TOPIC_NOACTION
		if (input)
			linked.set_target(TARGET_POINT, null, linked.get_target(TARGET_POINT)[1], Clamp(input, 1, 40))
		return TOPIC_REFRESH

/obj/machinery/computer/ship/missiles/proc/announce()
	if(prob(80))
		for(var/obj/effect/overmap/O in view(10,linked))
			if(linked == O)
				continue
			if(!O.scannable)
				continue
			var/bearing = round(90 - Atan2(O.x - linked.x, O.y - linked.y),5)
			if(bearing < 0)
				bearing += 360
			if(istype(O, /obj/effect/overmap/projectile))
				if(bearing == 0)
					return
				if(bearing <= 179)
					src.visible_message(SPAN_WARNING("<b>[name]</b> states, обнаружен пуск ракеты, передняя полусфера"))
					playsound(src.loc, 'sound/machines/defib_safetyOff.ogg', 100, 1)
				if(bearing >= 180)
					src.visible_message(SPAN_DANGER("<b>[name]</b> states, обнаружен пуск ракеты, задняя полусфера"))
					playsound(src.loc, 'sound/machines/defib_safetyOn.ogg', 100, 1)
