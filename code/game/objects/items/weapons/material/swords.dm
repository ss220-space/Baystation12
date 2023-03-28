/obj/item/material/sword
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "claymore"
	item_state = "claymore"
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_LARGE
	force_multiplier = 0.5 // 30 when wielded with hardnes 60 (steel)
	armor_penetration = 10
	thrown_force_multiplier = 0.5 // 10 when thrown with weight 20 (steel)
	sharp = TRUE
	edge = TRUE
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	base_parry_chance = 50
	melee_accuracy_bonus = 10
	worth_multiplier = 30

/obj/item/material/sword/replica
	max_force = 10
	edge = FALSE
	sharp = FALSE
	force_multiplier = 0.2
	thrown_force_multiplier = 0.2
	worth_multiplier = 15

/obj/item/material/sword/katana
	name = "katana"
	desc = "Woefully underpowered in D20. This one looks pretty sharp."
	item_icons = list(
		slot_s_store_str = 'icons/mob/onmob/back.dmi'
		)
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "katana"
	item_state = "katana"
	furniture_icon = "katana_handle"
	unbreakable = 1
	default_material = "plasteel"
	slot_flags = SLOT_BELT | SLOT_BACK

/obj/item/material/sword/katana/replica
	max_force = 10
	edge = FALSE
	sharp = FALSE
	force_multiplier = 0.2
	thrown_force_multiplier = 0.2

/obj/item/material/sword/katana/vibro
	name = "vibrokatana"
	desc = "A high-tech take on a woefully underpowered weapon. Can't mistake its sound for anything."
	default_material = MATERIAL_TITANIUM
	hitsound = 'infinity/sound/weapons/anime_sword.wav'

/obj/item/material/sword/katana/vibro/equipped(mob/user, slot)
	if(slot == slot_l_hand || slot == slot_r_hand)
		playsound(src, 'infinity/sound/weapons/katana_out.wav', 50, 1, -5) // INF, было playsound(src, 'sound/weapons/katana_out.wav', 50, 1, -5)

/obj/item/material/sword/katana/muramasa
	name = "muramasa"
	desc = "A katana of a once legendary swordsman..."
	icon_state = "muramasa"
	item_state = "muramasa"
	furniture_icon = "muramasa_handle"
	var/ability_cooldown = 30 SECONDS
	var/ability_prepare = 1.5 SECOND
	var/next_use = 0
	var/next_attack_use = 0
	var/ability_active = FALSE

/obj/item/material/sword/katana/muramasa/attack_self(mob/user)
	var/datum/antagonist/antag = GLOB.all_antag_types_["ninja"]
	if(!antag.is_antagonist(user.mind))
		return

	if(user.incapacitated(INCAPACITATION_DISABLED) || user.buckled || user.pinned.len)
		to_chat(user, SPAN_WARNING("You cannot use it in your current state."))
		return

	if(ability_active)
		ability_active = FALSE
		to_chat(user, SPAN_WARNING("You are not ready to use [src]'s ability"))
		return

	if(world.time < next_use)
		to_chat(user, SPAN_WARNING("\The [src] isn't ready to use it!"))
		return

	next_use = world.time + ability_cooldown
	ability_active = TRUE
	to_chat(user, SPAN_WARNING("You are ready to use [src]'s ability"))

/obj/item/material/sword/katana/muramasa/proc/engage(var/mob/user, var/turf/target_turf, var/list/moblist)
	var/mob/living/carbon/human/H = user

	if(!istype(H.loc, /turf))
		to_chat(H, SPAN_WARNING("You cannot use this ability out of your current location"))
		return

	if(!target_turf)
		to_chat(H, SPAN_WARNING("No valid target found"))
		return

	if(target_turf.density)
		to_chat(H, SPAN_WARNING("You cannot move into solid walls."))
		return

	if(target_turf.contains_dense_objects())
		to_chat(H, SPAN_WARNING("You cannot move to a location with solid objects."))
		return

	if(target_turf.z != H.z || get_dist(target_turf, get_turf(H)) > world.view)
		to_chat(H,  SPAN_WARNING("You cannot move to such a distant object."))
		return

	user.visible_message(SPAN_WARNING("You can see how [user] is preparing for a lunge!"))

	if(do_after(user, ability_prepare))
		for(var/mob/living/mob in moblist)
			playsound(mob,'sound/weapons/katana_swipe.ogg', 20, 1)
			mob.stunned = 1
			addtimer(CALLBACK(src, .proc/cut, mob, user, user.zone_sel.selecting), 1 SECOND)
		H.forceMove(target_turf)
		ability_active = FALSE


/obj/item/material/sword/katana/muramasa/proc/cut(var/mob/living/target, var/mob/user, var/target_zone)
	if(ishuman(target))
		if(target_zone == BP_CHEST)
			target.hit_with_weapon(src, user, force * 1.5, target_zone)
		else
			var/mob/living/carbon/human/H = target
			var/obj/item/organ/external/affected = H.get_organ(target_zone)
			affected.droplimb(1,DROPLIMB_EDGE)
	else
		target.hit_with_weapon(src, user, force * 2, target_zone)
	target.stunned = 0

/obj/item/material/sword/katana/muramasa/afterattack(atom/target, mob/user, proximity)
	. = ..()

	if(!ability_active || proximity)
		return

	if(world.time < next_attack_use)
		return

	next_attack_use = world.time + 5

	if(user && user.get_active_hand() == src)
		var/turf/target_turf = get_turf(target)
		var/list/moblist = list()

		if(!target_turf)
			return

		if(/obj/item/grab in user.contents)
			to_chat(user,  SPAN_WARNING("You cannot use it while grab."))
			return

		for(var/turf/T in getline(user, target_turf))
			if(T.density)
				to_chat(user,  SPAN_WARNING("There is wall in your way."))
				return
			for(var/atom/A in T)
				if(A == user)
					continue
				if(isliving(A))
					var/mob/living/livingmob = A
					moblist += livingmob
				if(A.density && !isliving(A))
					to_chat(user,  SPAN_WARNING("There is wall or solid object in your way."))
					return
		engage(user, target_turf, moblist)
