//datajack by Sad Ninja Sid, modified from multimeter
/obj/item/device/multitool/multimeter/datajack
	name = "data jack"
	desc = "Кабель для мультизадачного подключения к различным устройствам посредством электронных устройств и продвинутой диагностики."
	icon = 'infinity/icons/obj/items.dmi'
	icon_state = "datajack"
	mode = METER_CHECKING // Mode
	var/obj/item/modular_computer/pda/holder

/obj/item/device/multitool/multimeter/datajack/New(var/obj/item/modular_computer/pda/P)
	. = ..()
	holder = P

/obj/item/device/multitool/multimeter/datajack/attack_self(mob/user)
	return

/obj/item/device/multitool/multimeter/datajack/dropped(mob/user)
	. = ..()
	holder.insert_datajack()

/obj/item/modular_computer/pda
	var/obj/item/device/multitool/multimeter/datajack/datajack

/obj/item/modular_computer/pda/dropped(mob/user)
	. = ..()
	src.insert_datajack()

/obj/item/modular_computer/pda/Initialize()
	. = ..()
	datajack = new(src)
	datajack.forceMove(src)

/obj/item/modular_computer/pda/proc/eject_datajack(mob/living/carbon/human/user)
	if(!datajack || datajack.loc != src)
		return 0

	if(!user.put_in_hands(datajack))
		to_chat(user, SPAN_WARNING("No free space in hands."))

/obj/item/modular_computer/pda/proc/insert_datajack()
	if(!datajack || datajack.loc == src)
		return 0

	datajack.forceMove(src)

/datum/terminal_command/datajack
	name = "datajack"
	man_entry = list("Format: datajack", "Works only on PDA's. Ejects a datajack.")
	pattern = "^datajack$"
	skill_needed = SKILL_EXPERT

/datum/terminal_command/datajack/proper_input_entered(text, mob/user, var/datum/terminal/terminal)
	var/datum/extension/interactive/ntos/C = terminal.computer
	if(C.get_hardware_flag() != PROGRAM_PDA)
		return SPAN_WARNING("This command cant be executed on this device.")

	var/obj/item/modular_computer/pda/pda = terminal.computer.get_physical_host()
	pda.eject_datajack(user)
	return list()
