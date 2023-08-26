/obj/item/organ/internal/cooling_system
	name = "cooling system"
	icon_state = "cooling0"
	organ_tag = "cooling system"
	organ_tag = BP_COOLING
	parent_organ = BP_GROIN
	var/refrigerant_max = 50	// Максимальное количество охладителя
	var/refrigerant_rate = 5	// Чем больше это значение, тем сильнее будет идти нагрев владельца.
	var/durability_factor = 30	// Чем больше это значение, тем сильнее будет идти нагрев владельца при повреждениях
	var/safety = 1
	damage_reduction = 0.8
	max_damage = 50
	var/sprite_name = "cooling"

/obj/item/organ/internal/cooling_system/New()
	robotize()
	create_reagents(refrigerant_max)
	reagents.add_reagent(/datum/reagent/coolant, refrigerant_max)
	..()

/obj/item/organ/internal/cooling_system/emp_act(severity)
	damage += rand(15 - severity * 5, 20 - severity * 5)
	..()

/obj/item/organ/internal/cooling_system/proc/get_coolant_drain()
	var/damage_factor = (damage*durability_factor)/max_damage
	return damage_factor

/obj/item/organ/internal/cooling_system/Process()

	if(!owner || owner.stat == DEAD || owner.bodytemperature < 32)
		return

	if(reagents.has_reagent(/datum/reagent/coolant))
		handle_cooling()
	..()

/obj/item/organ/internal/cooling_system/proc/handle_cooling()

	var/obj/item/organ/internal/cell/C = owner.internal_organs_by_name[BP_CELL]
	refrigerant_rate = 5
	if (C && C.get_charge() < 25)
		return

	if(reagents.get_reagent_amount(/datum/reagent/coolant) > 0 && !is_broken())
		var/bruised_cost = get_coolant_drain()

		if(is_bruised())
			reagents.remove_reagent(/datum/reagent/coolant,  (bruised_cost/durability_factor))
		if(get_coolant_remaining() <= 0)
			refrigerant_rate += 40

		if(is_damaged())
			get_coolant_drain()
			refrigerant_rate += bruised_cost     // Нагрев владельца при повреждениях высчитывается тут.


/obj/item/organ/internal/cooling_system/proc/get_tempgain()
	if(refrigerant_rate > 0)
		var/tempgain = refrigerant_rate
		return tempgain

/obj/item/organ/internal/cooling_system/proc/get_coolant_remaining()
	if(status & ORGAN_DEAD)
		return 0
	return round(reagents.total_volume)

/obj/item/organ/internal/cooling_system/examine(mob/user, distance)
	. = ..()
	if(distance <= 0)
		to_chat(user, text("[icon2html(src, viewers(get_turf(src)))] [] contains [] units of liquid left!", src, src.reagents.total_volume))

/obj/item/organ/internal/cooling_system/attack_self(mob/user as mob)
	safety = !safety
	src.icon_state = "[sprite_name][!safety]"
	src.desc = "The injection is [safety ? "on" : "off"]."
	to_chat(user, "The injection is [safety ? "on" : "off"].")
	return


/obj/item/organ/internal/cooling_system/afterattack(var/atom/target, var/mob/user, var/flag)

	var/beaker = istype(target, /obj/item/reagent_containers/glass/)

	if (flag && (beaker || istype(target, /obj/item/reagent_containers/glass/)))
		var/obj/dispenser = target
		var/amount = reagents.get_free_space()
		if (safety)
			if (amount <= 0)
				to_chat(user, SPAN_NOTICE("\The [src] is full."))
				return
			if (beaker)
				if (dispenser.reagents.total_volume <= 0)
					to_chat(user, SPAN_NOTICE("\The [dispenser] is empty."))
					return
				amount = dispenser.reagents.trans_to_obj(src, refrigerant_max)
				to_chat(user, SPAN_NOTICE("You fill \the [src] with [amount] units from \the [dispenser]."))
				playsound(src.loc, 'sound/effects/refill.ogg', 50, 1, -6)
		if (!safety)
			if (beaker)
				amount = src.reagents.trans_to_obj(dispenser, refrigerant_max)
				to_chat(user, SPAN_NOTICE("You fill \the [dispenser] with [amount] units from \the [src]."))
				playsound(src.loc, 'sound/effects/refill.ogg', 50, 1, -6)

	else
		return ..()
	return
