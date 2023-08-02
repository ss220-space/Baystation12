/obj/machinery/computer/ship/sensors
	name = "sensors console"
	icon_keyboard = "teleport_key"
	icon_screen = "teleport"
	light_color = "#77fff8"
	extra_view = 4
	silicon_restriction = STATUS_UPDATE
	machine_name = "sensors console"
	machine_desc = "Used to activate, monitor, and configure a spaceship's sensors. Higher range means higher temperature; dangerously high temperatures may fry the delicate equipment."
	var/obj/machinery/shipsensors/sensors
	var/print_language = LANGUAGE_HUMAN_EURO
	var/working_sound = 'sound/machines/sensors/dradis.ogg'
	var/datum/sound_token/sound_token
	var/sound_id
	var/list/last_scan


// fancy sprite
/obj/machinery/computer/ship/sensors/adv
	icon_keyboard = null
	icon_state = "adv_sensors"
	icon_screen = "adv_sensors_screen"
	light_color = "#05A6A8"

/obj/machinery/computer/ship/sensors/spacer
	construct_state = /decl/machine_construction/default/panel_closed/computer/no_deconstruct
	base_type = /obj/machinery/computer/ship/sensors
	print_language = LANGUAGE_SPACER

/obj/machinery/computer/ship/sensors/attempt_hook_up(obj/effect/overmap/visitable/ship/sector)
	if(!(. = ..()))
		return
	find_sensors()

/obj/machinery/computer/ship/sensors/proc/update_sound()
	if(!working_sound)
		return
	if(!sound_id)
		sound_id = "[type]_[sequential_id(/obj/machinery/computer/ship/sensors)]"
	if(linked && sensors.use_power ** sensors.powered())
		var/volume = 10
		if(!sound_token)
			sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, working_sound, volume = volume, range = 10)
		sound_token.SetVolume(volume)
	else if(sound_token)
		QDEL_NULL(sound_token)

/obj/machinery/computer/ship/sensors/proc/find_sensors()
	if(!linked)
		return
	for(var/obj/machinery/shipsensors/S in SSmachines.machinery)
		if(linked.check_ownership(S))
			sensors = S
			break

/obj/machinery/computer/ship/sensors/proc/get_scanner_range()
	var/broadcast_sensor_range = 0

	broadcast_sensor_range = round(sensors.sensor_range)
	//message_admins("[sensors.sensor_range], [round(sensors.sensor_range)]") //какого хъуя
	return broadcast_sensor_range

/obj/machinery/computer/ship/sensors/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(!linked)
		display_reconnect_dialog(user, "sensors")
		return

	var/data[0]

	data["viewing"] = viewing_overmap(user)
	var/mob/living/silicon/silicon = user
	data["viewing_silicon"] = ismachinerestricted(silicon)
	if(sensors)
		data["on"] = sensors.use_power
		data["range"] = sensors.range
		data["health"] = sensors.health
		data["max_health"] = sensors.max_health
		data["heat"] = sensors.heat
		data["critical_heat"] = sensors.critical_heat
		if(sensors.health == 0)
			data["status"] = "DESTROYED"
		else if(!sensors.powered())
			data["status"] = "NO POWER"
		else if(!sensors.in_vacuum())
			data["status"] = "VACUUM SEAL BROKEN"
		else
			data["status"] = "OK"
		var/list/contacts = list()
		for(var/obj/effect/overmap/O in view(sensors.sensor_range,linked))
			var/datum/overmap_contact/record
			if(linked == O)
				continue
			if(!O.scannable)
				continue
			var/bearing = round(90 - Atan2(O.x - linked.x, O.y - linked.y),5)
			if(bearing < 0)
				bearing += 360
			for(var/key in contact_datums)
				record = contact_datums[O]
			if(record)
				if(!record.identified)
					continue
			contacts.Add(list(list("name"=O.scanner_name, "color"= O.color, "ref"="\ref[O]", "bearing"=bearing)))
		if(contacts.len)
			data["contacts"] = contacts
		data["last_scan"] = last_scan
	else
		data["status"] = "MISSING"
		data["range"] = "N/A"
		data["on"] = 0

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "shipsensors.tmpl", "[linked.scanner_name] Sensors Control", 420, 530, src)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/ship/sensors/OnTopic(var/mob/user, var/list/href_list, state)
	if(..())
		return TOPIC_HANDLED

	if (!linked)
		return TOPIC_NOACTION

	if (href_list["viewing"])
		if(user)
			viewing_overmap(user) ? unlook(user) : look(user)
		return TOPIC_REFRESH

	if (href_list["link"])
		find_sensors()
		return TOPIC_REFRESH

	if(sensors)
		if (href_list["range"])
			var/nrange = input("Set new sensors range", "Sensor range", sensors.range) as num|null
			if(!CanInteract(user,state))
				return TOPIC_NOACTION
			if (nrange)
				sensors.set_range(Clamp(nrange, 1, world.view))
			return TOPIC_REFRESH
		if (href_list["toggle"])
			sensors.toggle()
			return TOPIC_REFRESH

	if (href_list["scan"])
		if(sensors.use_power == 0)
			to_chat(user, SPAN_WARNING("[src] states, 'Sensors offline!'"))
			return TOPIC_NOACTION

		var/obj/effect/overmap/O = locate(href_list["scan"])
		if(istype(O) && !QDELETED(O) && (O in view(sensors.sensor_range, linked)))
			playsound(loc, "sound/effects/ping.ogg", 50, 1)
			LAZYSET(last_scan, "data", O.get_scan_data(user))
			LAZYSET(last_scan, "location", "[O.x],[O.y]")
			LAZYSET(last_scan, "name", "[O]")
			to_chat(user, SPAN_NOTICE("[src] states, 'Successfully scanned [O].'"))
		else
			to_chat(user, SPAN_WARNING("[src] states, 'Could not get a scan, target not in range!'"))
		return TOPIC_HANDLED

	if (href_list["print"])
		playsound(loc, "sound/machines/dotprinter.ogg", 30, 1)
		new/obj/item/paper/(get_turf(src), last_scan["data"], "paper (Sensor Scan - [last_scan["name"]])")
		return TOPIC_HANDLED


