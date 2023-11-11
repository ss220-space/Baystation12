/obj/item/clothing/suit/storage
	var/obj/item/storage/internal/pockets/pockets
	var/slots = 2

/obj/item/clothing/suit/storage/Initialize()
	. = ..()
	pockets = new/obj/item/storage/internal/pockets(src, slots, ITEM_SIZE_SMALL) //fit only pocket sized items

/obj/item/clothing/suit/storage/Destroy()
	QDEL_NULL(pockets)
	. = ..()

/obj/item/clothing/suit/storage/attack_hand(mob/user as mob)
	if (pockets.handle_attack_hand(user))
		..(user)

/obj/item/clothing/suit/storage/MouseDrop(obj/over_object as obj)
	if (pockets.handle_mousedrop(usr, over_object))
		..(over_object)

/obj/item/clothing/suit/storage/attackby(obj/item/W as obj, mob/user as mob)
	..()
	if(!(W in accessories))		//Make sure that an accessory wasn't successfully attached to suit.
		pockets.attackby(W, user)

/obj/item/clothing/suit/storage/emp_act(severity)
	pockets.emp_act(severity)
	..()

//Jackets with buttons, used for labcoats, IA jackets, First Responder jackets, and brown jackets.
/obj/item/clothing/suit/storage/toggle
	var/icon_open
	var/icon_closed

/obj/item/clothing/suit/storage/toggle/verb/toggle()
	set name = "Toggle Coat Buttons"
	set category = "Object"
	set src in usr
	if(!CanPhysicallyInteract(usr))
		return 0

	if(icon_state == icon_open) //Will check whether icon state is currently set to the "open" or "closed" state and switch it around with a message to the user
		icon_state = icon_closed
		to_chat(usr, "You button up the coat.")
	else if(icon_state == icon_closed)
		icon_state = icon_open
		to_chat(usr, "You unbutton the coat.")
	else //in case some goofy admin switches icon states around without switching the icon_open or icon_closed
		to_chat(usr, "You attempt to button-up the velcro on your [src], before promptly realising how silly you are.")
		return
	update_clothing_icon()	//so our overlays update

/obj/item/clothing/suit/storage/toggle/inherit_custom_item_data(var/datum/custom_item/citem)
	. = ..()
	if(citem.additional_data["icon_open"])
		icon_open = citem.additional_data["icon_open"]
	if(citem.additional_data["icon_closed"])
		icon_closed = citem.additional_data["icon_closed"]

/obj/item/clothing/suit/storage/vest/merc
	slots = 4

/obj/item/clothing/suit/storage/vest/tactical
	slots = 4

/obj/item/clothing/suit/storage/shortcoat
	name = "shortcoat"
	desc = "A felt french coat. Incredibly warm and is heavy as well. EBLAN"
	icon = CUSTOM_ITEM_OBJ
	item_icons = list(
		slot_wear_suit_str = CUSTOM_ITEM_MOB
	)
	icon_state = "shortcoat"
	item_state = "shortcoat"
	item_state_slots = list(
		slot_wear_suit_str = "shortcoat",
	)

/obj/item/clothing/suit/storage/toggle/bomber/navy
	name = "bomber jacket"
	desc = "Very warm jacket made of tanned leather with fleece inner."
	icon = CUSTOM_ITEM_OBJ
	icon_open = "bomber_navy_open"
	icon_closed = "bomber_navy"
	item_state = "bomber_navy"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)
	body_parts_covered = UPPER_TORSO|ARMS
	cold_protection = UPPER_TORSO|ARMS
	min_cold_protection_temperature = T0C - 20
	siemens_coefficient = 0.7

/obj/item/clothing/suit/storage/greatcoat
	name = "sleek greatcoat"
	desc = "This coat almost covers your feet"
	icon = CUSTOM_ITEM_OBJ
	icon_state = "greatcoat"
	item_state = "greatcoat"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	valid_accessory_slots = list(
		ACCESSORY_SLOT_ARMBAND,
		ACCESSORY_SLOT_INSIGNIA
	)

/obj/item/clothing/suit/storage/denim
	name = "denim jacket"
	desc = "Behold - the pinnacle of colonial fashion."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "denim_jacket"
	item_state = "denim_jacket"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/storage/denim/gray
	icon = CUSTOM_ITEM_OBJ
	icon_state = "denim_jacket_gray"
	item_state = "denim_jacket_gray"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/crop_sweater
	icon = CUSTOM_ITEM_OBJ
	name = "crop sweater"
	desc = "Well, this seems impractical. Are you actually cold or not?"

/obj/item/clothing/suit/crop_sweater/one
	icon = CUSTOM_ITEM_OBJ
	icon_state = "crop_sweater_1"
	item_state = "crop_sweater_1"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/crop_sweater/two
	icon = CUSTOM_ITEM_OBJ
	icon_state = "crop_sweater_2"
	item_state = "crop_sweater_2"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/crop_sweater/three
	icon = CUSTOM_ITEM_OBJ
	icon_state = "crop_sweater_3"
	item_state = "crop_sweater_3"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/under/cherry
	name = "cherry suit"
	desc = "Some cherry-colored slacks with a burgundy shirt."
	icon = CUSTOM_ITEM_OBJ
	item_icons = list(slot_w_uniform_str = CUSTOM_ITEM_MOB)
	icon_state = "cherry_suit_s"
	item_state = "cherry_suit_s"
	worn_state = "cherry_suit_s"

