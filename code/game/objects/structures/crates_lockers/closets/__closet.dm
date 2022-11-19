/obj/structure/closet
	name = "closet"
	desc = "It's a basic storage unit."
	icon = 'icons/obj/closets/closet.dmi'
	icon_state = "generic"
	density = TRUE
	w_class = ITEM_SIZE_NO_CONTAINER

	var/icon_door = null
	var/icon_door_override = FALSE //override to have open overlay use icon different to its base's
	var/icon_door_overlay = "" //handles secure locker overlays like the locking lights

	var/welded = 0
	var/large = 1
	var/wall_mounted = FALSE //equivalent to non-dense for air movement
	var/health = 100
	var/breakout = 0 //if someone is currently breaking out. mutex
	var/storage_capacity = 2 * MOB_MEDIUM //This is so that someone can't pack hundreds of items in a locker/crate
							  //then open it in a populated area to crash clients.
	var/open_sound = 'sound/effects/closet_open.ogg'
	var/close_sound = 'sound/effects/closet_close.ogg'

	var/storage_types = CLOSET_STORAGE_ALL
	var/setup = CLOSET_CAN_BE_WELDED
	var/closet_appearance = /decl/closet_appearance

	// TODO: Turn these into flags. Skipped it for now because it requires updating 100+ locations...
	var/broken = FALSE
	var/opened = FALSE
	var/locked = FALSE

	var/code1[8]
	var/code2[8]
	var/validate = 0
	var/codelen
	var/obj/effect/overlay/closet_door/door_obj
	var/obj/effect/overlay/closet_door/door_obj_alt
	var/secure = FALSE //secure locker or not. typically it shouldn't need lights if it's insecure
	var/secure_lights = FALSE // whether to display secure lights when open.
	var/is_animating_door = FALSE
	var/door_underlay = FALSE //used if you want to have an overlay below the door. used for guncabinets.
	var/door_anim_squish = 0.12 // Multiplier on proc/get_door_transform. basically, how far you want this to swing out. value of 1 means the length of the door is unchanged (and will swing out of the tile), 0 means it will just slide back and forth.
	var/door_anim_angle = 147
	var/door_hinge = -6.5 // for closets, x away from the centre of the closet. typically good to add a 0.5 so it's centered on the edge of the closet.
	var/door_hinge_alt = 6.5 // for closets with two doors. why a seperate var? because some closets may be weirdly shaped or something.
	var/door_anim_time = 2.5 // set to 0 to m
	var/list/starts_with // for pre-filled items
	var/double_doors = FALSE
	var/dense_when_open = FALSE
	var/store_structures = FALSE

/obj/structure/closet/Initialize(mapload, var/need_fill)
	..()
	update_icon()
	if((setup & CLOSET_HAS_LOCK))
		verbs += /obj/structure/closet/proc/togglelock_verb

		codelen = rand(7,10)
		code1.len = codelen
		code2.len = codelen
		for(var/i=1 to codelen)
			code1[i] = rand(0,9)
			code2[i] = rand(0,9)

	return mapload ? INITIALIZE_HINT_LATELOAD : INITIALIZE_HINT_NORMAL


// Override this to fill the storage object with stuff.
/* /obj/structure/closet/proc/fill()
	if(LAZYLEN(starts_with))
		for(var/t in starts_with)
			if(!ispath(t))
				crash_with("[t] in [src]'s starts_with list is not a path!")
				continue
			for(var/i=0, i<starts_with[t], i++)
				new t(src)
	return

*/

/*	if(ispath(closet_appearance))
		var/decl/closet_appearance/app = decls_repository.get_decl(closet_appearance)
		if(app)
			icon = app.icon
			color = null


	return INITIALIZE_HINT_LATELOAD
 */

/obj/structure/closet/LateInitialize(mapload, ...)
	var/list/will_contain = WillContain()
	if(will_contain)
		create_objects_in_loc(src, will_contain)

	if(!opened && mapload) // if closed and it's the map loading phase, relevant items at the crate's loc are put in the contents
		store_contents()

/obj/structure/closet/proc/WillContain()
	return null

