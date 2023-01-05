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

/obj/item/clothing/glasses/sunglasses/lenses/visor
	name = "small sun visor"
	desc = "It looks fitted to nonhuman proportions"
	icon_state = "visor_gen"


/obj/item/clothing/glasses/sunglasses/lenses/visor_col
	name = "small sun visor"
	desc = "It looks fitted to nonhuman proportions"
	icon_state = "visor_col"

/obj/item/clothing/glasses/hybrid
	name = "hybrid glasses"
	desc = "glasses with multiple HUD modes."
	action_button_name = "Toggle glasses"
	var/hood_active = TRUE
	var/active_icon
	var/off_icon
	electric = TRUE

/obj/item/clothing/glasses/hybrid/sechud
	req_access = list(access_security)
	hud_type = HUD_SECURITY

/obj/item/clothing/glasses/hybrid/medhud
	req_access = list(access_security)
	hud_type = HUD_MEDICAL


/obj/item/clothing/glasses/meson/resomi
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'
	flash_protection = FLASH_PROTECTION_MODERATE
	species_restricted = list(SPECIES_RESOMI)


/obj/item/clothing/glasses/meson/resomi/deactivate(mob/user, manual = TRUE)
	. = ..()
	flash_protection = FLASH_PROTECTION_MODERATE
	update_clothing_icon()
	update_vision()

/obj/item/clothing/glasses/meson/resomi/visor
	icon_state = "mesonvisor"
	item_state = "mesonvisor"
	action_button_name = "Toggle Goggles"

/obj/item/clothing/glasses/hybrid/sechud/resomi
	name = "small sechud lenses"
	desc = "Lenses with a HUD. This one has a sechud."
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'

	active_icon = "sec_lenses"
	off_icon 	= "sun_lenses"
	icon_state = "sec_lenses"

	species_restricted = list(SPECIES_RESOMI)
	flash_protection = FLASH_PROTECTION_MODERATE

/obj/item/clothing/glasses/hybrid/sechud/resomi/visor
	name = "small sechud visor"
	desc = "visor with a HUD. This one has a sechud."

	active_icon = "secvisor"
	off_icon 	= "degoggles"
	icon_state = "secvisor"

/obj/item/clothing/glasses/hybrid/medhud/resomi
	name = "small sechud lenses"
	desc = "Lenses with a HUD. This one has a sechud."
	item_icons = list(slot_glasses_str = 'infinity/icons/mob/species/resomi/onmob_eyes_resomi.dmi')
	icon = 'infinity/icons/obj/clothing/species/resomi/obj_eyes_resomi.dmi'

	active_icon = "med_lenses"
	off_icon 	= "sun_lenses"
	icon_state = "med_lenses"

	species_restricted = list(SPECIES_RESOMI)
	flash_protection = FLASH_PROTECTION_MODERATE

/obj/item/clothing/glasses/hybrid/medhud/resomi/visor
	name = "small medhud visor"
	desc = "visor with a HUD. This one has a medhud."

	active_icon = "medvisor"
	off_icon 	= "degoggles"
	icon_state = "medvisor"

/obj/item/clothing/glasses/hybrid/attack_self(mob/user)
	if(hood_active)
		hood_active = FALSE
		to_chat(user, "You switch \the [src] main function OFF.")
		icon_state = "[off_icon]"
		item_state = "[off_icon]"
		update_state(user)
	else
		hood_active = TRUE
		to_chat(user, "You switch \the [src] main function ON.")
		icon_state = "[active_icon]"
		item_state = "[active_icon]"
		update_state(user)





/obj/item/clothing/glasses/hybrid/process_hud(var/mob/M)
	if((hud_type == HUD_SECURITY) && hood_active)
		process_sec_hud(M, 1)
	if((hud_type == HUD_MEDICAL) && hood_active)
		process_med_hud(M, 1)
	if((hud_type == HUD_JANITOR) && hood_active)
		process_jani_hud(M, 1)


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
