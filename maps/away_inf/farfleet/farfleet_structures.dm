	///////////////
	//GUNCABINETS//
	///////////////

/obj/structure/closet/secure_closet/guncabinet/farfleet
	name = "droptrops cabinet"
	req_access = list(access_away_iccgn_droptroops)

/obj/structure/closet/secure_closet/guncabinet/farfleet/antitank/WillContain()
	return list(
		/obj/item/gun/projectile/rocket/oneuse/rpg18 = 3,
		/obj/item/gun/magnetic/railgun/tcc  = 1
	)

/obj/structure/closet/secure_closet/guncabinet/farfleet/assault/WillContain()
	return list(
		/obj/item/ammo_magazine/rifle = 15,
		/obj/item/gun/projectile/automatic/iccg_rifle = 3,
		/obj/item/gun/projectile/shotgun/magazine = 1,
		/obj/item/clothing/accessory/storage/bandolier = 1,
		/obj/item/ammo_magazine/c12m = 6,
		/obj/item/ammo_magazine/c12m/buckshot = 4,
		/obj/item/ammo_magazine/c12m/shock = 4
	)

/obj/structure/closet/secure_closet/guncabinet/farfleet/defence/WillContain()
	return list(
		/obj/item/ammo_magazine/speedloader/clip = 6,
		/obj/item/ammo_magazine/pistol/double = 6,
		/obj/item/gun/projectile/heavysniper/boltaction = 2,
		/obj/item/clothing/accessory/storage/bandolier = 1,
		/obj/item/gun/projectile/shotgun/pump = 1,
		/obj/item/gun/projectile/pistol/military/alt = 3
	)

/obj/structure/closet/secure_closet/guncabinet/farfleet/utility/WillContain()
	return list(
		/obj/item/storage/box/teargas = 1,
		/obj/item/storage/box/frags = 1,
		/obj/item/storage/box/smokes = 2,
		/obj/item/storage/box/ammo/flashshells = 2,
		/obj/item/storage/box/ammo/shotgunshells = 2,
		/obj/item/storage/box/ammo/shotgunammo = 2,
		/obj/item/storage/box/ammo/stunshells = 2,
		/obj/item/plastique/super = 6
	)

	///////////
	//CLOSETS//
	///////////

/obj/structure/closet/secure_closet/farfleet
	name = "trooper locker"
	closet_appearance = /decl/closet_appearance/secure_closet/farfleet/two
	req_access = list(access_away_iccgn_droptroops)

/obj/structure/closet/secure_closet/patrol/WillContain()
	return list(
		/obj/item/storage/belt/security,
		/obj/item/melee/telebaton,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/clothing/glasses/tacgoggles,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/gloves/thick/combat/marine,
		/obj/item/device/flashlight/maglight,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/mask/balaclava,
		/obj/item/combitool,
		/obj/item/gun/energy/gun,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/accessory/armorplate/merc,
		/obj/item/clothing/head/helmet/tactical,
		/obj/item/clothing/under/iccgn/pt,
		/obj/item/storage/backpack/satchel/pocketbook
	)


/obj/structure/closet/secure_closet/farfleet/sergeant
	name = "droptroops sergeant locker"
	closet_appearance = /decl/closet_appearance/secure_closet/farfleet/two
	req_access = list(access_away_iccgn_sergeant)


/obj/structure/closet/secure_closet/farfleet/sergeant/WillContain()
	return list(
		/obj/item/storage/belt/security,
		/obj/item/melee/telebaton,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/clothing/glasses/tacgoggles,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/gloves/thick/combat/marine,
		/obj/item/device/flashlight/maglight,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/device/megaphone,
		/obj/item/clothing/mask/balaclava,
		/obj/item/storage/fancy/cigarettes/case,
		/obj/item/flame/lighter/zippo/gunmetal,
		/obj/item/clothing/mask/gas/alt,
		/obj/item/combitool,
		/obj/item/clothing/gloves/wristwatch,
		/obj/item/gun/energy/gun,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/accessory/armorplate/merc,
		/obj/item/clothing/head/helmet/tactical,
		/obj/item/clothing/under/iccgn/pt,
		/obj/item/storage/backpack/satchel/pocketbook
	)

/obj/structure/closet/secure_closet/farfleet/fleet
	name = "fleet cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/farfleet
	req_access = list(access_away_iccgn)

/obj/structure/closet/secure_closet/farfleet/fleet/WillContain()
	return list(
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/accessory/storage/black_drop,
		/obj/item/clothing/mask/gas/alt,
		/obj/item/combitool,
		/obj/item/clothing/gloves/thick,
		/obj/item/clothing/under/iccgn/utility,
		/obj/item/storage/backpack/satchel/pocketbook/navy
	)

/obj/structure/closet/secure_closet/farfleet/fleet/engi
	name = "fleet technician cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/farfleet
	req_access = list(access_away_iccgn)

/obj/structure/closet/secure_closet/farfleet/fleet/engi/WillContain()
	return list(
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/accessory/storage/black_drop,
		/obj/item/clothing/mask/gas/alt,
		/obj/item/clothing/under/iccgn/utility,
		/obj/item/storage/belt/utility/full,
		/obj/item/device/multitool,
		/obj/item/device/multitool/multimeter,
		/obj/item/clothing/glasses/welding/superior,
		/obj/item/clothing/head/hardhat/orange,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/clothing/under/iccgn/utility,
		/obj/item/combitool,
		/obj/item/storage/backpack/satchel/pocketbook/navy
	)

/obj/structure/closet/secure_closet/farfleet/fleet/med
	name = "medic cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/farfleet
	req_access = list(access_away_iccgn)