/obj/structure/closet/examine(mob/user, distance)
	. = ..()
	if(distance <= 1 && !opened)
		var/content_size = 0
		for(var/atom/movable/AM in src.contents)
			if(!AM.anchored)
				content_size += content_size(AM)
		if(!content_size)
			to_chat(user, "It is empty.")
		else if(storage_capacity > content_size*4)
			to_chat(user, "It is barely filled.")
		else if(storage_capacity > content_size*2)
			to_chat(user, "It is less than half full.")
		else if(storage_capacity > content_size)
			to_chat(user, "There is still some free space.")
		else
			to_chat(user, "It is full.")

/obj/structure/closet/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0 || wall_mounted)) return 1
	return (!density)

/obj/structure/closet/proc/can_open()
	if((setup & CLOSET_HAS_LOCK) && locked)
		return 0
	if((setup & CLOSET_CAN_BE_WELDED) && welded)
		return 0
	return 1

/obj/structure/closet/proc/can_close()
	for(var/obj/structure/closet/closet in get_turf(src))
		if(closet != src)
			return 0
	return 1

/obj/structure/closet/proc/dump_contents()
	for(var/mob/M in src)
		M.dropInto(loc)
		if(M.client)
			M.client.eye = M.client.mob
			M.client.perspective = MOB_PERSPECTIVE

	for(var/atom/movable/AM in src)
		AM.dropInto(loc)

/obj/structure/closet/proc/store_contents()
	var/stored_units = 0

	if(storage_types & CLOSET_STORAGE_ITEMS)
		stored_units += store_items(stored_units)
	if(storage_types & CLOSET_STORAGE_MOBS)
		stored_units += store_mobs(stored_units)
	if(storage_types & CLOSET_STORAGE_STRUCTURES)
		stored_units += store_structures(stored_units)

/obj/structure/closet/proc/open()
	if(src.opened)
		return 0

	if(!src.can_open())
		return 0

	src.dump_contents()
	animate_door(FALSE)
	if(double_doors)
		animate_door_alt(FALSE)
	update_icon()
	src.opened = TRUE
	playsound(src.loc, open_sound, 50, 1, -3)
	if(!dense_when_open)
		set_density(FALSE)
	update_icon()
	return 1

/obj/structure/closet/proc/close()
	if(!src.opened)
		return 0
	if(!src.can_close())
		return 0

	store_contents()
	src.opened = 0

	playsound(src.loc, close_sound, 50, 0, -3)
	if(!wall_mounted)
		set_density(TRUE)
	animate_door(TRUE)
	if(double_doors)
		animate_door_alt(TRUE)
	update_icon()

	return 1

#define CLOSET_CHECK_TOO_BIG(x) (stored_units + . + x > storage_capacity)
/obj/structure/closet/proc/store_items(var/stored_units)
	. = 0

	for(var/obj/effect/dummy/chameleon/AD in loc)
		if(CLOSET_CHECK_TOO_BIG(1))
			break
		.++
		AD.forceMove(src)

	for(var/obj/item/I in loc)
		if(I.anchored)
			continue
		var/item_size = content_size(I)
		if(CLOSET_CHECK_TOO_BIG(item_size))
			break
		. += item_size
		I.forceMove(src)
		I.pixel_x = 0
		I.pixel_y = 0
		I.pixel_z = 0

/obj/structure/closet/proc/store_mobs(var/stored_units)
	. = 0
	for(var/mob/living/M in loc)
		if(M.buckled || M.pinned.len || M.anchored)
			continue
		var/mob_size = content_size(M)
		if(CLOSET_CHECK_TOO_BIG(mob_size))
			break
		. += mob_size
		if(M.client)
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = src
		M.forceMove(src)

/obj/structure/closet/proc/store_structures(var/stored_units)
	. = 0

	for(var/obj/structure/S in loc)
		if(S == src)
			continue
		if(S.anchored)
			continue
		var/structure_size = content_size(S)
		if(CLOSET_CHECK_TOO_BIG(structure_size))
			break
		. += structure_size
		S.forceMove(src)

	for(var/obj/machinery/M in loc)
		if(M.anchored)
			continue
		var/structure_size = content_size(M)
		if(CLOSET_CHECK_TOO_BIG(structure_size))
			break
		. += structure_size
		M.forceMove(src)

