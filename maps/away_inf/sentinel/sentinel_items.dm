
/* CARDS
 * ========
 */

/obj/item/card/id/awaycavalry/ops
	desc = "An identification card issued to SolGov crewmembers aboard the Sol Patrol Craft."
	icon_state = "base"
	access = list(access_away_cavalry, access_away_cavalry_ops)

/obj/item/card/id/awaycavalry/ops/captain
	desc = "An identification card issued to SolGov crewmembers aboard the Sol Patrol Craft."
	icon_state = "base"
	access = list(access_away_cavalry, access_away_cavalry_ops, access_away_cavalry_captain)

/obj/item/card/id/awaycavalry/fleet
	desc = "An identification card issued to SolGov crewmembers aboard the Sol Patrol Craft."
	icon_state = "base"
	access = list(access_away_cavalry)

/obj/item/card/id/awaycavalry/fleet/commander
	desc = "An identification card issued to SolGov crewmembers aboard the Sol Patrol Craft."
	icon_state = "base"
	access = list(access_away_cavalry, access_away_cavalry_commander)

/* RADIOHEADS
 * ========
 */

/obj/item/device/radio/headset/rescue
	name = "rescue team radio headset"
	desc = "The headset of the rescue team member."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/rescue

/obj/item/device/radio/headset/rescue/leader
	name = "rescue team leader radio headset"
	desc = "The headset of the rescue team member."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/rescue/leader

/obj/item/device/encryptionkey/rescue //for events
	name = "\improper rescue radio encryption key"
	icon_state = "cargo_cypherkey"
	channels = list("Response Team" = 1)

/obj/item/device/encryptionkey/rescue/leader
	name = "\improper rescue leader radio encryption key"
	channels = list("Response Team" = 1, "Command" = 1, )

/* CLOTHING
 * ========
 */

/obj/item/clothing/under/solgov/utility/fleet/officer/pilot1/away_solpatrol
	starting_accessories = list(
		/obj/item/clothing/accessory/solgov/specialty/pilot,
		/obj/item/clothing/accessory/solgov/fleet_patch/fifth
	)

/obj/item/clothing/under/solgov/utility/fleet/officer/command/commander/away_solpatrol
	starting_accessories = list(
		/obj/item/clothing/accessory/solgov/department/command/fleet,
		/obj/item/clothing/accessory/solgov/specialty/pilot,
		/obj/item/clothing/accessory/solgov/fleet_patch/fifth
	)

/obj/item/clothing/under/solgov/utility/fleet/engineering/away_solpatrol
	starting_accessories = list(
		/obj/item/clothing/accessory/solgov/department/engineering/fleet,
		/obj/item/clothing/accessory/solgov/fleet_patch/fifth
	)

/obj/item/clothing/under/solgov/utility/fleet/medical/away_solpatrol
	starting_accessories = list(
		/obj/item/clothing/accessory/solgov/department/medical/fleet,
		/obj/item/clothing/accessory/solgov/fleet_patch/fifth
	)

/obj/item/clothing/under/solgov/utility/fleet/away_solpatrol
	starting_accessories = list(
		/obj/item/clothing/accessory/solgov/department/command/fleet,
		/obj/item/clothing/accessory/solgov/fleet_patch/fifth
	)

/obj/item/clothing/suit/storage/solgov/service/fleet/command/away_solpatrol
	starting_accessories = list(
		/obj/item/clothing/accessory/solgov/rank/fleet/officer/o6,
		/obj/item/clothing/accessory/solgov/specialty/officer
	)

/obj/item/storage/belt/holster/security/tactical/away_solpatrol/New()
	..()
	new /obj/item/gun/projectile/pistol/military(src)
	new /obj/item/ammo_magazine/pistol/double(src)
	new /obj/item/ammo_magazine/pistol/double(src)

/obj/item/storage/belt/holster/general/away_solpatrol/New()
	..()
	new /obj/item/modular_computer/tablet/preset/custom_loadout/advanced(src)
	new /obj/item/gun/projectile/revolver/medium(src)

/obj/item/clothing/accessory/armband/bluegold/away_solpatrol
	name = "SCG armband"
	desc = "An armband, worn by the crew to display which country they represent. This one is blue and gold."
	icon_state = "solblue"
/* MISC
 * ========
 */