//datajack by Sad Ninja Sid, modified from multimeter
/obj/item/device/multitool/multimeter/datajack
	name = "data jack"
	desc = "Кабель для мультизадачного подключения к различным устройствам посредством электронных устройств и продвинутой диагностики."
	icon = 'infinity/icons/obj/items.dmi'
	icon_state = "datajack"
	w_class = ITEM_SIZE_SMALL
	mode = METER_CHECKING // Mode
	slot_flags = null
	var/obj/item/modular_computer/holder

/obj/item/device/multitool/multimeter/datajack/New(var/obj/item/modular_computer/P)
	. = ..()
	holder = P

/obj/item/device/multitool/multimeter/datajack/attack_self(mob/user)
	. = ..()

/obj/item/device/multitool/multimeter/datajack/dropped(mob/user)
	. = ..()
	holder.insert_datajack()

/obj/item/modular_computer
	var/obj/item/device/multitool/multimeter/datajack/datajack

/obj/item/modular_computer/dropped(mob/user)
	. = ..()
	insert_datajack()

/obj/item/modular_computer/Initialize()
	. = ..()
	datajack = new(src)
	datajack.forceMove(src)

/obj/item/modular_computer/attackby(obj/item/W, mob/user, var/click_params)
	. = ..()
	if(datajack == W)
		insert_datajack()
		return

/obj/item/modular_computer/proc/eject_datajack(mob/living/carbon/human/user)
	if(!datajack || datajack.loc != src)
		return

	if(!user.put_in_hands(datajack))
		to_chat(user, SPAN_WARNING("Datajack cannot be deployed as long as you have no free space in hands."))

/obj/item/modular_computer/proc/insert_datajack()
	if(!datajack)
		return

	if(istype(datajack.loc, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = datajack.loc
		H.remove_from_mob(datajack, src)
		to_chat(H, SPAN_WARNING("Datajack moves into your device."))
		return
	datajack.forceMove(src)

/datum/terminal_command/datajack
	name = "datajack"
	man_entry = list("Format: datajack", "Works only on mobile devices. Ejects a datajack for checking wiring and pulsing any of those.")
	pattern = "^datajack$"
	skill_needed = SKILL_EXPERT

/datum/terminal_command/datajack/proper_input_entered(text, mob/user, var/datum/terminal/terminal)
	var/datum/extension/interactive/ntos/C = terminal.computer
	if(!(C.get_hardware_flag() & (PROGRAM_PDA | PROGRAM_LAPTOP | PROGRAM_TABLET)))
		return SPAN_WARNING("This command cant be executed on this device.")

	var/obj/item/modular_computer/comp = terminal.computer.get_physical_host()
	comp.eject_datajack(user)
	return SPAN_WARNING("Datajack tried to eject further.")

/obj/item/device/multitool/multimeter/datajack/mob_can_unequip()
	return
