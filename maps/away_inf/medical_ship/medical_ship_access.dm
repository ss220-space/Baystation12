/var/const/access_medical_ship
/datum/access/medical_ship
	id = medical_ship
	desc = Medical Ship
	region = ACCESS_REGION_NONE


/obj/item/card/id/medical_ship
	access = list(access_medical_ship)

/obj/machinery/power/apc/medical_ship
	req_access = list(access_medical_ship)

/obj/machinery/door/airlock/autoname/medical_ship

/obj/machinery/door/airlock/autoname/engineering/medical_ship

/obj/machinery/door/airlock/autoname/command/medical_ship


//todo:
/obj/structure/closet/secure_closet/engineering_electrical/bearcat
	req_access = list(access_bearcat)

/obj/structure/closet/secure_closet/engineering_welding/bearcat
	req_access = list(access_bearcat)

/obj/structure/closet/secure_closet/freezer/fridge/bearcat
	req_access = list(access_bearcat)

/obj/structure/closet/secure_closet/freezer/meat/bearcat
	req_access = list(access_bearcat)

/obj/machinery/vending/engineering/bearcat
	req_access = list(access_bearcat)

/obj/machinery/vending/tool/bearcat
	req_access = list(access_bearcat)

/obj/machinery/suit_storage_unit/engineering/salvage/bearcat
	req_access = list(access_bearcat)