/obj/item/clothing/under/cherry_female
	name = "female cherry suit"
	desc = "Some cherry-colored slacks with a burgundy shirt."
	icon = CUSTOM_ITEM_OBJ
	item_icons = list(slot_w_uniform_str = CUSTOM_ITEM_MOB)
	icon_state = "cherry_suit_f_s"
	item_state = "cherry_suit_f_s"
	worn_state = "cherry_suit_f_s"

/obj/item/clothing/suit/crystaljock //+
	name = "crystaljock bobmer"
	desc = "This neckband is really... something."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "crystaljock_1"
	item_state = "crystaljock_1"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/storage/hooded/anorak/khaki //Не могу разобраться с анораком. При спавне хаки версии onmob отображается пустынная.
	name = "khaki anorak"
	desc = "A sturdy anorak made of tarp-like fabric."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "anorak_1"
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	item_flags = ITEM_FLAG_THICKMATERIAL
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)
	action_button_name = "Toggle Hood"
	hoodtype = /obj/item/clothing/head/anorak_khaki_hood

/obj/item/clothing/head/anorak_khaki_hood
	name = "anorak hood"
	desc = "A sturdy hood that protects your head from the elements."
	icon_state = "anorak_1_hood"
	icon = CUSTOM_ITEM_OBJ
	item_icons = list(slot_head_str = CUSTOM_ITEM_MOB)
	body_parts_covered = HEAD
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	cold_protection = HEAD
	flags_inv = HIDEEARS | BLOCKHAIR
	trade_blacklisted = TRUE

/obj/item/clothing/suit/storage/hooded/anorak/khaki/on_update_icon()
	if(suittoggled)
		item_state_slots = list(slot_wear_suit_str = "anorak_1_h")
	else
		item_state_slots = list(slot_wear_suit_str = "anorak_1")

/obj/item/clothing/suit/storage/hooded/anorak/desert
	name = "desert anorak"
	desc = "A sturdy anorak made of tarp-like fabric."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "anorak_2"
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	item_flags = ITEM_FLAG_THICKMATERIAL
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)
	action_button_name = "Toggle Hood"
	hoodtype = /obj/item/clothing/head/anorak_khaki_hood

/obj/item/clothing/suit/storage/hooded/anorak/desert/on_update_icon()
	if(suittoggled)
		item_state_slots = list(slot_wear_suit_str = "anorak_2_h")
	else
		item_state_slots = list(slot_wear_suit_str = "anorak_2")

/obj/item/clothing/suit/storage/rugby
	desc = "The pinnacle of the sportswear amongst school bullies."
/obj/item/clothing/suit/storage/rugby/red
	name = "red rugby"
	icon = CUSTOM_ITEM_OBJ
	icon_state = "rugby_red"
	item_state = "rugby_red"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/storage/rugby/black
	name = "black rugby"
	icon = CUSTOM_ITEM_OBJ
	icon_state = "rugby_black"
	item_state = "rugby_black"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/storage/rugby/blue
	name = "blue rugby"
	icon = CUSTOM_ITEM_OBJ
	icon_state = "rugby_blue"
	item_state = "rugby_blue"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/storage/rugby/brown
	name = "brown rugby"
	icon = CUSTOM_ITEM_OBJ
	icon_state = "rugby_brown"
	item_state = "rugby_brown"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/storage/engi_jacket
	name = "hazard jacket"
	desc = "A bright yellow jacket with engineering insignia and high-vis reflective stripes."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "engjacket"
	item_state = "engjacket"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/storage/cargo_jacket //
	name = "lanor jacket"
	desc = "A brown sturdy jacket with cargo insignia on its back.."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "cargojacket"
	item_state = "cargojacket"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/amizov //
	name = "striped pullover"
	desc = "This pullover oddly reminisces you of some old video game."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "amizov"
	item_state = "amizov"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)



/obj/item/clothing/suit/storage/grimbomber
	name = "black bomber"
	desc = "A sleek black bomber with high-vis patches on its arms and pockets."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "grimjacket"
	item_state = "grimjacket"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/color/storage/neo_blaser
	name = "neokitsch blaser"
	desc = "Style and substance. Show everyone all these money ain't for nothing."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "neokitsch_blaser"
	item_state = "neokitsch_blaser"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)

/obj/item/clothing/suit/color/storage/neo_blaser_female
	name = "female neokitsch blaser"
	desc = "Style and substance. Show everyone all these money ain't for nothing."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "neokitsch_blaser"
	item_state = "neokitsch_blaser_f"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)


/obj/item/clothing/suit/color/storage/neo_jacket
	name = "neokitsch jacket"
	desc = "Style and substance. Show everyone all these money ain't for nothing."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "neokitsch_jacket"
	item_state = "neokitsch_jacket"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)


/obj/item/clothing/suit/color/storage/neo_jacket_female
	name = "female neokitsch jacket"
	desc = "Style and substance. Show everyone all these money ain't for nothing."
	icon = CUSTOM_ITEM_OBJ
	icon_state = "neokitsch_jacket"
	item_state = "neokitsch_jacket_f"
	item_icons = list(slot_wear_suit_str = CUSTOM_ITEM_MOB)
