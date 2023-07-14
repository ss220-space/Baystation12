//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32


/*
	Telecomms monitor tracks the overall trafficing of a telecommunications network
	and displays a heirarchy of linked machines.
*/

#define MAIN_VIEW 0
#define MACHINE_VIEW 1
#define MAX_NETWORK_ID_LENGTH 15

/obj/machinery/computer/telecomms/monitor
	name = "Telecommunications Monitor"
	icon_screen = "comm_monitor"
	machine_name = "telecomms monitor console"
	machine_desc = "Tracks the traffic of a telecommunications network, and maintains information about connected machines."

	var/screen = MAIN_VIEW			// the screen number:
	var/list/machinelist = list()	// the machines located by the computer
	var/obj/machinery/telecomms/SelectedMachine

	var/network = "NULL"		// the network to probe

	var/temp = ""				// temporary feedback messages



/obj/machinery/computer/telecomms/monitor/tgui_data(mob/user)
	var/list/data = list(
		"screen" = screen,
		"network" = network,
		"error_message" = temp,
	)

	switch(screen)
	  	// --- Main Menu ---
		if(MAIN_VIEW)
			var/list/found_machinery = list()
			for(var/obj/machinery/telecomms/telecomms in machinelist)
				found_machinery += list(list("ref" = REF(telecomms), "name" = telecomms.name, "id" = telecomms.id))
			data["machinery"] = found_machinery
	  	// --- Viewing Machine ---
		if(MACHINE_VIEW)
			// Send selected machinery data
			var/list/machine_out = list()
			machine_out["name"] = SelectedMachine.name
			// Get the linked machinery
			var/list/linked_machinery = list()
			for(var/obj/machinery/telecomms/T in SelectedMachine.links)
				linked_machinery += list(list("ref" = REF(T.id), "name" = T.name, "id" = T.id))
			machine_out["linked_machinery"] = linked_machinery
			data["machine"] = machine_out
	return data

/obj/machinery/computer/telecomms/monitor/tgui_act(action, params)
	UI_ACT_CHECK

	temp = ""

	switch(action)
		// Scan for a network
		if("probe_network")
			var/new_network = params["network_id"]

			if(length(new_network) > MAX_NETWORK_ID_LENGTH)
				temp = "OPERATION FAILED: NETWORK ID TOO LONG."
				return TRUE

			if(machinelist.len > 0)
				temp = "OPERATION FAILED: CANNOT PROBE WHEN BUFFER FULL."
				return TRUE

			network = new_network

			for(var/obj/machinery/telecomms/T in range(25, src))
				if(T.network == network)
					machinelist.Add(T)
			if(machinelist.len == 0)
				temp = "OPERATION FAILED: UNABLE TO LOCATE NETWORK ENTITIES IN  [network]."
				return TRUE
			temp = "[machinelist.len] ENTITIES LOCATED & BUFFERED";
			return TRUE
		if("flush_buffer")
			machinelist = list()
			network = ""
			return TRUE
		if("view_machine")
			for(var/obj/machinery/telecomms/T in machinelist)
				if(T.id == params["id"])
					SelectedMachine = T
			if(!SelectedMachine)
				temp = "OPERATION FAILED: UNABLE TO LOCATE MACHINERY."
			screen = MACHINE_VIEW
			return TRUE
		if("return_home")
			SelectedMachine = null
			screen = MAIN_VIEW
			return TRUE
	return TRUE

/obj/machinery/computer/telecomms/monitor/tgui_interact(mob/user, var/datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "TelecommsMonitor", name)
		ui.open()

/obj/machinery/computer/telecomms/monitor/attack_hand(mob/user as mob)
	if(..(user))
		return
	//[INF]
	tgui_interact(user)


/obj/machinery/computer/telecomms/monitor/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		playsound(src.loc, 'sound/effects/sparks4.ogg', 75, 1)
		emagged = TRUE
		req_access.Cut()
		to_chat(user, "<span class='notice'>You you disable the security protocols</span>")
		src.updateUsrDialog()
		return 1

#undef MAIN_VIEW
#undef MACHINE_VIEW
#undef MAX_NETWORK_ID_LENGTH
