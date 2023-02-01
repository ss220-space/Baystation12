/obj/item/clothing/accessory/iccgn_rank
	name = "base rank insignia, ICCGN"
	desc = "You should not see this."
	icon = 'packs/faction_iccgn/obj_accessories_lordania.dmi'
	accessory_icons = list(
		slot_w_uniform_str = 'packs/faction_iccgn/onmob_accessories_lordania.dmi',
		slot_wear_suit_str = 'packs/faction_iccgn/onmob_accessories_lordania.dmi'
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
	name = "ranks (E-2 private first class)"
	desc = "Insignia denoting the rank of Private First Class."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e3
	icon_state = "ME3"
	name = "ranks (E-3 lance corporal)"
	desc = "Insignia denoting the rank of Lance Corporal."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e4
	icon_state = "ME4"
	name = "ranks (E-4 corporal)"
	desc = "Insignia denoting the rank of Corporal."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e5
	icon_state = "ME5"
	name = "ranks (E-5 sergeant)"
	desc = "Insignia denoting the rank of Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e6
	icon_state = "ME6"
	name = "ranks (E-6 staff sergeant)"
	desc = "Insignia denoting the rank of Staff Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e7
	icon_state = "ME7"
	name = "ranks (E-7 gunnery sergeant)"
	desc = "Insignia denoting the rank of Gunnery Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e8
	icon_state = "ME8"
	name = "ranks (E-8 master sergeant)"
	desc = "Insignia denoting the rank of Master Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e8_alt
	icon_state = "ME8A"
	name = "ranks (E-8 first sergeant)"
	desc = "Insignia denoting the rank of First Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e9
	icon_state = "ME9"
	name = "ranks (E-9 master gunnery sergeant)"
	desc = "Insignia denoting the rank of Master Gunnery Sergeant."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e9_alt
	icon_state = "ME9A"
	name = "ranks (E-9 sergeant major)"
	desc = "Insignia denoting the rank of Sergeant Major."

/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e9_alt2
	icon_state = "ME9B"
	name = "ranks (E-9 sergeant major of the marine Corps)"
	desc = "Insignia denoting the rank of Sergeant Major of the Marine Corps."

/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer
	icon_state = "MW0"
	overlay_state = "armyrank_warrant_gold"

/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w1
	icon_state = "MW1"
	name = "ranks (W-1 warrant officer)"
	desc = "Insignia denoting the rank of Warrant Officer"

/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w2
	icon_state = "MW2"
	name = "ranks (W-2 second warrant officer"
	desc = "Insignia denoting the rank of Second Warrant Officer"

/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w3
	icon_state = "MW3"
	overlay_state = "armyrank_warrant_silver"
	name = "ranks (W-3 first warrant officer)"
	desc = "Insignia denoting the rank of First Warrant Officer"

/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w4
	icon_state = "MW4"
	name = "ranks (W-4 major warrant officer)"
	overlay_state = "armyrank_warrant_silver"
	desc = "Insignia denoting the rank of Major Warrant Officer"

/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w5
	icon_state = "MW5"
	overlay_state = "armyrank_warrant_stripe"
	name = "ranks (W-5 general warrant officer)"
	desc = "Insignia denoting the rank of General Warrant Officer"

/obj/item/clothing/accessory/iccgn_rank/marine/officer
	icon_state = "MO1A"
	overlay_state = "armyrank_officer"
	name = "ranks (O-1 second lieutenant)"
	desc = "Insignia denoting the rank of Second Lieutenant."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o2
	icon_state = "MO2"
	name = "ranks (O-2 first lieutenant)"
	desc = "Insignia denoting the rank of First Lieutenant."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3
	icon_state = "MO3"
	name = "ranks (O-3 captain)"
	desc = "Insignia denoting the rank of Captain."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3_alt
	icon_state = "MO3"
	name = "ranks (O-3 Marine captain)"
	desc = "Insignia denoting the rank of Marine Captain."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3_alt2
	icon_state = "MO3"
	name = "ranks (O-3 specialist captain)"
	desc = "Insignia denoting the rank of Specialist Captain."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o4
	icon_state = "MO4"
	name = "ranks (O-4 major)"
	desc = "Insignia denoting the rank of Major."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o5
	icon_state = "MO5"
	name = "ranks (O-5 lieutenant colonel)"
	desc = "Insignia denoting the rank of Lieutenant Colonel."

/obj/item/clothing/accessory/iccgn_rank/marine/officer/o6
	icon_state = "MO6"
	name = "ranks (O-6 colonel)"
	desc = "Insignia denoting the rank of Colonel."

/obj/item/clothing/accessory/iccgn_rank/marine/flag
	icon_state = "MO7"
	overlay_state = "armyrank_command"
	name = "ranks (O-7 brigadier general)"
	desc = "Insignia denoting the rank of Brigadier General."
	icon_state = "armyrank_command"

/obj/item/clothing/accessory/iccgn_rank/marine/flag/o8
	icon_state = "MO8"
	name = "ranks (O-8 major general)"
	desc = "Insignia denoting the rank of Major General."

/obj/item/clothing/accessory/iccgn_rank/marine/flag/o9
	icon_state = "MO9"
	name = "ranks (O-9 lieutenant general)"
	desc = "Insignia denoting the rank of Lieutenant General."

/obj/item/clothing/accessory/iccgn_rank/marine/flag/o10
	icon_state = "MO10"
	name = "ranks (O-10 general)"
	desc = "Insignia denoting the rank of General."
