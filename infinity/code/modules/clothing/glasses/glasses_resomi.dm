/obj/item/clothing/glasses/sunglasses/lenses
	name = "small sun lenses"
	desc = "It looks fitted to nonhuman proportions. Usually, you can(?) see them in resomis' or monkeys' eyes."
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'
	icon_state = "sun_lenses"
	item_state = null
	species_restricted = list(SPECIES_RESOMI)
	flash_protection = FLASH_PROTECTION_MODERATE
	body_parts_covered = 0



/obj/item/clothing/glasses/hybrid/lenses/sechud
	name = "small sechud lenses"
	desc = "Lenses with a HUD. This one has a sechud."
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'
	icon_state = "sec_lenses"
	item_state = "sec_lenses"
	species_restricted = list(SPECIES_RESOMI)
	flash_protection = FLASH_PROTECTION_MODERATE
	req_access = list(access_security)
	toggleable = TRUE
	action_button_name = "Toggle visor"
	electric = TRUE
	vision_flags = null
	var/on = TRUE
	var/mode = TRUE
	var/hud_on = TRUE

/obj/item/clothing/glasses/hybrid/lenses/sechud/attack_self(mob/user)
	if(toggleable && !user.incapacitated())
		if(!on && !mode)
			flash_protection = FLASH_PROTECTION_MODERATE
			on = !on
			to_chat(user, "You switch \the [src] to excessive light protection mode.")
			icon_state = "sun_lenses"
			item_state = "sun_lenses"
			update_state(user)
			return
		if(on && !mode)
			flash_protection = FLASH_PROTECTION_MODERATE
			mode = !mode
			hud_on = TRUE
			to_chat(user, "You switch \the [src] main function ON.")
			icon_state = "sec_lenses"
			item_state = "sec_lenses"
			update_state(user)
			return
		if(on && mode)
			flash_protection = FLASH_PROTECTION_NONE
			mode = !mode
			on = !on
			hud_on = FALSE
			to_chat(user, "You switch off \the [src].")
			icon_state = "sun_lenses"
			item_state = "sun_lenses"
			update_state(user)
			return

/obj/item/clothing/glasses/hybrid/lenses/sechud/process_hud(var/mob/M)
	if(hud_on)
		process_sec_hud(M, 1)

/obj/item/clothing/glasses/hybrid/lenses/health
	name = "small medhud lenses"
	desc = "A small lenses that scans the creatures in view and provides accurate data about their health status."
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'
	icon_state = "med_lenses"
	item_state = "med_lenses"
	species_restricted = list(SPECIES_RESOMI)
	flash_protection = FLASH_PROTECTION_MODERATE
	req_access = list(access_medical)
	toggleable = TRUE
	action_button_name = "Toggle visor"
	electric = TRUE
	vision_flags = null
	var/on = TRUE
	var/mode = TRUE
	var/hud_on = TRUE

/obj/item/clothing/glasses/hybrid/lenses/health/attack_self(mob/user)
	if(toggleable && !user.incapacitated())
		if(!on && !mode)
			flash_protection = FLASH_PROTECTION_MODERATE
			on = !on
			to_chat(user, "You switch \the [src] to excessive light protection mode.")
			icon_state = "sun_lenses"
			item_state = "sun_lenses"
			update_state(user)
			return
		if(on && !mode)
			flash_protection = FLASH_PROTECTION_MODERATE
			mode = !mode
			hud_on = TRUE
			to_chat(user, "You switch \the [src] main function ON.")
			icon_state = "med_lenses"
			item_state = "med_lenses"
			update_state(user)
			return
		if(on && mode)
			flash_protection = FLASH_PROTECTION_NONE
			mode = !mode
			on = !on
			hud_on = FALSE
			to_chat(user, "You switch off \the [src].")
			icon_state = "sun_lenses"
			item_state = "sun_lenses"
			update_state(user)
			return

/obj/item/clothing/glasses/hybrid/lenses/health/process_hud(var/mob/M)
	if(hud_on)
		process_med_hud(M, 1)



/obj/item/clothing/glasses/sunglasses/sechud/lenses
	name = "small sechud lenses"
	desc = "Lenses with a HUD. This one has a sechud."
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'
	icon_state = "sec_lenses"
	item_state = null
	species_restricted = list(SPECIES_RESOMI)
	flash_protection = FLASH_PROTECTION_MODERATE

/obj/item/clothing/glasses/hud/health/lenses
	name = "small medhud lenses"
	desc = "A small lenses that scans the creatures in view and provides accurate data about their health status."
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'
	icon_state = "med_lenses"
	item_state = null
	flash_protection = FLASH_PROTECTION_MODERATE
	species_restricted = list(SPECIES_RESOMI)
