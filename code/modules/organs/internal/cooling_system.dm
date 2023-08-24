/obj/item/organ/internal/cooling_system
	name = "cooling system"
	icon_state = "cooling"
	organ_tag = "cooling system"
	organ_tag = BP_COOLING
	parent_organ = BP_GROIN
	var/refrigerant_max = 50	// Максимальное количество охладителя
	var/refrigerant_rate = 5	// Чем больше это значение, тем сильнее будет идти нагрев владельца.
	damage_reduction = 0.8
	max_damage = 60

/obj/item/organ/internal/cooling_system/New()
	robotize()
	create_reagents(refrigerant_max)
	reagents.add_reagent(/datum/reagent/coolant, refrigerant_max)
	..()

/obj/item/organ/internal/cooling_system/emp_act(severity)
	damage += rand(15 - severity * 5, 20 - severity * 5)
	..()

/obj/item/organ/internal/cooling_system/proc/get_coolant_drain()
	var/damage_factor = 15 * damage/max_damage
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
		if(reagents.get_reagent_amount(/datum/reagent/coolant) < 1)
			return

		if(is_bruised())
			var/bruised_cost = get_coolant_drain()
			reagents.remove_reagent(/datum/reagent/coolant, bruised_cost)
			get_coolant_drain()
			refrigerant_rate += bruised_cost     // Нагрев владельца при повреждениях высчитывается тут.

/obj/item/organ/internal/cooling_system/proc/get_tempgain()
	if(refrigerant_rate < 31 && refrigerant_rate > 0)
		var/tempgain = refrigerant_rate
		return tempgain