#undef CLOSET_CHECK_TOO_BIG

// If you adjust any of the values below, please also update /proc/unit_test_weight_of_path(var/path)
/obj/structure/closet/proc/content_size(atom/movable/AM)
	if(ismob(AM))
		var/mob/M = AM
		return M.mob_size
	if(istype(AM, /obj/item))
		var/obj/item/I = AM
		return (I.w_class / 2)
	if(istype(AM, /obj/structure) || istype(AM, /obj/machinery))
		return MOB_LARGE
	return 0

/obj/structure/closet/proc/toggle(mob/user as mob)
	if(locked)
		togglelock(user)
	else if(!(src.opened ? src.close() : src.open()))
		to_chat(user, "<span class='notice'>It won't budge!</span>")
		update_icon()

// this should probably use dump_contents()
/obj/structure/closet/ex_act(severity)
	switch(severity)
		if(1)
			for(var/atom/movable/A in src)//pulls everything out of the locker and hits it with an explosion
				A.forceMove(src.loc)
				A.ex_act(severity + 1)
			qdel(src)
		if(2)
			if(prob(50))
				for (var/atom/movable/A in src)
					A.forceMove(src.loc)
					A.ex_act(severity + 1)
				qdel(src)
		if(3)
			if(prob(5))
				for(var/atom/movable/A in src)
					A.forceMove(src.loc)
				qdel(src)

/obj/structure/closet/proc/damage(var/damage)
	health -= damage
	if(health <= 0)
		for(var/atom/movable/A in src)
			A.forceMove(src.loc)
		qdel(src)

/obj/structure/closet/bullet_act(var/obj/item/projectile/Proj)
	var/proj_damage = Proj.get_structure_damage()
	if(proj_damage)
		..()
		damage(proj_damage)

	if(Proj.penetrating)
		var/distance = get_dist(Proj.starting, get_turf(loc))
		for(var/mob/living/L in contents)
			Proj.attack_mob(L, distance)
			if(!(--Proj.penetrating))
				break

	return

/obj/structure/closet/attackby(obj/item/W as obj, mob/user as mob)
	if(src.opened)
		if(istype(W, /obj/item/grab))
			var/obj/item/grab/G = W
			src.MouseDrop_T(G.affecting, user)      //act like they were dragged onto the closet
			return 0
		if(isWelder(W))
			var/obj/item/weldingtool/WT = W
			if(WT.remove_fuel(0,user))
				slice_into_parts(WT, user)
				return
		if(istype(W, /obj/item/gun/energy/plasmacutter))
			var/obj/item/gun/energy/plasmacutter/cutter = W
			if(!cutter.slice(user))
				return
			slice_into_parts(W, user)
			return
		if(istype(W, /obj/item/storage/laundry_basket) && W.contents.len)
			var/obj/item/storage/laundry_basket/LB = W
			var/turf/T = get_turf(src)
			for(var/obj/item/I in LB.contents)
				LB.remove_from_storage(I, T, 1)
			LB.finish_bulk_removal()
			user.visible_message("<span class='notice'>[user] empties \the [LB] into \the [src].</span>", \
								 "<span class='notice'>You empty \the [LB] into \the [src].</span>", \
								 "<span class='notice'>You hear rustling of clothes.</span>")
			return

		if(user.unEquip(W, loc))
			W.pixel_x = 0
			W.pixel_y = 0
			W.pixel_z = 0
			W.pixel_w = 0
		return
	else if(istype(W, /obj/item/melee/energy/blade))
		if(emag_act(INFINITY, user, "<span class='danger'>The locker has been sliced open by [user] with \an [W]</span>!", "<span class='danger'>You hear metal being sliced and sparks flying.</span>"))
			var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
			spark_system.set_up(5, 0, src.loc)
			spark_system.start()
			playsound(src.loc, 'sound/weapons/blade1.ogg', 50, 1)
			playsound(src.loc, "sparks", 50, 1)
			open()
	else if(istype(W, /obj/item/stack/package_wrap))
		return
	else if(isWelder(W) && (setup & CLOSET_CAN_BE_WELDED))
		var/obj/item/weldingtool/WT = W
		if(!WT.remove_fuel(0,user))
			if(!WT.isOn())
				return
			else
				to_chat(user, "<span class='notice'>You need more welding fuel to complete this task.</span>")
				return
		src.welded = !src.welded
		src.update_icon()
		user.visible_message("<span class='warning'>\The [src] has been [welded?"welded shut":"unwelded"] by \the [user].</span>", blind_message = "You hear welding.", range = 3)
	else if(setup & CLOSET_HAS_LOCK)
		if(isMultimeter(W))
			var/obj/item/device/multitool/multimeter/O = W
			if(O.mode != METER_CHECKING)
				to_chat(user, "<span class='notice'>Переключите мультиметр.</span>")
			else
				if (user.skill_check(SKILL_ELECTRICAL, SKILL_ADEPT))
					src.interact(usr)
				else
					to_chat(user, "<span class='notice'>Вы не умеете работать с этим замком.</span>")
		else
			src.togglelock(user, W)
	else
		src.attack_hand(user)

