//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32
#define MAIN_SCREEN 0
#define VIEW_SERVER_SCREEN 1
#define CODE_REDACTOR_SCREEN 2

/obj/machinery/computer/telecomms/traffic
	name = "Telecommunications Traffic Control"
	icon_screen = "generic"

	req_access = list(access_tcomsat)

	var/screen = MAIN_SCREEN			// the screen number:
	var/list/servers = list()	// the servers located by the computer
	var/list/viewingcode = list()
	var/obj/machinery/telecomms/server/SelectedServer

	var/mob/editingcode
	var/mob/lasteditor

	var/network = "NULL"		// the network to probe
	var/temp = ""				// temporary feedback messages

	var/storedcode = ""			// code stored

	var/list/compileerrors

/obj/machinery/computer/telecomms/traffic/attack_hand(mob/user as mob)
	. = ..()
	tgui_interact(user)
/obj/machinery/computer/telecomms/traffic/attack_ai(mob/user as mob)
	. = ..()
	tgui_interact(user)

/obj/machinery/computer/telecomms/traffic/tgui_interact(mob/user, var/datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "TrafficControl", name)
		ui.open()

/obj/machinery/computer/telecomms/traffic/tgui_data(mob/user)
	if(stat & (BROKEN|NOPOWER))
		return
	user.set_machine(src)

	var/data = list()
	data["screen"] = screen
	data["error"] = temp
	data["network"] = network

	switch(screen)
		if(MAIN_SCREEN)
			var/list/found_servers = list()
			for (var/obj/machinery/telecomms/server/server in servers)
				found_servers += list(list("ref"=REF(server), "name"=server.name, "id"=server.id))
			data["servers"] = found_servers
		if(VIEW_SERVER_SCREEN)
			data["serverName"] = SelectedServer.id
			data["signalEx"] = SelectedServer.autoruncode
		if(CODE_REDACTOR_SCREEN)
			data["codeText"] = storedcode
			var/list/errors = list()
			for(var/scriptError/e in compileerrors)
				errors += e.message
			data["errors"] = errors
	return data

/obj/machinery/computer/telecomms/traffic/tgui_act(action, list/params)
	. = ..()
	if(.)
		return

	temp = ""
	.= TRUE

	usr.set_machine(src)
	if(!src.allowed(usr) && !emagged)
		to_chat(usr, "<span class='warning'>ACCESS DENIED.</span>")
		return

	switch(action)
		if("view_server")
			SelectedServer = locate(params["server"])
			if(!SelectedServer)
				temp = "OPERATION FAILED: UNABLE TO LOCATE SERVER."
				return
			screen = VIEW_SERVER_SCREEN
			return
		if("clear_buffer")
			servers = list()
			network = ""
			screen = MAIN_SCREEN
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

				screen = MAIN_SCREEN
			return
		if("return_home")
			screen = MAIN_SCREEN
			return
		if("toggle_run")
			SelectedServer.autoruncode = !(SelectedServer.autoruncode)
			return
		if("open_editor")
			screen = CODE_REDACTOR_SCREEN
			return
		if("close")
			screen = VIEW_SERVER_SCREEN
			return
		if("compile")
			compileerrors = SelectedServer.Compiler.Compile(params["rawcode"])
			storedcode = params["rawcode"]
			return
		if("purge")
			SelectedServer.memory = list()
			temp = "SERVER MEMORY CLEARED!"
			return
		if("apply")
			SelectedServer.setcode(params["rawcode"])
			temp = "SUCCESSFULLY UPLOADED CODE TO THE SERVER!"
			screen = VIEW_SERVER_SCREEN
			return
		if("execute")
			var/datum/signal/signal = new()
			signal.data["message"] = ""
			if(SelectedServer.freq_listening.len > 0)
				signal.frequency = SelectedServer.freq_listening[1]
			else
				signal.frequency = PUB_FREQ
			signal.data["name"] = ""
			signal.data["job"] = ""
			signal.data["reject"] = 0
			signal.data["server"] = SelectedServer

			SelectedServer.Compiler.Run(signal)
			temp = "SUCCESSFULLY EXECUTED CODE!"
			return
	return

/obj/machinery/computer/telecomms/traffic/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		playsound(src.loc, 'sound/effects/sparks4.ogg', 75, 1)
		emagged = TRUE
		to_chat(user, "<span class='notice'>You you disable the security protocols</span>")
		src.updateUsrDialog()
		return 1


#undef MAIN_SCREEN
#undef VIEW_SERVER_SCREEN
