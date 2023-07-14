//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/obj/machinery/computer/telecomms
	icon_keyboard = "tech_key"

/obj/machinery/computer/telecomms/server
	name = "Telecommunications Server Monitor"
	icon_screen = "comm_logs"
	machine_name = "telecommunications server monitor console"
	machine_desc = "A terminal used to view and browse the logs of a telecommunications network."

	var/screen = 0				// the screen number:
	var/list/servers = list()	// the servers located by the computer
	var/obj/machinery/telecomms/server/SelectedServer

	var/network = "NULL"		// the network to probe
	var/temp = ""				// temporary feedback messages

	var/universal_translate = 0 // set to 1 if it can translate nonhuman speech

	req_access = list(access_tcomsat)

/obj/machinery/computer/telecomms/server/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/computer/telecomms/server/tgui_interact(mob/user, var/datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ServerMonitor", name)
		ui.open()

/obj/machinery/computer/telecomms/server/tgui_data(mob/user)

	var/list/data = list()
	data["screen"] = screen
	data["error"] = temp
	data["network"] = network

	switch(screen)
		if(0)
			var/list/found_servers = list()
			for (var/obj/machinery/telecomms/server/server in servers)
				found_servers += list(list("ref"=REF(server), "name"=server.name, "id"=server.id))
			data["servers"] = found_servers

		if(1)
			var/list/server_out = list()
			server_out["name"] = SelectedServer.name
			server_out["id"] = SelectedServer.id
			server_out["traffic"] = SelectedServer.totaltraffic
			// Get the messages on this server
			var/list/packets = list()
			for(var/datum/comm_log_entry/packet in SelectedServer.log_entries)
				var/list/packet_out = list()

				packet_out["name"] = packet.name
				packet_out["race"] = packet.parameters["race"]
				packet_out["language"] = packet.parameters["language"]
				packet_out["time"] = packet.parameters["messagetime"]
				packet_out["ref"] = REF(packet)
				packet_out["job"] = packet.parameters["job"]

				if(universal_translate || packet.parameters["uspeech"] || packet.parameters["intelligible"])
					packet_out["source"] = packet.parameters["name"]
					packet_out["type"] = packet.input_type
					packet_out["message"] = packet.parameters["message"]
				else
					packet_out["type"] = "Audio File"
					packet_out["source"] = "Unidentifiable"
					packet_out["message"] = "Unintelligble"
				packets += list(packet_out)
			server_out["packets"] = packets
			data["server"] = server_out
	return data


/obj/machinery/computer/telecomms/server/tgui_act(action, list/params)
	UI_ACT_CHECK

	temp = ""
	.= TRUE

	switch(action)
		if("delete_packet")
			var/datum/comm_log_entry/packet = locate(params["ref"])
			if(!(packet in SelectedServer.log_entries))
				temp = "OPERATION FAILED: PACKET NOT FOUND."
				return
			if(!src.allowed(usr))
				temp = "OPERATION FAILED: ACCESS DENIED."
				return
			SelectedServer.log_entries.Remove(packet)
			temp = "SUCCESSFULLY DELETED [packet.name]."
			qdel(packet)
			return

		if("return_home")
			screen = 0
			return
		if("scan_network")
			if(servers.len > 0)
				temp = "FAILED: CANNOT PROBE WHEN BUFFER FULL"
			else
				network = params["network_id"]
				for(var/obj/machinery/telecomms/server/T in range(25, src))
					if(T.network == network)
						servers.Add(T)

				if(!servers.len)
					temp = "FAILED: UNABLE TO LOCATE SERVERS IN \[[network]\]"
				else
					temp = "[servers.len] SERVERS PROBED & BUFFERED"

				screen = 0
			return
		if("clear_buffer")
			servers = list()
			network = ""
			screen = 0
			return
		if("view_server")
			SelectedServer = locate(params["server"])
			if(!SelectedServer)
				temp = "OPERATION FAILED: UNABLE TO LOCATE SERVER."
				return
			screen = 1
			return

	return

/obj/machinery/computer/telecomms/server/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		playsound(src.loc, 'sound/effects/sparks4.ogg', 75, 1)
		emagged = TRUE
		req_access.Cut()
		to_chat(user, "<span class='notice'>You you disable the security protocols</span>")
		src.updateUsrDialog()
		return 1
