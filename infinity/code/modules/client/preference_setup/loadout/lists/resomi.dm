/datum/gear/uniform/resomi
	display_name = "(Resomi) smock, grey"
	path = /obj/item/clothing/under/resomi
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)

/datum/gear/uniform/resomi/white
	display_name = "(Resomi) smock, colored"
	path = /obj/item/clothing/under/resomi/white
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/uniform/resomi/dress
	display_name = "(Resomi) dresses selection"
	path = /obj/item/clothing/under/resomi/dress
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/uniform/resomi/utility
	display_name = "(Resomi) uniform selection"
	path = /obj/item/clothing/under/resomi/utility
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/uniform/resomi/sport
	display_name = "(Resomi) uniform, Sport"
	path = /obj/item/clothing/under/resomi/sport

/datum/gear/uniform/resomi/rainbow
	display_name = "(Resomi) smock, rainbow"
	path = /obj/item/clothing/under/resomi/rainbow

/datum/gear/uniform/resomi/eng
	display_name = "(Resomi) smock, Engineering"
	path = /obj/item/clothing/under/resomi/yellow

/datum/gear/uniform/resomi/roboitcs
	display_name = "(Resomi) smock, Robotics"
	path = /obj/item/clothing/under/resomi/robotics

/datum/gear/uniform/resomi/sec
	display_name = "(Resomi) smock, Security"
	path = /obj/item/clothing/under/resomi/red

/datum/gear/uniform/resomi/med
	display_name = "(Resomi) uniform, Medical"
	path = /obj/item/clothing/under/resomi/medical

/datum/gear/uniform/resomi/science
	display_name = "(Resomi) uniform, Science"
	path = /obj/item/clothing/under/resomi/science

/datum/gear/uniform/resomi/dark_worksmock
	display_name = "(Resomi) work uniform, dark"
	path = /obj/item/clothing/under/resomi/work_black
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/uniform/resomi/light_worksmock
	display_name = "(Resomi) work uniform, light"
	path = /obj/item/clothing/under/resomi/work_white
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/uniform/resomi/util
	display_name = "(Resomi) util suit"
	path = /obj/item/clothing/under/resomi/util
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/uniform/resomi_uniform
	display_name = "(Resomi) special uniform selection"
	path = /obj/item/clothing/under/resomi/morningstar
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)

/datum/gear/uniform/resomi_uniform/New()
	..()
	var/resomi = list()
	resomi["morningstar jumpsuit"] = /obj/item/clothing/under/resomi/morningstar
	resomi["saints jumpsuit"] 	= /obj/item/clothing/under/resomi/saints
	resomi["deckers jumpsuit"] 	= /obj/item/clothing/under/resomi/deckers_jumpsuit
	resomi["black suit"] = /obj/item/clothing/under/resomi/black_suit
	resomi["white suit"] = /obj/item/clothing/under/resomi/white_suit
	resomi["blue suit"] = /obj/item/clothing/under/resomi/blue_suit
	//resomi["com suit"] = /obj/item/clothing/under/resomi/com
	resomi["com blue suit"] = /obj/item/clothing/under/resomi/com_blue
	resomi["tactical suit"] = /obj/item/clothing/under/resomi/tactical
	resomi["maid suit"] = /obj/item/clothing/under/resomi/maid

	gear_tweaks += new/datum/gear_tweak/path(resomi)

/datum/gear/eyes/resomi
	display_name = "(Resomi) sun lenses"
	path = /obj/item/clothing/glasses/sunglasses/lenses
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)

/datum/gear/eyes/resomi/lenses_sec
	display_name = "(Resomi) sun sechud lenses"
	path = /obj/item/clothing/glasses/hybrid/sechud/resomi

/datum/gear/eyes/resomi/lenses_med
	display_name = "(Resomi) sun medhud lenses"
	path = /obj/item/clothing/glasses/hybrid/medhud/resomi
