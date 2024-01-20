/obj/item/organ/internal/ecs
	name = "exonet connection port"
	icon_state = "cooling0"
	organ_tag = BP_EXONET
	parent_organ = BP_HEAD
	status = ORGAN_ROBOTIC
	desc = "The internal the port is designed to establish communication between the positronic brain and the computer."
	max_damage = 100
	var/obj/item/modular_computer/ecs/computer = /obj/item/modular_computer/ecs
	var/open


/obj/item/organ/internal/ecs/Initialize()
	if(ispath(computer))
		computer = new computer(src)
	..()


/obj/item/organ/internal/ecs/Process()
	..()
	if(!owner)
		return
	if(owner.stat == DEAD)
		return
	if(computer.battery_module.battery.charge < (computer.battery_module.battery.maxcharge))
		transfer_charge()

/obj/item/organ/internal/ecs/proc/transfer_charge()
	var/obj/item/organ/internal/cell/potato = owner.internal_organs_by_name[BP_CELL]
	var/charge_needed =(computer.battery_module.battery.maxcharge - computer.battery_module.battery.charge)
	if(charge_needed)
		potato.cell.charge -= charge_needed
		computer.battery_module.battery.charge += charge_needed

/obj/item/organ/internal/ecs/attackby(obj/item/W, mob/user)
	if(isScrewdriver(W))
		if(open)
			open = 0
			to_chat(user, "<span class='notice'>You screw the exonet connection slot panel in place.</span>")
		else
			open = 1
			to_chat(user, "<span class='notice'>You unscrew the exonet connection slot panel.</span>")

	if(isCrowbar(W))
		if(open)
			if(computer)
				user.put_in_hands(computer)
				to_chat(user, "<span class='notice'>You remove \the [computer] from \the [src].</span>")
				computer = null

	if (istype(W, /obj/item/modular_computer/ecs))
		if(open)
			if(computer)
				to_chat(user, "<span class ='warning'>There \the [computer] already installed.</span>")
			else if(user.unEquip(W, src))
				computer = W
				to_chat(user, "<span class = 'notice'>You insert \the [computer].</span>")


/obj/item/organ/internal/ecs/proc/exonet(mob/user)
	if(!computer.enabled && computer.screen_on)
		return computer.turn_on(user)
	switch(alert("Open Terminal or interact with it?", "Open Terminal or interact with it?", "Interact", "Terminal"))
		if("Interact")
//[/INF]
			return computer.ui_interact(user)
//[INF]
		if("Terminal")
			return computer.open_terminal_ecs(user)