/obj/structure/closet/proc/slice_into_parts(obj/W, mob/user)
	new /obj/item/stack/material/steel(src.loc, 2)
	user.visible_message("<span class='notice'>\The [src] has been cut apart by [user] with \the [W].</span>", \
						 "<span class='notice'>You have cut \the [src] apart with \the [W].</span>", \
						 "You hear welding.")
	qdel(src)

/obj/structure/closet/MouseDrop_T(atom/movable/O as mob|obj, mob/user as mob)
	if (!O)
		return
	if(istype(O, /obj/screen))	//fix for HUD elements making their way into the world	-Pete
		return
	if(O.loc == user)
		return
	if(ismob(O) && src.large)
		return
	if(user.restrained() || user.stat || user.weakened || user.stunned || user.paralysis)
		return
	if((!( istype(O, /atom/movable) ) || O.anchored || !Adjacent(user) || !Adjacent(O) || !user.Adjacent(O) || list_find(user.contents, src)))
		return
	if(!isturf(user.loc)) // are you in a container/closet/pod/etc?
		return
	if(!src.opened)
		return
	if(istype(O, /obj/structure/closet))
		return
	step_towards(O, src.loc)
	if(user != O)
		user.show_viewers("<span class='danger'>[user] stuffs [O] into [src]!</span>")
	src.add_fingerprint(user)
	return

/obj/structure/closet/attack_ai(mob/user)
	if(istype(user, /mob/living/silicon/robot) && Adjacent(user)) // Robots can open/close it, but not the AI.
		attack_hand(user)

/obj/structure/closet/relaymove(mob/user as mob)
	if(user.stat || !isturf(src.loc))
		return

	if(!src.open())
		to_chat(user, "<span class='notice'>It won't budge!</span>")

/obj/structure/closet/attack_hand(mob/user as mob)
	src.add_fingerprint(user)
	src.toggle(user)

/obj/structure/closet/attack_ghost(mob/ghost)
	if(ghost.client && ghost.client.inquisitive_ghost)
		ghost.examinate(src)
		if (!src.opened)
			to_chat(ghost, "It contains: [english_list(contents)].")

/obj/structure/closet/verb/verb_toggleopen()
	set src in oview(1)
	set category = "Object"
	set name = "Toggle Open"

	if(!CanPhysicallyInteract(usr))
		return

	if(ishuman(usr))
		src.add_fingerprint(usr)
		src.toggle(usr)
	else
		to_chat(usr, "<span class='warning'>This mob type can't use this verb.</span>")


/obj/structure/closet/update_icon()
	if(!door_underlay)
		overlays.Cut()

	if(!opened)
		layer = OBJ_LAYER
		if(welded)
			add_overlay("[icon_door_overlay]welded")

		if(!is_animating_door)
			if(icon_door)
				add_overlay("[icon_door]_door")
				if(double_doors)
					add_overlay("[icon_door]_door_alt")
			if(!icon_door)
				add_overlay("[icon_state]_door")
				if(double_doors)
					add_overlay("[icon_state]_door_alt")
			if(secure)
				update_secure_overlays()

		if(secure && secure_lights)
			update_secure_overlays()
	else if(opened)
		layer = BELOW_OBJ_LAYER
		if(!is_animating_door)
			add_overlay("[icon_door_override ? icon_door : icon_state]_open")
		if(secure && secure_lights)
			update_secure_overlays()

