	///////////////
	//GUNCABINETS//
	///////////////

/obj/structure/closet/secure_closet/guncabinet/patrol
	name = "tempest group cabinet"
	req_access = list(access_away_cavalry_captain)

/obj/structure/closet/secure_closet/guncabinet/patrol/energy/WillContain()
	return list(
		/obj/item/gun/energy/ionrifle/small  = 1,
		/obj/item/gun/energy/plasmastun = 1,
		/obj/item/gun/energy/sniperrifle = 1
	)

/obj/structure/closet/secure_closet/guncabinet/patrol/assault/WillContain()
	return list(
		/obj/item/ammo_magazine/uni46x30mm = 15,
		/obj/item/gun/projectile/automatic/invider = 3,
		/obj/item/gun/projectile/shotgun/magazine = 1,
		/obj/item/clothing/accessory/storage/bandolier = 1,
		/obj/item/ammo_magazine/c12m = 6,
		/obj/item/ammo_magazine/c12m/buckshot = 4,
		/obj/item/ammo_magazine/c12m/shock = 4
	)

/obj/structure/closet/secure_closet/guncabinet/patrol/carabine/WillContain()
	return list(
		/obj/item/ammo_magazine/c12755 = 8,
		/obj/item/gun/projectile/automatic/amrcarabine = 1,
		/obj/item/clothing/accessory/storage/bandolier = 1,
		/obj/item/gun/projectile/shotgun/pump = 1,
		/obj/item/gun/projectile/pistol/military = 3
	)

/obj/structure/closet/secure_closet/guncabinet/patrol/utility/WillContain()
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

/obj/structure/closet/secure_closet/patrol
	name = "trooper locker"
	closet_appearance = /decl/closet_appearance/secure_closet/sol/two/dark
	req_access = list(access_away_cavalry_ops)

/obj/structure/closet/secure_closet/patrol/WillContain()
	return list(
		/obj/item/storage/belt/holster/security/tactical,
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
		/obj/item/storage/backpack/satchel/pocketbook
	)


/obj/structure/closet/secure_closet/patrol/marine_lead
	name = "squad leader locker"
	closet_appearance = /decl/closet_appearance/secure_closet/sol/two/dark
	req_access = list(access_away_cavalry_captain)


/obj/structure/closet/secure_closet/patrol/marine_lead/WillContain()
	return list(
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/melee/telebaton,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/clothing/glasses/tacgoggles,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/gloves/thick/combat/marine,
		/obj/item/device/flashlight/maglight,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/device/megaphone,
		/obj/item/clothing/mask/balaclava,
		/obj/item/clothing/accessory/armor/tag/solgov/com,
		/obj/item/storage/fancy/cigarettes/case,
		/obj/item/flame/lighter/zippo/gunmetal,
		/obj/item/clothing/mask/gas/alt,
		/obj/item/combitool,
		/obj/item/clothing/gloves/wristwatch,
		/obj/item/gun/energy/gun,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/accessory/armorplate/merc,
		/obj/item/clothing/head/helmet/tactical,
		/obj/item/storage/backpack/satchel/pocketbook
	)

/obj/structure/closet/secure_closet/patrol/fleet
	name = "fleet pilot cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/sol
	req_access = list(access_away_cavalry)

/obj/structure/closet/secure_closet/patrol/fleet/WillContain()
	return list(
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/mask/gas,
		/obj/item/combitool,
		/obj/item/clothing/under/solgov/utility/fleet/polopants/command,
		/obj/item/clothing/head/solgov/dress/fleet,
		/obj/item/clothing/head/beret/solgov/fleet/command,
		/obj/item/clothing/accessory/solgov/department/command/fleet,
		/obj/item/clothing/suit/storage/solgov/service/fleet/officer
	)

/obj/structure/closet/secure_closet/patrol/fleet/engi
	name = "fleet technician cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/sol
	req_access = list(access_away_cavalry)

/obj/structure/closet/secure_closet/patrol/fleet/engi/WillContain()
	return list(
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/mask/gas,
		/obj/item/storage/belt/utility/full,
		/obj/item/device/multitool,
		/obj/item/device/multitool/multimeter,
		/obj/item/clothing/glasses/welding/superior,
		/obj/item/clothing/head/hardhat/orange,
		/obj/item/clothing/suit/storage/hazardvest,
		/obj/item/combitool,
		/obj/item/clothing/head/beret/solgov/fleet/engineering,
		/obj/item/clothing/head/solgov/dress/fleet/garrison,
		/obj/item/clothing/under/solgov/utility/fleet/polopants,
		/obj/item/clothing/accessory/solgov/department/engineering/fleet,
		/obj/item/clothing/suit/storage/solgov/service/fleet
	)

/obj/structure/closet/secure_closet/patrol/fleet/med
	name = "fleet corpsman cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/sol
	req_access = list(access_away_cavalry)