/*
/datum/gear/eyes/resomi/visor
	display_name = "(Resomi) visor"
	path = /obj/item/clothing/glasses/sunglasses/lenses/visor
*/
/datum/gear/eyes/resomi/visor_col
	display_name = "(Resomi) visor, colored"
	path = /obj/item/clothing/glasses/sunglasses/lenses/visor_col
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/eyes/resomi/visor_medhud
	display_name = "(Resomi) visor, medhud"
	path = /obj/item/clothing/glasses/hybrid/medhud/resomi/visor

/datum/gear/eyes/resomi/visor_sechud
	display_name = "(Resomi) visor, sechud"
	path = /obj/item/clothing/glasses/hybrid/sechud/resomi/visor

/datum/gear/eyes/resomi/visor_meson
	display_name = "(Resomi) visor, meson"
	path = /obj/item/clothing/glasses/meson/resomi/visor

/datum/gear/accessory/resomi_mantle
	display_name = "(Resomi) small mantle"
	path = /obj/item/clothing/accessory/scarf/resomi
	flags = GEAR_HAS_COLOR_SELECTION
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)

/datum/gear/suit/resomi_cloak
	display_name = "(Resomi) small cloak"
	path = /obj/item/clothing/suit/storage/toggle/Resomicoat
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)

/datum/gear/suit/resomi_cloak/New()
	..()
	var/resomi = list()
	resomi["black cloak"] = /obj/item/clothing/suit/storage/toggle/Resomicoat
	resomi["white cloak"] = /obj/item/clothing/suit/storage/toggle/Resomicoat/white
	gear_tweaks += new/datum/gear_tweak/path(resomi)

/datum/gear/suit/resomi_jacket
	display_name = "(Resomi) small jacket"
	path = /obj/item/clothing/suit/storage/toggle/resomi_jacket
	flags = GEAR_HAS_TYPE_SELECTION
	sort_category = "Xenowear"

/datum/gear/suit/resomi_wintercoat
	display_name = "(Resomi) small wintercoat"
	path = /obj/item/clothing/suit/storage/hooded/resomi/wintercoat
	flags = GEAR_HAS_TYPE_SELECTION
	sort_category = "Xenowear"

/datum/gear/uniform/resomi/turtleneck
	display_name = "(Resomi) small turtleneck"
	path = /obj/item/clothing/under/resomi/turtleneck
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/clothing/resomi_spes_cloak
	display_name = "(Resomi) accessory cloak, colored"
	path = /obj/item/clothing/accessory/cloak/resomi
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)
	flags = GEAR_HAS_COLOR_SELECTION
	slot = slot_wear_suit

/datum/gear/clothing/resomi_spes_job_cloak
	display_name = "(Resomi) accessory cloak selection"
	path = /obj/item/clothing/accessory/cloak/resomi/rd
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)
	slot = slot_wear_suit

/datum/gear/clothing/resomi_spes_job_cloak/New()
	..()
	var/resomi = list()
	resomi["command cloak"] = /obj/item/clothing/accessory/cloak/resomi/hop
	resomi["medical cloak"] = /obj/item/clothing/accessory/cloak/resomi/cmo
	resomi["science cloak"] = /obj/item/clothing/accessory/cloak/resomi/rd
	gear_tweaks += new/datum/gear_tweak/path(resomi)

/datum/gear/shoes/resomi
	display_name = "(Resomi) small workboots"
	path = /obj/item/clothing/shoes/workboots/resomi
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)

/datum/gear/shoes/resomi/footwraps
	display_name = "(Resomi) foots clothwraps"
	flags = GEAR_HAS_COLOR_SELECTION
	path = /obj/item/clothing/shoes/footwraps

/datum/gear/shoes/resomi/socks
	display_name = "(Resomi) koishi"
	flags = GEAR_HAS_COLOR_SELECTION
	path = /obj/item/clothing/shoes/footwraps/socks_resomi

/datum/gear/suit/resomi_labcoat
	display_name = "(Resomi) small labcoat"
	path = /obj/item/clothing/suit/storage/toggle/Resomilabcoat
	flags = GEAR_HAS_COLOR_SELECTION
	sort_category = "Xenowear"
	whitelisted = list(SPECIES_RESOMI)