/obj/structure/closet/secure_closet/farfleet/fleet/med/WillContain()
	return list(
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/accessory/storage/black_drop,
		/obj/item/clothing/mask/gas/alt,
		/obj/item/storage/belt/medical,
		/obj/item/storage/firstaid/adv,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/clothing/glasses/hud/health,
		/obj/item/combitool,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/gloves/latex/nitrile,
		/obj/item/clothing/under/rank/medical/scrubs/black,
		/obj/item/clothing/head/surgery/black,
		/obj/item/clothing/suit/storage/hazardvest/white,
		/obj/item/clothing/under/iccgn/utility,
		/obj/item/storage/backpack/satchel/pocketbook/navy
	)

/obj/structure/closet/secure_closet/farfleet/fleet_cpt
	name = "captain cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/farfleet
	req_access = list(access_away_iccgn, access_away_iccgn_captain)

/obj/structure/closet/secure_closet/farfleet/fleet_cpt/WillContain()
	return list(
		/obj/item/melee/telebaton,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/device/megaphone,
		/obj/item/clothing/accessory/storage/black_drop,
		/obj/item/clothing/mask/gas/alt,
		/obj/item/storage/fancy/cigar,
		/obj/item/storage/fancy/cigarettes/case,
		/obj/item/flame/lighter/zippo/gunmetal,
		/obj/item/gun/projectile/pistol/magnum_pistol,
		/obj/item/combitool,
		/obj/item/clothing/gloves/wristwatch/gold,
		/obj/item/clothing/under/iccgn/service_command,
		/obj/item/storage/backpack/satchel/pocketbook/navy
	)


/obj/structure/closet/wardrobe/patrol
	name = "military attire closet"
	closet_appearance = /decl/closet_appearance/tactical


/obj/structure/closet/wardrobe/patrol/desert
	name = "desert attire closet"
	closet_appearance = /decl/closet_appearance/tactical

/obj/structure/closet/wardrobe/patrol/desert/WillContain()
	return list(
	/obj/item/clothing/under/solgov/utility/army/tan = 3,
	/obj/item/clothing/head/solgov/utility/army/tan = 3,
	/obj/item/clothing/shoes/tactical = 3,
	/obj/item/clothing/gloves/thick/combat = 3
	)

/obj/structure/closet/wardrobe/patrol/army
	name = "woodland attire closet"
	closet_appearance = /decl/closet_appearance/tactical

/obj/structure/closet/wardrobe/patrol/army/WillContain()
	return list(
	/obj/item/clothing/under/solgov/utility/army  = 3,
	/obj/item/clothing/head/solgov/utility/army = 3,
	/obj/item/clothing/shoes/jungleboots = 3,
	/obj/item/clothing/gloves/thick/combat = 3
	)

	////////
	//MISC//
	////////

/obj/machinery/door/airlock/autoname/command
	req_access = list(access_away_iccgn)

/obj/machinery/door/airlock/autoname/engineering
	req_access = list(access_away_iccgn)

/obj/machinery/door/airlock/autoname/droptroops
	req_access = list(access_away_iccgn)

/* Voidsuit Storage Unit
 * ====
 */

/obj/machinery/suit_storage_unit/away_iccgn_med
	name = "Farfleet Medic Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/medical/alt/sol/prepared
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	req_access = list(access_away_iccgn)
	islocked = 1

/obj/machinery/suit_storage_unit/away_iccgn_eng
	name = "Ordnance Technician Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/engineering/alt/sol/prepared
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	req_access = list(access_away_iccgn)
	islocked = 1

/obj/machinery/suit_storage_unit/away_iccgn_com
	name = "Captain Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/command/prepared
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	req_access = list(access_away_iccgn, access_away_iccgn_captain)
	islocked = 1

/obj/structure/sign/farfleetplaque
	name = "\improper Farfleet Plaque"
	desc = "A plaque with Decree of Farfleet foundation etched on it."
	icon = 'maps/away_inf/farfleet/icons/iccg_flag.dmi'
	icon_state = "ecplaque"

/obj/effect/floor_decal/iccglogo
	icon = 'maps/away_inf/farfleet/icons/GCC-floor.dmi'
	icon_state = "center"

/obj/effect/floor_decal/iccglogo/center_left
	icon_state = "center_left"

/obj/effect/floor_decal/iccglogo/center_right
	icon_state = "center_right"

/obj/effect/floor_decal/iccglogo/top_center
	icon_state = "top_center"

/obj/effect/floor_decal/iccglogo/top_left
	icon_state = "top_left"

/obj/effect/floor_decal/iccglogo/top_right
	icon_state = "top_right"

/obj/effect/floor_decal/iccglogo/bottom_center
	icon_state = "bottom_center"

/obj/effect/floor_decal/iccglogo/bottom_left
	icon_state = "bottom_left"

/obj/effect/floor_decal/iccglogo/bottom_right
	icon_state = "bottom_right"

/obj/effect/floor_decal/iccglogo/corner
	icon_state = "gcc_corner"

/obj/structure/sign/iccg
	name = "\improper ICCG Seal"
	desc = "A sign which signifies who this vessel belongs to."
	icon = 'maps/away_inf/farfleet/icons/iccg_flag.dmi'
	icon_state = "GCC slog"

/obj/structure/sign/double/iccgflag
	name = "ICCG Flag"
	desc = "The flag of the Independent Colonial Confederation of Gilgamesh, a symbol of Motherland to many proud peoples."
	icon = 'maps/away_inf/farfleet/icons/iccg_flag.dmi'

/obj/structure/sign/double/iccgflag/left
	icon_state = "GCCflag-left"

/obj/structure/sign/double/iccgflag/right
	icon_state = "GCCflag-right"