/obj/structure/closet/take_damage(damage)
	health -= damage
	if(health <= 0)
		dump_contents()
		qdel(src)

/obj/structure/closet/proc/req_breakout()
	if(opened)
		return 0 //Door's open... wait, why are you in it's contents then?
	if((setup & CLOSET_HAS_LOCK) && locked)
		return 1 // Closed and locked
	return (!welded) //closed but not welded...

/obj/structure/closet/mob_breakout(var/mob/living/escapee)

	. = ..()
	var/breakout_time = 2 //2 minutes by default
	if(breakout || !req_breakout())
		return FALSE

	. = TRUE
	escapee.setClickCooldown(100)

	//okay, so the closet is either welded or locked... resist!!!
	to_chat(escapee, "<span class='warning'>You lean on the back of \the [src] and start pushing the door open. (this will take about [breakout_time] minutes)</span>")

	visible_message("<span class='danger'>\The [src] begins to shake violently!</span>")

	breakout = 1 //can't think of a better way to do this right now.
	for(var/i in 1 to (6*breakout_time * 2)) //minutes * 6 * 5seconds * 2
		if(!do_after(escapee, 50, incapacitation_flags = INCAPACITATION_DEFAULT & ~INCAPACITATION_RESTRAINED)) //5 seconds
			breakout = 0
			return FALSE
		//Perform the same set of checks as above for weld and lock status to determine if there is even still a point in 'resisting'...
		if(!req_breakout())
			breakout = 0
			return FALSE

		playsound(src.loc, 'sound/effects/grillehit.ogg', 100, 1)
		shake_animation()
		add_fingerprint(escapee)

	//Well then break it!
	breakout = 0
	to_chat(escapee, "<span class='warning'>You successfully break out!</span>")
	visible_message("<span class='danger'>\The [escapee] successfully broke out of \the [src]!</span>")
	playsound(src.loc, 'sound/effects/grillehit.ogg', 100, 1)
	break_open()
	shake_animation()

/obj/structure/closet/proc/break_open()
	welded = 0

	if((setup & CLOSET_HAS_LOCK) && locked)
		make_broken()

	//Do this to prevent contents from being opened into nullspace (read: bluespace)
	if(istype(loc, /obj/structure/bigDelivery))
		var/obj/structure/bigDelivery/BD = loc
		BD.unwrap()
	open()

/obj/structure/closet/onDropInto(var/atom/movable/AM)
	return

// If we use the /obj/structure/closet/proc/togglelock variant BYOND asks the user to select an input for id_card, which is then mostly irrelevant.
/obj/structure/closet/proc/togglelock_verb()
	set src in oview(1) // One square distance
	set category = "Object"
	set name = "Toggle Lock"

	return togglelock(usr)

/obj/structure/closet/proc/togglelock(var/mob/user, var/obj/item/card/id/id_card)
	if(!(setup & CLOSET_HAS_LOCK))
		return FALSE
/*inf	if(!CanPhysicallyInteract(user))
		return FALSE*/
	if(src.opened)
		to_chat(user, "<span class='notice'>Close \the [src] first.</span>")
		return FALSE
	if(src.broken)
		to_chat(user, "<span class='warning'>\The [src] appears to be broken.</span>")
		return FALSE
	if(user.loc == src)
		to_chat(user, "<span class='notice'>You can't reach the lock from inside.</span>")
		return FALSE

	add_fingerprint(user)

	if(!id_card)
		id_card = user.GetIdCard()

	if(!user.IsAdvancedToolUser())
		to_chat(user, FEEDBACK_YOU_LACK_DEXTERITY)
		return FALSE

	if(CanToggleLock(user, id_card))
		locked = !locked
		visible_message("<span class='notice'>\The [src] has been [locked ? null : "un"]locked by \the [user].</span>", range = 3)
		update_icon()
		return TRUE
	else
		to_chat(user, "<span class='warning'>Access denied!</span>")
		return FALSE

