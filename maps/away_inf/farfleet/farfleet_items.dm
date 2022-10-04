
/* CARDS
 * ========
 */

/obj/item/card/id/farfleet/droptroops
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn, access_away_iccgn_droptroops)

/obj/item/card/id/farfleet/droptroops/sergeant
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn, access_away_iccgn_droptroops, access_away_iccgn_sergeant)

/obj/item/card/id/farfleet/fleet
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn)

/obj/item/card/id/farfleet/fleet/captain
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn, access_away_iccgn_captain)

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


/obj/item/clothing/under/iccgn/service_command
	starting_accessories = list(
		/obj/item/clothing/accessory/iccgn_rank/of6,
		/obj/item/clothing/accessory/iccgn_patch/ordnance
	)

/obj/item/clothing/under/iccgn/service
	starting_accessories = list(
		/obj/item/clothing/accessory/iccgn_rank/or3
	)

/obj/item/clothing/under/iccgn/utility
	starting_accessories = list(
		/obj/item/clothing/accessory/iccgn_rank/or3,
		/obj/item/clothing/accessory/iccgn_patch/ordnance
	)

/obj/item/clothing/under/iccgn/pt
	starting_accessories = list(
		/obj/item/clothing/accessory/iccgn_rank/or3,
		/obj/item/clothing/accessory/iccgn_patch/pioneer
	)

/obj/item/storage/belt/holster/security/tactical/farfleet/New()
	..()
	new /obj/item/gun/projectile/pistol/military/alt(src)
	new /obj/item/ammo_magazine/pistol/double(src)
	new /obj/item/ammo_magazine/pistol/double(src)

/* MISC
 * ========
 */
