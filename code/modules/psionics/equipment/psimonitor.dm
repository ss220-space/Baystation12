/obj/machinery/psi_monitor
	name = "psionic implant monitor"
	icon = 'icons/obj/machines/psimeter.dmi'
	icon_state = "meter_on"
	use_power = POWER_USE_ACTIVE
	anchored = TRUE
	density = TRUE
	opacity = FALSE
	req_access = list(list(access_psychiatrist, access_captain, access_cmo, access_hos))

	var/list/psi_violations = list()
	var/show_violations = FALSE
	var/authorized

/obj/machinery/psi_monitor/New()
	SSpsi.psi_monitors += src
	..()

/obj/machinery/psi_monitor/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		emagged = TRUE
		remaining_charges--
		req_access.Cut()
		to_chat(user, "<span class='notice'>You short out the access protocols.</span>")
		return TRUE
	return FALSE

/obj/machinery/psi_monitor/Topic(href, href_list)

	. = ..()
	if(!.)

		if(href_list["login"])

			var/obj/item/card/id/ID = usr.GetIdCard()
			if(!ID || !allowed(usr))
				to_chat(usr, "<span class='warning'>Access denied.</span>")
			else
				authorized = "[ID.registered_name] ([ID.assignment])"
			. = 1

		else if(href_list["logout"])
			authorized = FALSE
			. = 1

		else if(href_list["show_violations"])
			show_violations = (href_list["show_violations"] == "1")
			. = 1

		else  if(href_list["remove_violation"])
			var/remove_ind = text2num(href_list["remove_violation"])
			if(remove_ind > 0 && remove_ind <= psi_violations.len)
				psi_violations.Cut(remove_ind, remove_ind++)
				. = 1

		else if(href_list["change_mode"])
			var/obj/item/implant/psi_control/implant = locate(href_list["change_mode"])
			if(implant.imp_in && !implant.malfunction)
				var/choice = input("Select a new implant mode.", "Psi Dampener") as null|anything in list(PSI_IMPLANT_AUTOMATIC, PSI_IMPLANT_SHOCK, PSI_IMPLANT_WARN, PSI_IMPLANT_LOG, PSI_IMPLANT_DISABLED)
				if(choice && implant && implant.imp_in && !implant.malfunction)
					implant.psi_mode = choice
					implant.update_functionality()
					. = 1

		if(. && usr)
			interact(usr)

/obj/machinery/psi_monitor/interface_interact(var/mob/user)
	interact(user)
	return TRUE

/obj/machinery/psi_monitor/interact(var/mob/user)

	var/list/dat = list()
	dat += "<h1>Psi Dampener Monitor</h1>"
	if(authorized)
		dat += "<b>[authorized]</b> <a href='?src=\ref[src];logout=1'>Logout</a>"
	else
		dat += "<a href='?src=\ref[src];login=1'>Login</a>"

	dat += "<h2>Active Psionic Dampeners</h2><hr>"
	dat += "<center><table>"
	dat += "<tr><td><b>Operant</b></td><td><b>System load</b></td><td><b>Mode</b></td></tr>"
	for(var/thing in SSpsi.psi_dampeners)
		var/obj/item/implant/psi_control/implant = thing
		if(!implant.imp_in)
			continue
		dat += "<tr><td>[implant.imp_in.name]</td>"
		if(implant.malfunction)
			dat += "<td>ERROR</td><td>ERROR</td>"
		else
			dat += "<td>[implant.overload]%</td><td>[authorized ? "<a href='?src=\ref[src];change_mode=\ref[implant]'>[implant.psi_mode]</a>" : "[implant.psi_mode]"]</td>"
		dat += "</tr>"
	dat += "</table><hr></center>"

	if(show_violations)
		dat += "<h2>Psionic Control Violations <a href='?src=\ref[src];show_violations=0'>-</a></h2><hr><center><table>"
		if(psi_violations.len)
			for(var/i =  1 to psi_violations.len)
				var/entry = psi_violations[i]
				dat += "<tr><td><br>[entry]</td><td>[authorized ? "<a href='?src=\ref[src];remove_violation=[i]'>Remove</a>" : ""]</td></tr>"
		else
			dat += "<tr><td colspan = 2>None reported.</td></tr>"
		dat += "</table></center><hr>"
	else
		dat += "<h2>Psionic Control Violations <a href='?src=\ref[src];show_violations=1'>+</a></h2><hr>"

	var/datum/browser/popup = new(user, "psi_monitor_\ref[src]", "Psi-Monitor")
	popup.set_content(jointext(dat,null))
	popup.open()


/obj/machinery/psi_monitor/proc/report_failure(var/obj/item/implant/psi_control/implant)
	psi_violations += "<font color='#FF0000'>Critical system failure - [implant.imp_in.name].</font>"

/obj/machinery/psi_monitor/proc/report_violation(var/obj/item/implant/psi_control/implant, var/stress)
	psi_violations += "Sigma [round(stress/10)] event - [implant.imp_in.name]."
	
/obj/item/storage/briefcase/psi_monitor
	name = "\improper Foundation briefcase"
	desc = "A handsome black leather briefcase embossed with a stylized radio telescope."
	icon_state = "fbriefcase"
	item_state = "fbriefcase"
	startswith = list(
		/obj/item/implantcase/explosive = 2,
		/obj/item/implantcase/tracking = 2,
		/obj/item/implant/psi_control,
		/obj/item/implanter/psi,
		/obj/item/implanter,
		/obj/item/implantpad,
		)

/obj/item/paper/psi_monitor
	name = "Psi-monitor usage"
	info = "<center><ntlogo></center><br><center><b>Руководство по использованию импланта пси-контроля</b><center><br><small>Настоящее руководство содержит сведения о должном использовании системы контроля псионических спобоностей, для старших сотрудников службы Защиты Активов объектов НаноТрейзен</small><br><br><b>Часть первая - имплант пси-контроля</b><br><br>Псионический имплант-подавитель класса L2 - последняя разработка Фонда Кучулейн для обеспечения контроля над особо опасными псиониками уровня мастера и выше.<br>Данный имплпант оборудован несколькими режимами работы:<br><br>Автоматический режим - осуществляет переключение между режимами, в зависимости от уровня тревоги на объекте.<br>Режим подавления - осуществляет активное подавление псионияеских способностей путём нарушения работы участков мозга, отвечающих за накопление псионической энергии. Также имеет дополнительную настройку: шоковый режим, посылающий крайне болезненный электрический импульс в мозг носителя при попытке применения пси-способностей.<br>Режим записи - отключение всех фукций импланта, за исключением записи попыток нарушения его работы через ЭМИ или хирургичекое вмешательство.<br><br><b>Часть вторая - монитор псионических имплантов</b><br><br>Согласно протоколу безопасности для объектов НаноТрейзен каждый объект должен быть оборудован монитором псионических имплантов, совместимым с имплантами класса L2. Данный монитор должен быть установлен в кабинете Главы Службы Безопасности Объекта, для управления установленными имплантами без необходимости хирургического удаления."
	icon = 'maps/sierra/icons/obj/uniques.dmi'
	icon_state = "paper_words"
	stamps = "<HR><i>This paper has been stamped by the Central Command.</i>"