/obj/structure/closet/secure_closet/patrol/fleet/med/WillContain()
	return list(
		/obj/item/storage/firstaid/individual/military,
		/obj/item/clothing/mask/gas,
		/obj/item/storage/belt/medical,
		/obj/item/clothing/head/beret/solgov/fleet/medical,
		/obj/item/storage/firstaid/adv,
		/obj/item/clothing/accessory/stethoscope,
		/obj/item/clothing/glasses/hud/health,
		/obj/item/combitool,
		/obj/item/clothing/suit/storage/toggle/labcoat,
		/obj/item/clothing/gloves/latex/nitrile,
		/obj/item/clothing/under/rank/medical/scrubs/black,
		/obj/item/clothing/head/surgery/black,
		/obj/item/clothing/suit/storage/hazardvest/white,
		/obj/item/clothing/head/solgov/dress/fleet,
		/obj/item/clothing/under/solgov/utility/fleet/polopants/command,
		/obj/item/clothing/accessory/solgov/department/medical/fleet,
		/obj/item/clothing/suit/storage/solgov/service/fleet/officer
	)

/obj/structure/closet/secure_closet/patrol/fleet_com
	name = "fleet commander cabinet"
	closet_appearance = /decl/closet_appearance/secure_closet/sol
	req_access = list(access_away_cavalry, access_away_cavalry_commander)

/obj/structure/closet/secure_closet/patrol/fleet_com/WillContain()
	return list(
		/obj/item/melee/telebaton,
		/obj/item/storage/firstaid/individual/military,
		/obj/item/device/megaphone,
		/obj/item/clothing/accessory/armor/tag/solgov/com,
		/obj/item/clothing/mask/gas,
		/obj/item/storage/fancy/cigar,
		/obj/item/storage/fancy/cigarettes/case,
		/obj/item/flame/lighter/zippo/gunmetal,
		/obj/item/clothing/head/beret/solgov/fleet/command,
		/obj/item/clothing/under/solgov/utility/fleet/polopants/command,
		/obj/item/gun/projectile/revolver/medium,
		/obj/item/combitool,
		/obj/item/clothing/gloves/wristwatch/gold,
		/obj/item/clothing/head/solgov/dress/fleet,
		/obj/item/clothing/accessory/solgov/department/command/fleet,
		/obj/item/clothing/suit/storage/solgov/service/fleet/officer
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

/obj/structure/closet/wardrobe/patrol/urban
	name = "urban attire closet"
	closet_appearance = /decl/closet_appearance/tactical

/obj/structure/closet/wardrobe/patrol/urban/WillContain()
	return list(
	/obj/item/clothing/under/solgov/utility/army/urban  = 3,
	/obj/item/clothing/head/solgov/utility/army/urban = 3,
	/obj/item/clothing/shoes/dutyboots = 3,
	/obj/item/clothing/gloves/thick/combat/marine = 3
	)

	////////
	//MISC//
	////////

/obj/machinery/door/airlock/autoname/command
	req_access = list(access_away_cavalry)

/obj/machinery/door/airlock/autoname/engineering
	req_access = list(access_away_cavalry)

/obj/machinery/door/airlock/autoname/marine
	req_access = list(access_away_cavalry)

/obj/machinery/vending/away_solpatrol_uniform
	name = "Fleet uniform dispenser"
	desc = "A specialized vending machine with nice and fresh navy-blue clothing inside. For military personnel only."
	icon = 'icons/obj/vending.dmi'
	icon_state = "uniform_fleet"
	icon_deny = "uniform_fleet-deny"
	icon_vend = "uniform_fleet-vend"
	vend_delay = 15
	req_access = list(access_away_cavalry)
	products = list(/obj/item/clothing/head/beret/solgov/fleet/branch/fifth = 5,
					/obj/item/clothing/head/soft/solgov/fleet = 5,
					/obj/item/clothing/head/ushanka/solgov/fleet = 5,
					/obj/item/clothing/under/solgov/utility/fleet = 5,
					/obj/item/clothing/under/solgov/utility/fleet/combat = 5,
					/obj/item/clothing/under/solgov/service/fleet = 5,
					/obj/item/clothing/under/solgov/pt/fleet = 5,
					/obj/item/clothing/suit/storage/hooded/wintercoat/solgov/fleet = 5,
					/obj/item/clothing/shoes/dutyboots = 5,
					/obj/item/clothing/shoes/dress = 5,
					/obj/item/clothing/shoes/black = 5,
					/obj/item/clothing/gloves/thick = 5,
					/obj/item/storage/belt/holster/security = 5,
					/obj/item/storage/backpack/satchel/pocketbook/navy = 5,
					/obj/item/clothing/accessory/storage/black_drop = 5,
					/obj/item/clothing/accessory/solgov/fleet_patch/fifth = 5,
					)
/* Voidsuit Storage Unit
 * ====
 */

/obj/machinery/suit_storage_unit/away_cavalry_med
	name = "Corpsman Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/medical/alt/sol/prepared
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	req_access = list(access_away_cavalry)
	islocked = 1

/obj/machinery/suit_storage_unit/away_cavalry_eng
	name = "Technician Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/engineering/alt/sol/prepared
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	req_access = list(access_away_cavalry)
	islocked = 1

/obj/machinery/suit_storage_unit/away_cavalry_com
	name = "Officer Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/command/prepared
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	req_access = list(access_away_cavalry, access_away_cavalry_commander)
	islocked = 1

/obj/machinery/suit_storage_unit/away_cavalry_fly
	name = "Pilot Voidsuit Storage Unit"
	suit= /obj/item/clothing/suit/space/void/pilot/sol/prepared
	boots = /obj/item/clothing/shoes/magboots
	tank = /obj/item/tank/oxygen
	req_access = list(access_away_cavalry)
	islocked = 1
