/obj/effect/overmap/radio
	name = "radio signal"
	scanner_name = "radio signal"
	icon_state = "radio"
	scannable = TRUE
	color = COLOR_AMBER
	var/message
	var/obj/effect/overmap/source

/obj/effect/overmap/radio/get_scan_data(mob/user)
	return "Радиосигнал, передаваемый [source].<br><br> \
	---НАЧАЛО ПЕРЕДАЧИ---<br><br> \
	[message] \
	<br><br>---КОНЕЦ ПЕРЕДАЧИ---"

/obj/effect/overmap/radio/proc/set_origin(obj/effect/overmap/origin)
	GLOB.moved_event.register(origin, src, /obj/effect/overmap/radio/proc/follow)
	GLOB.destroyed_event.register(origin, src, /datum/proc/qdel_self)
	forceMove(origin.loc)
	source = origin
	pixel_x = -(origin.bound_width - 6)
	pixel_y = origin.bound_height - 6

/obj/effect/overmap/radio/proc/follow(var/atom/movable/am, var/old_loc, var/new_loc)
	forceMove(new_loc)

/obj/effect/overmap/radio/Destroy()
	GLOB.destroyed_event.unregister(source, src)
	GLOB.moved_event.unregister(source, src)
	source = null
	. = ..()

/obj/item/radio_beacon
	name = "radio beacon"
	desc = "Device capable of continuously broadcasting a signal that can be picked up by ship sensors."
	icon = 'icons/obj/radio.dmi'
	icon_state = "walkietalkie"
	var/obj/effect/overmap/radio/signal

/obj/item/radio_beacon/attack_self(mob/user)
	var/obj/effect/overmap/visitable/O = map_sectors["[get_z(src)]"]
	if(!O)
		to_chat(user, SPAN_WARNING("Вы не можете развернуть [src] здесь."))
		return
	var/message = sanitize(input("Что следует передать?") as message|null)

	if(!signal)
		signal = new()

	signal.message = message
	signal.set_origin(O)





/obj/item/device/subspaceradio
	name = "subspace radio"
	desc = "This long range communications device has the ability to send and recieve transmissions from anywhere."
	icon = 'icons/obj/structures/decor.dmi'
	icon_state = "random_radio"
	w_class = ITEM_SIZE_LARGE
	action_button_name = "Remove/Replace Handset"
	var/obj/item/subspacehandset/handset

/obj/item/device/subspaceradio/Initialize()
	. = ..()
	if(ispath(handset))
		handset = new handset(src, src)
	else
		handset = new(src, src)

/obj/item/device/subspaceradio/Destroy()
	. = ..()
	QDEL_NULL(handset)

/obj/item/device/subspaceradio/ui_action_click()
	toggle_handset()

/obj/item/device/subspaceradio/attack_hand(mob/user)
	if(loc == user)
		toggle_handset()
	else
		..()

/obj/item/device/subspaceradio/MouseDrop()
	if(ismob(loc))
		if(!CanMouseDrop(src))
			return
		var/mob/M = loc
		if(!M.unEquip(src))
			return
		src.add_fingerprint(usr)
		M.put_in_any_hand_if_possible(src)

/obj/item/device/subspaceradio/attackby(obj/item/W, mob/user, params)
	if(W == handset)
		reattach_handset(user)
	else
		return ..()

/obj/item/device/subspaceradio/AltClick(mob/user as mob)
	toggle_handset()

/obj/item/device/subspaceradio/verb/toggle_handset()

	var/mob/living/carbon/human/user = usr
	if(!handset)
		to_chat(user, SPAN_WARNING("The handset is missing!"))
		return

	if(handset.loc != src)
		reattach_handset(user) //Remove from their hands and back onto the defib unit
		return

	else
		if(!usr.put_in_hands(handset)) //Detach the handset into the user's hands
			to_chat(user, SPAN_WARNING("You need a free hand to hold the handset!"))
		update_icon() //success

//checks that the base unit is in the correct slot to be used
/obj/item/device/subspaceradio/proc/slot_check()
	var/mob/M = loc
	if(!istype(M))
		return FALSE //not equipped

	if((slot_flags & SLOT_BACK) && M.get_equipped_item(slot_back) == src)
		return TRUE
	if((slot_flags & SLOT_BELT) && M.get_equipped_item(slot_belt) == src)
		return TRUE

	return FALSE

/obj/item/device/subspaceradio/dropped(mob/user)
	..()
	reattach_handset(user) //handset attached to a base unit should never exist outside of their base unit or the mob equipping the base unit

/obj/item/device/subspaceradio/proc/reattach_handset(mob/user)
	if(!handset) return

	if(ismob(handset.loc))
		var/mob/M = handset.loc
		if(M.drop_from_inventory(handset, src))
			to_chat(user, SPAN_NOTICE("\The [handset] snaps back into the main unit."))
	else
		handset.forceMove(src)

//Subspace Radio Handset
/obj/item/subspacehandset
	name = "radio beacon"
	desc = "Device capable of continuously broadcasting a signal that can be picked up by ship sensors."
	icon = 'icons/obj/radio.dmi'
	icon_state = "walkietalkie"
	var/obj/effect/overmap/radio/signal

/obj/item/subspacehandset/attack_self(mob/user)
	var/obj/effect/overmap/visitable/O = map_sectors["[get_z(src)]"]
	if(!O)
		to_chat(user, SPAN_WARNING("Вы не можете развернуть [src] здесь."))
		return
	var/message = sanitize(input("Что следует передать?") as message|null)

	if(!signal)
		signal = new()

	signal.message = message
	signal.set_origin(O)

/obj/item/subspacehandset/linked
	var/obj/item/device/subspaceradio/base_unit

/obj/item/subspacehandset/linked/New(newloc, obj/item/device/subspaceradio/radio)
	base_unit = radio
	..(newloc)

/obj/item/subspacehandset/linked/Destroy()
	if(base_unit)
		//ensure the base unit's icon updates
		if(base_unit.handset == src)
			base_unit.handset = null
		base_unit = null
	return ..()

/obj/item/subspacehandset/linked/dropped(mob/user)
	..() //update twohanding
	if(base_unit)
		base_unit.reattach_handset(user) //handset attached to a base unit should never exist outside of their base unit or the mob equipping the base unit
