

/obj/item/organ/internal/augment/active/polytool/engineer
	name = "\improper Engineering toolset"
	action_button_name = "Deploy Engineering Tool"
	desc = "A lightweight augmentation for the engineer on-the-go. This one comes with a series of common tools."
	paths = list(
		/obj/item/screwdriver/finger,
		/obj/item/wrench/finger,
		/obj/item/weldingtool/finger,
		/obj/item/crowbar/finger,
		/obj/item/wirecutters/finger,
		/obj/item/device/multitool/finger
	)

/obj/item/weldingtool/finger
	name = "digital welder"
	desc = "A precise, high quality welding tool."
	icon_state = "welder_finger"
	icon = 'icons/obj/augment_tools.dmi'


/obj/item/weldingtool/finger/on_update_icon()
	icon_state = welding ? "welder_finger_on" : "welder_finger"

/obj/item/wirecutters/finger
	name = "digital splicer"
	desc = "A small embedded cutter in your finger."
	icon_state = "wirecutter_finger"
	icon = 'icons/obj/augment_tools.dmi'
	build_from_parts = FALSE

/obj/item/wirecutters/finger/Initialize()
	. = ..()
	icon_state = initial(icon_state)
	item_state = initial(item_state)

/obj/item/screwdriver/finger
	name = "digital screwdriver"
	desc = "A nifty powertool at your literal fingertips."
	icon_state = "screwdriver_finger"
	icon = 'icons/obj/augment_tools.dmi'
	build_from_parts = FALSE

/obj/item/screwdriver/finger/Initialize()
	. = ..()
	icon_state = initial(icon_state)
	item_state = initial(item_state)

/obj/item/crowbar/finger
	name = "digital prybar"
	desc = "A somewhat awkward to use prybar. It doubles as bottle opener."
	icon_state = "prybar_finger"
	icon = 'icons/obj/augment_tools.dmi'

/obj/item/crowbar/finger/Initialize()
	. = ..()
	icon_state = initial(icon_state)
	item_state = initial(item_state)

/obj/item/wrench/finger
	name = "digital wrench"
	desc = "A rotating wrench. Don't get your hair caught in it."
	icon_state = "wrench_finger"
	icon = 'icons/obj/augment_tools.dmi'

/obj/item/wrench/finger/Initialize()
	. = ..()
	icon_state = initial(icon_state)
	item_state = initial(item_state)

/obj/item/device/multitool/finger
	name = "digital multitool"
	desc = "A multitool inside of a multitool. Doubletool?"
	icon_state = "multitool_finger"
	item_state = "multitool"
	icon = 'icons/obj/augment_tools.dmi'