/obj/machinery/shipsensors
	name = "sensors suite"
	desc = "Long range gravity scanner with various other sensors, used to detect irregularities in surrounding space. Can only run in vacuum to protect delicate quantum BS elements."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "sensors"
	anchored = TRUE
	var/max_health = 200
	var/health = 200
	var/critical_heat = 50 // sparks and takes damage when active & above this heat
	var/heat_reduction = 1.5 // mitigates this much heat per tick
	var/heat = 0
	var/range = 1
	var/sensor_range = 0
	idle_power_usage = 5000
	use_power = 1 //INF. Turned off at roundstart

/obj/machinery/shipsensors/attackby(obj/item/W, mob/user)
	var/damage = max_health - health
	if(damage && isWelder(W))

		var/obj/item/weldingtool/WT = W

		if(!WT.isOn())
			return

		if(WT.remove_fuel(0,user))
			to_chat(user, "<span class='notice'>You start repairing the damage to [src].</span>")
			playsound(src, 'sound/items/Welder.ogg', 100, 1)
			if(do_after(user, max(5, damage / 5), src) && WT && WT.isOn())
				to_chat(user, "<span class='notice'>You finish repairing the damage to [src].</span>")
				take_damage(-damage)
		else
			to_chat(user, "<span class='notice'>You need more welding fuel to complete this task.</span>")
			return
		return
	..()

/obj/machinery/shipsensors/proc/in_vacuum()
	var/turf/T=get_turf(src)
	if(istype(T))
		var/datum/gas_mixture/environment = T.return_air()
		if(environment && environment.return_pressure() > MINIMUM_PRESSURE_DIFFERENCE_TO_SUSPEND)
			return 0
	return 1

/obj/machinery/shipsensors/on_update_icon()
	if(use_power)
		icon_state = "sensors"
	else
		icon_state = "sensors_off"

/obj/machinery/shipsensors/examine(mob/user)
	. = ..()
	if(health <= 0)
		to_chat(user, "\The [src] is wrecked.")
	else if(health < max_health * 0.25)
		to_chat(user, "<span class='danger'>\The [src] looks like it's about to break!</span>")
	else if(health < max_health * 0.5)
		to_chat(user, "<span class='danger'>\The [src] looks seriously damaged!</span>")
	else if(health < max_health * 0.75)
		to_chat(user, "\The [src] shows signs of damage!")

/obj/machinery/shipsensors/bullet_act(var/obj/item/projectile/Proj)
	take_damage(Proj.get_structure_damage())
	..()

/obj/machinery/shipsensors/proc/toggle()
	if(!use_power && (health == 0 || !in_vacuum()))
		return // No turning on if broken or misplaced.
	if(!use_power) //need some juice to kickstart
		use_power_oneoff(idle_power_usage*5)
	update_use_power(!use_power)
	queue_icon_update()


/obj/machinery/shipsensors/Process()
	if(use_power) //can't run in non-vacuum
		if(!in_vacuum())
			toggle()
		if(heat > critical_heat)
			src.visible_message("<span class='danger'>\The [src] violently spews out sparks!</span>")
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(3, 1, src)
			s.start()

			take_damage(rand(10,50))
			toggle()
		heat += idle_power_usage/15000

	if (heat > 0)
		heat = max(0, heat - heat_reduction)

/obj/machinery/shipsensors/power_change()
	. = ..()
	if(use_power && !powered())
		toggle()

/obj/machinery/shipsensors/proc/set_range(nrange)
	range = nrange
	sensor_range = round(range,1)
	change_power_consumption(1500 * (range**2), POWER_USE_IDLE) //Exponential increase, also affects speed of overheating

/obj/machinery/shipsensors/emp_act(severity)
	if(!use_power)
		return
	take_damage(20/severity)
	toggle()

/obj/machinery/shipsensors/proc/take_damage(value)
	health = min(max(health - value, 0),max_health)
	if(use_power && health == 0)
		toggle()


// fancy sprite
/obj/machinery/computer/ship/sensors/adv
	icon_keyboard = null
	icon_state = "adv_sensors"
	icon_screen = "adv_sensors_screen"
	light_color = "#05A6A8"
	base_type = /obj/machinery/computer/ship/navigation

/obj/machinery/shipsensors/weak
	heat_reduction = 0.2
	desc = "Miniturized gravity scanner with various other sensors, used to detect irregularities in surrounding space. Can only run in vacuum to protect delicate quantum BS elements."
