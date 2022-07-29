/datum/species/machine
	inherent_verbs = list(/mob/living/carbon/human/proc/detach_limb, /mob/living/carbon/human/proc/attach_limb, /mob/living/carbon/human/proc/IPC_change_screen, /mob/living/carbon/human/proc/IPC_display_text, /mob/living/carbon/human/proc/IPC_toggle_off_screen)

/mob/living/carbon/human/proc/detach_limb()
	set category = "Abilities"
	set name = "Detach Limb"
	set desc = "Detach one of your robotic appendages."

	if(last_special > world.time)
		return

	if(stat || paralysis || stunned || weakened || lying || restrained())
		to_chat(src,"<span class='warning'>You can't do that in your current state!</span>")
		return

	var/obj/item/organ/external/E = get_organ(zone_sel.selecting)

	if(!E)
		to_chat(src,"<span class='warning'>You are missing that limb.</span>")
		return

	if(!BP_IS_ROBOTIC(E))
		to_chat(src,"<span class='warning'>You can only detach robotic limbs.</span>")
		return

	if(E.is_stump() || E.is_broken())
		to_chat(src,"<span class='warning'>The limb is too damaged to be removed manually!</span>")
		return

	if(E.vital)
		to_chat(src,"<span class='warning'>Your safety system stops you from removing \the [E].</span>")
		return

	if(!do_after(src, 2 SECONDS, src)) return

	last_special = world.time + 20

	E.removed(src)
	E.forceMove(get_turf(src))

	update_body()
	updatehealth()
	UpdateDamageIcon()

	visible_message("<span class='notice'>\The [src] detaches \his [E]!</span>",
			"<span class='notice'>You detach your [E]!</span>")

/mob/living/carbon/human/proc/attach_limb()
	set category = "Abilities"
	set name = "Attach Limb"
	set desc = "Attach a robotic limb to your body."

	if(last_special > world.time)
		return

	if(stat || paralysis || stunned || weakened || lying || restrained())
		to_chat(src,"<span class='warning'>You can not do that in your current state!</span>")
		return

	var/obj/item/organ/external/O = src.get_active_hand()

	if(istype(O))

		if(!BP_IS_ROBOTIC(O))
			to_chat(src,"<span class='warning'>You are unable to interface with organic matter.</span>")
			return

	if(!O)
		return


	var/obj/item/organ/external/E = get_organ(zone_sel.selecting)

	if(E)
		to_chat(src,"<span class='warning'>You are not missing that limb.</span>")
		return

	if(!do_after(src, 2 SECONDS, src)) return

	last_special = world.time + 20

	src.drop_from_inventory(O)
	O.replaced(src)
	src.update_body()
	src.updatehealth()
	src.UpdateDamageIcon()

	update_body()
	updatehealth()
	UpdateDamageIcon()

	visible_message("<span class='notice'>\The [src] attaches \the [O] to \his body!</span>",
			"<span class='notice'>You attach \the [O] to your body!</span>")


/mob/living/carbon/human/proc/IPC_change_screen()
	set category = "Abilities"
	set name = "Change IPC Screen"
	set desc = "Allow change monitor type"
	var/obj/item/organ/external/head/R = src.get_organ(BP_HEAD)
	var/datum/robolimb/robohead = all_robolimbs[R.model]
	if(stat)
		return

	if(R.is_stump() || R.is_broken() || !R)
		return
	if(robohead.is_monitor)
		var/list/all_fhairs = typesof(/datum/sprite_accessory/facial_hair/ipc) - /datum/sprite_accessory/facial_hair/ipc
		var/list/fhairs = list()

		for(var/x in all_fhairs)
			var/datum/sprite_accessory/facial_hair/H = new x
			fhairs.Add(H.name)
			qdel(H)

		var/new_style = input("Please select screen", "Screen Menu",f_style)  as null|anything in fhairs

		if(new_style)
			f_style = new_style
		update_hair()
		R.set_light(0.2, 1, 2, 2)
	else
		to_chat(src,"<span class='warning'>You should have a compatible head monitor to change screen.</span>")


/mob/living/carbon/human/proc/IPC_display_text()
	set category = "Abilities"
	set name = "Display Text On Screen"
	set desc = "Display text on your monitor"
	var/obj/item/organ/external/head/R = src.get_organ(BP_HEAD)
	var/datum/robolimb/robohead = all_robolimbs[R.model]
	if(stat)
		return

	if(R.is_stump() || R.is_broken() || !R)
		return
	var/S
	if(robohead.is_monitor)
		S = input("Write something to display on your screen:", "Display Text") as text|null
	else
		to_chat(usr, "<span class='warning'>Your head has no screen!</span>")

	if(!length(S))
		return

	robohead.display_text = S
	f_style = "Text"
	R.set_light(0.2, 1, 2, 2)
	update_hair()

	var/skipface = FALSE
	if(head)
		skipface = head.flags_inv & HIDEFACE
	if(wear_mask)
		skipface |= wear_mask.flags_inv & HIDEFACE

	if(robohead.is_monitor && !skipface) // we still text even tho the screen may be broken or hidden
		custom_emote(VISIBLE_MESSAGE, "отображает на экране, [S]")

/mob/living/carbon/human/proc/IPC_toggle_off_screen()
	set category = "Abilities"
	set name = "Toggle IPC Screen Off"
	set desc = "Allow toggle off monitor"
	var/obj/item/organ/external/head/R = src.get_organ(BP_HEAD)
	var/datum/robolimb/robohead = all_robolimbs[R.model]
	if(stat)
		return

	if(R.is_stump() || R.is_broken() || !R)
		return
	if(robohead.is_monitor)
		f_style = "Off"
		R.set_light(0, 0)
		update_hair()