/obj/structure/closet/proc/CanToggleLock(var/mob/user, var/obj/item/card/id/id_card)
	return allowed(user) || (istype(id_card) && check_access_list(id_card.GetAccess()))

/obj/structure/closet/AltClick(var/mob/user)
	if(!src.opened)
		togglelock(user)
	else
		return ..()

/obj/structure/closet/CtrlAltClick(var/mob/user)
	verb_toggleopen()
	return 1

/obj/structure/closet/emp_act(severity)
	for(var/obj/O in src)
		O.emp_act(severity)
	if(!broken && (setup & CLOSET_HAS_LOCK))
		if(prob(50/severity))
			locked = !locked
			src.update_icon()
		if(prob(20/severity) && !opened)
			if(!locked)
				open()
			else
				src.req_access = list()
				src.req_access += pick(get_all_station_access())
	..()

/obj/structure/closet/emag_act(var/remaining_charges, var/mob/user, var/emag_source, var/visual_feedback = "", var/audible_feedback = "")
	if(!broken)
		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, src.loc)
		spark_system.start()
		desc += " It appears to be broken."
		add_overlay("[icon_door_overlay]sparking")
		//CUT_OVERLAY_IN("[icon_door_overlay]sparking", 6)
		playsound(loc, "spark_sound", 60, 1)
		broken = TRUE
		locked = FALSE
		update_icon()

		if(visual_feedback)
			visible_message(visual_feedback, audible_feedback)
		else if(user && emag_source)
			visible_message(SPAN_WARNING("\The [src] has been broken by \the [user] with \an [emag_source]!"), "You hear a faint electrical spark.")
		else
			visible_message(SPAN_WARNING("\The [src] sparks and breaks open!"), "You hear a faint electrical spark.")
		return 1

/obj/structure/closet/proc/make_broken()
	if(broken)
		return FALSE
	if(!(setup & CLOSET_HAS_LOCK))
		return FALSE
	broken = TRUE
	locked = FALSE
	desc += " It appears to be broken."
	return TRUE


/obj/structure/closet/CanUseTopicPhysical(mob/user)
	return CanUseTopic(user, GLOB.physical_no_access_state)

//[INF]
/obj/structure/closet/interact(mob/user)
	add_fingerprint(user)

	var/dat = "<table style='text-align: center;'><tr>"
	for(var/i = 1 to codelen)
		dat += "<td><a href='?src=\ref[src];inc=[i]'>+</a>"
	dat += "<tr>"
	for(var/i = 1 to codelen)
		dat += "<td>[code2[i]]"
	dat += "<tr>"
	for(var/i = 1 to codelen)
		dat += "<td><a href='?src=\ref[src];dec=[i]'>-</a>"
	dat += "</table><hr><a href='?src=\ref[src];check=1'>Сопоставить код</a>"

	user.set_machine(src)
	var/datum/browser/popup = new(user, "closet", "[name]", 90 + codelen * 30, 200)
	popup.set_content(dat)
	popup.open(1)

/obj/structure/closet/Topic(href, href_list)
	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/user = usr
	var/obj/item/device/multitool/multimeter/W = user.get_active_hand()
	user.set_machine(src)

	if(href_list["check"])
		if(!W.in_use)
			W.in_use = TRUE
		else
			return

		validate = 0

		if(W.mode != METER_CHECKING)
			to_chat(usr, "<span class='notice'>Переключите мультиметр.</span>")
			return

		to_chat(usr, "<span class='notice'>Проверяем замок...</span>")
		for(var/i = 1 to codelen)
			if(do_after(user, 10, src))
				if(code2[i] == code1[i])
					validate++
					to_chat(usr, "<span class='notice'>Ключ подходит.</span>")
					playsound(W.loc, 'infinity/sound/machines/mbeep.ogg', 30, 1, frequency = rand(50000, 55000))
				else
					to_chat(usr, "<span class='notice'>Ключ не подходит.</span>")
		W.in_use = FALSE

		if(validate < codelen)
			return

		locked = !locked
		update_icon()
		visible_message("<span class='warning'>[user] has [locked ? "locked" : "hacked"] [src]!</span>")
		return

	if(href_list["inc"])
		var/inc = text2num(href_list["inc"])
		code2[inc]++
		if(code2[inc] > 9)
			code2[inc] = 0
		interact(user)

	if(href_list["dec"])
		var/inc = text2num(href_list["dec"])
		code2[inc]--
		if(code2[inc] < 0)
			code2[inc] = 9
		interact(user)


