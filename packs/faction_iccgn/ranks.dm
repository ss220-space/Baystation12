/obj/item/clothing/accessory/iccgn_rank
	name = "base rank insignia, ICCGN"
	desc = "You should not see this."
	icon = 'packs/faction_iccgn/obj_accessories_iccgn.dmi'
	accessory_icons = list(
		slot_w_uniform_str = 'packs/faction_iccgn/onmob_accessories_iccgn.dmi',
		slot_wear_suit_str = 'packs/faction_iccgn/onmob_accessories_iccgn.dmi'
	)
	icon_state = "error"
	overlay_state = "error"
	w_class = ITEM_SIZE_TINY
	slot = ACCESSORY_SLOT_RANK
	gender = PLURAL


/obj/item/clothing/accessory/iccgn_rank/get_fibers()
	return null

/obj/item/clothing/accessory/iccgn_rank/marine
	icon_state = "ME0"
	name = "marine ranks"
	desc = "Insignia denoting marine rank of some kind. These appear blank."
	overlay_state = "armyrank_enlisted"

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted
	icon_state = "ME1"
	name = "ranks (E-1 private)"
	desc = "Insignia denoting the rank of Private."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e2
	icon_state = "ME2"
	name = "ranks (E-2 corporal)"
	desc = "Insignia denoting the rank of Corporal."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e3
	icon_state = "ME3"
	name = "ranks (E-3 junior sergeant)"
	desc = "Insignia denoting the rank of Junior Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e4
	icon_state = "ME4"
	name = "ranks (E-4 sergeant)"
	desc = "Insignia denoting the rank of Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e5
	icon_state = "ME5"
	name = "ranks (E-5 senior sergeant)"
	desc = "Insignia denoting the rank of Senior Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e6
	icon_state = "ME6"
	name = "ranks (E-6 staff sergeant)"
	desc = "Insignia denoting the rank of Staff Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e7
	icon_state = "ME7"
	name = "ranks (E-7 michman)"
	desc = "Insignia denoting the rank of Michman."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e8
	icon_state = "ME8A"
	name = "ranks (E-8 senior michman)"
	desc = "Insignia denoting the rank of senior michman."

/obj/item/clothing/accessory/iccgn_rank/marine/officer
	icon_state = "MO1"
	overlay_state = "armyrank_officer"
	name = "ranks (O-1 junior lieutenant)"
	desc = "Insignia denoting the rank of Junior Lieutenant."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o2
	icon_state = "MO2"
	name = "ranks (O-2 lieutenant)"
	desc = "Insignia denoting the rank of Lieutenant."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3
	icon_state = "MO3"
	name = "ranks (O-3 senior lieutenant)"
	desc = "Insignia denoting the rank of Senior Lieutenant."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o4
	icon_state = "MO4"
	name = "ranks (O-4 captain-leutnant)"
	desc = "Insignia denoting the rank of Captain-leutnant."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o5
	icon_state = "MO5"
	name = "ranks (O-5 captain of the third rank)"
	desc = "Insignia denoting the rank of captain of the third rank."

/obj/item/clothing/accessory/iccgn_rank/marine/flag
	icon_state = "MO6"
	overlay_state = "armyrank_command"
	name = "ranks (O-6 captain of the second rank)"
	desc = "Insignia denoting the rank of Captain of the second rank."
	icon_state = "armyrank_command"

/obj/item/clothing/accessory/iccgn_rank/marine/flag/o7
	icon_state = "MO7"
	name = "ranks (O-7 captain of the first rankonel)"
	desc = "Insignia denoting the rank of Captain of the first rank."

/obj/item/clothing/accessory/iccgn_rank/marine/flag/o8
	icon_state = "MO8"
	name = "ranks (O-8 rear admiral)"
	desc = "Insignia denoting the rank of Rear Admiral."

/obj/item/clothing/accessory/iccgn_rank/marine/flag/o9
	icon_state = "MO9"
	name = "ranks (O-9 vice admiral)"
	desc = "Insignia denoting the rank of Vice Admiral."

/obj/item/clothing/accessory/iccgn_rank/marine/flag/o10
	icon_state = "MO10"
	name = "ranks (O-10 admiral)"
	desc = "Insignia denoting the rank of Admiral."
/obj/item/clothing/accessory/iccgn_rank/marine/flag/o10
	icon_state = "MO11"
	name = "ranks (O-10 admiral of the fleet)"
	desc = "Insignia denoting the rank of Admiral of the Fleet."
