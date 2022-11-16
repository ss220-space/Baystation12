/obj/item/reagent_containers/misc
	unacidable = FALSE
	var/has_lid = FALSE

/obj/item/reagent_containers/misc/examine(mob/user, distance)
	. = ..()
	if(distance > 2)
		return

	display_reagent_volume(user)

/obj/item/reagent_containers/misc/proc/display_reagent_volume(mob/user)
	if(!reagents || reagents.total_volume == 0)
		to_chat(user, SPAN_NOTICE("\The [src] is empty!"))
	else if (reagents.total_volume <= volume * 0.25)
		to_chat(user, SPAN_NOTICE("\The [src] is almost empty!"))
	else if (reagents.total_volume <= volume * 0.66)
		to_chat(user, SPAN_NOTICE("\The [src] is half full!"))
	else if (reagents.total_volume <= volume * 0.90)
		to_chat(user, SPAN_NOTICE("\The [src] is almost full!"))
	else
		to_chat(user, SPAN_NOTICE("\The [src] is full!"))

/obj/item/reagent_containers/misc/attack_self()
	..()
	if(is_open_container() && has_lid)
		to_chat(usr, "<span class = 'notice'>You put the lid on \the [src].</span>")
		atom_flags ^= ATOM_FLAG_OPEN_CONTAINER
	else
		to_chat(usr, "<span class = 'notice'>You take the lid off \the [src].</span>")
		atom_flags |= ATOM_FLAG_OPEN_CONTAINER
	update_icon()

/obj/item/reagent_containers/misc/attack(mob/M as mob, mob/user as mob, def_zone)
	if(force && !(item_flags & ITEM_FLAG_NO_BLUDGEON) && user.a_intent == I_HURT)
		return	..()
	if(standard_feed_mob(user, M))
		return
	return 0

/obj/item/reagent_containers/misc/standard_feed_mob(var/mob/user, var/mob/target)
	if(!is_open_container())
		to_chat(user, "<span class='notice'>You need to open \the [src] first.</span>")
		return 1
	if(user.a_intent == I_HURT)
		return 1
	return ..()

/obj/item/reagent_containers/misc/self_feed_message(var/mob/user)
	to_chat(user, "<span class='notice'>You swallow a gulp from \the [src].</span>")
	if(user.has_personal_goal(/datum/goal/achievement/specific_object/drink))
		for(var/datum/reagent/R in reagents.reagent_list)
			user.update_personal_goal(/datum/goal/achievement/specific_object/drink, R.type)

/obj/item/reagent_containers/misc/throw_impact(atom/hit_atom)
	if (QDELETED(src))
		return
	if (reagents.reagent_list.len > 0)
		visible_message(
			SPAN_DANGER("\The [src] spills all its contents!"),
			SPAN_WARNING("You hear the sound of something hitting something.")
		)
		reagents.splash(hit_atom, reagents.total_volume)
		playsound(src.loc, "sound/effects/metalhit.ogg", 50)

/obj/item/reagent_containers/misc/afterattack(obj/target, mob/user, proximity)
	if (!proximity || standard_dispenser_refill(user, target) || standard_pour_into(user, target))
		return TRUE
	splashtarget(target, user)

/obj/item/reagent_containers/misc/bucket
	name = "bucket"
	desc = "It's a bucket."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "bucket"
	item_state = "bucket"
	center_of_mass = "x=16;y=9"
	matter = list(MATERIAL_PLASTIC = 280)
	w_class = ITEM_SIZE_NORMAL
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = "10;20;30;60;120;150;180"
	volume = 180
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	has_lid = TRUE

/obj/item/reagent_containers/misc/bucket/wood
	name = "bucket"
	desc = "It's a wooden bucket. How rustic."
	icon_state = "wbucket"
	item_state = "wbucket"
	matter = list(MATERIAL_WOOD = 280)
	volume = 200

/obj/item/reagent_containers/misc/bucket/attackby(var/obj/D, mob/user as mob)
	if(istype(D, /obj/item/mop))
		if(reagents.total_volume < 1)
			to_chat(user, "<span class='warning'>\The [src] is empty!</span>")
		else
			reagents.trans_to_obj(D, 5)
			to_chat(user, "<span class='notice'>You wet \the [D] in \the [src].</span>")
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		return
	else
		return ..()

/obj/item/reagent_containers/misc/bucket/on_update_icon()
	overlays.Cut()
	if (!is_open_container())
		var/image/lid = image(icon, src, "lid_[initial(icon_state)]")
		overlays += lid
	else if(reagents.total_volume && round((reagents.total_volume / volume) * 100) > 80)
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "bucket")
		filling.color = reagents.get_color()
		overlays += filling