/obj/structure/closet/proc/update_secure_overlays()
	if(broken)
		add_overlay("[icon_door_overlay]emag")
	else
		if(locked)
			add_overlay("[icon_door_overlay]locked")
		else
			add_overlay("[icon_door_overlay]unlocked")


/obj/structure/closet/proc/animate_door(var/closing = FALSE)
	if(!door_anim_time)
		return
	if(!door_obj) door_obj = new
	vis_contents |= door_obj
	door_obj.icon = icon
	door_obj.icon_state = "[icon_door || icon_state]_door"
	is_animating_door = TRUE
	var/num_steps = door_anim_time / world.tick_lag
	for(var/step in 0 to num_steps)
		var/angle = door_anim_angle * (closing ? 1 - (step/num_steps) : (step/num_steps))
		var/matrix/M = get_door_transform(angle)
		var/door_state = angle >= 90 ? "[icon_door_override ? icon_door : icon_state]_back" : "[icon_door || icon_state]_door"
		var/door_layer = angle >= 90 ? FLOAT_LAYER : ABOVE_HUMAN_LAYER

		if(step == 0)
			door_obj.transform = M
			door_obj.icon_state = door_state
			door_obj.layer = door_layer
		else if(step == 1)
			animate(door_obj, transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag, flags = ANIMATION_END_NOW)
		else
			animate(transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag)
	addtimer(CALLBACK(src,.proc/end_door_animation),door_anim_time,TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/closet/proc/end_door_animation()
	is_animating_door = FALSE
	vis_contents -= door_obj
	update_icon()

/obj/structure/closet/proc/get_door_transform(angle, var/inverse_hinge = FALSE)
	var/matrix/M = matrix()
	var/matrix_door_hinge = inverse_hinge ? door_hinge_alt : door_hinge
	M.Translate(-matrix_door_hinge, 0)
	M.Multiply(matrix(cos(angle), 0, 0, ((matrix_door_hinge >= 0) ? sin(angle) : -sin(angle)) * door_anim_squish, 1, 0)) // this matrix door hinge >= 0 check is for door hinges on the right, so they swing out instead of upwards
	M.Translate(matrix_door_hinge, 0)
	return M

/obj/structure/closet/proc/animate_door_alt(var/closing = FALSE)
	if(!door_anim_time)
		return
	if(!door_obj_alt) door_obj_alt = new
	vis_contents |= door_obj_alt
	door_obj_alt.icon = icon
	door_obj_alt.icon_state = "[icon_door || icon_state]_door_alt"
	is_animating_door = TRUE
	var/num_steps = door_anim_time / world.tick_lag
	for(var/step in 0 to num_steps)
		var/angle = door_anim_angle * (closing ? 1 - (step/num_steps) : (step/num_steps))
		var/matrix/M = get_door_transform(angle, TRUE)
		var/door_state = angle >= 90 ? "[icon_door_override ? icon_door : icon_state]_back_alt" : "[icon_door || icon_state]_door_alt"
		var/door_layer = angle >= 90 ? FLOAT_LAYER : ABOVE_HUMAN_LAYER

		if(step == 0)
			door_obj_alt.transform = M
			door_obj_alt.icon_state = door_state
			door_obj_alt.layer = door_layer
		else if(step == 1)
			animate(door_obj_alt, transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag, flags = ANIMATION_END_NOW)
		else
			animate(transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag)
	addtimer(CALLBACK(src,.proc/end_door_animation_alt),door_anim_time,TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/closet/proc/end_door_animation_alt()
	is_animating_door = FALSE // comment this out and the line below to manually tweak the animation end state by fiddling with the door_anim vars to match the open door icon
	vis_contents -= door_obj_alt
	update_icon()
	compile_overlays(src)
