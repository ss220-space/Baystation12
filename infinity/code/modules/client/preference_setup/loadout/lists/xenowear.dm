/datum/gear/head/zhan_scarf/neck
	display_name = "(Tajara) Tua-Tari scarf"
	path = /obj/item/clothing/accessory/scarf/tajaran
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/uniform/tajara/taj_old_uniform
	display_name = "(Tajara) vintage uniform"
	path = /obj/item/clothing/under/taj_old_uniform
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"

/datum/gear/uniform/tajara/taj_new_fatigues
	display_name = "(Tajara) CCA fatigues"
	path = /obj/item/clothing/under/taj_new_fatigues
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"

/datum/gear/suit/tajara/taj_overcoat
	display_name = "(Tajara) vintage tajaran overcoat"
	path = /obj/item/clothing/suit/storage/taj_overcoat
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"

/datum/gear/shoes/tajara/taj_old_shoes
	display_name = "(Tajara) vintage boots"
	path = /obj/item/clothing/shoes/taj_old_shoes
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"

/datum/gear/shoes/tajara/taj_new_shoes
	display_name = "(Tajara) military boots"
	path = /obj/item/clothing/shoes/taj_new_shoes
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"

/datum/gear/shoes/tajara/taj_new_shoes_cut
	display_name = "(Tajara) toeless military  boots"
	path = /obj/item/clothing/shoes/taj_new_shoes_cut
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"

/datum/gear/shoes/tajara/taj_old_shoes_cut
	display_name = "(Tajara) toeless vintage boots"
	path = /obj/item/clothing/shoes/taj_old_shoes_cut
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"

/datum/gear/uniform/thermal
	sort_category = "Xenowear"
	display_name = "thermal suit selection"
	path = /obj/item/clothing/under
	whitelisted = list(SPECIES_TAJARA, SPECIES_RESOMI)

/datum/gear/uniform/thermal/New()
	..()
	var/thermal = list()
	thermal["Tajara, white thermal suit"]= /obj/item/clothing/under/thermal/tajara
	thermal["Tajara, tacticool thermal suit"]= /obj/item/clothing/under/thermal/tajara/tactic
	thermal["Tajara, gray thermal suit"]= /obj/item/clothing/under/thermal/tajara/gray
	thermal["Tajara, black thermal suit"]= /obj/item/clothing/under/thermal/tajara/black
	thermal["Resomi, black thermal suit"]= /obj/item/clothing/under/thermal/resomi
	thermal["Resomi, white thermal suit"]= /obj/item/clothing/under/thermal/resomi/white
	gear_tweaks += new/datum/gear_tweak/path(thermal)

/datum/gear/accessory/amulet
	display_name = "(Tajara) talisman selection"
	path = /obj/item/clothing/accessory/amulet
	whitelisted = list(SPECIES_TAJARA)
	sort_category = "Xenowear"
	flags = GEAR_HAS_TYPE_SELECTION
