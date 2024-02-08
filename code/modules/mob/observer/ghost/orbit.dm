GLOBAL_DATUM_INIT(orbit_menu, /datum/orbit_menu, new)

/datum/orbit_menu

/datum/orbit_menu/tgui_state(mob/user)
	return GLOB.tgui_observer_state

/datum/orbit_menu/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "Orbit", "Orbit")
		ui.open()

/datum/orbit_menu/tgui_act(action, list/params)
	. = ..()

	if(.)
		return

	switch(action)
		if("orbit")
			var/datum/follow_holder/fh = locate(params["ref"]) in get_follow_targets()
			var/atom/movable/a = fh.followed_instance
			var/mob/observer/ghost/G = usr
			if(a != usr)
				G.start_following(a)
			return TRUE
		if("refresh")
			update_tgui_static_data()
			return TRUE

/datum/orbit_menu/tgui_static_data(mob/user)
	var/list/data = list()
	data["misc"] = list()
	data["ghosts"] = list()
	data["dead"] = list()
	data["npcs"] = list()
	data["alive"] = list()
	data["antagonists"] = list()
	for(var/datum/follow_holder/fh in get_follow_targets())
		var/atom/movable/fi = fh.followed_instance
		var/list/serialized = list()
		serialized["name"] = fi.name
		serialized["ref"] = "\ref[fh]"

		if(!istype(fi, /mob))
			data["misc"] += list(serialized)
			continue
		var/mob/M = fi
		if(isobserver(M))
			data["ghosts"] += list(serialized)
			continue

		if(M.stat == DEAD)
			data["dead"] += list(serialized)
			continue

		if(M.mind == null)
			data["npcs"] += list(serialized)
			continue

		data["alive"] += list(serialized)

		var/mob/observer/ghost/O = user
		if(O.antagHUD && M.get_antag_info())
			var/antag_serialized = serialized.Copy()
			for(var/antag_category in M.get_antag_info())
				antag_serialized["antag"] += list(antag_category)
			data["antagonists"] += list(antag_serialized)

	return data

/// Shows the UI to the specified user.
/datum/orbit_menu/proc/show(mob/user)
	tgui_interact(user)
