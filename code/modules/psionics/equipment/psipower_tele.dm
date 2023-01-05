/obj/item/psychic_power/psijaunter
	name = "psionic focus"
	maintain_cost = 1
	icon_state = "psijaunter"
	var/obj/item/device/radio/beacon/linked
	var/attuned = 1

/obj/item/psychic_power/psijaunter/examine(mob/user, distance)
	. = ..()
	to_chat(user, SPAN_NOTICE("Вы чувствуете, что [attuned ? "активен и отзывается в вашем сознании знаком [attuned]" : "не опирается на блюспейс-резонанс"]."))
/obj/item/psychic_power/psijaunter/Initialize()
	. = ..()

/obj/item/psychic_power/psijaunter/attack_self(mob/user)
	if(!istype(linked) || !attuned)
		return 0

	animated_teleportation(user, linked)
	attuned = max(attuned - 1, 0)

/obj/item/psychic_power/psijaunter/afterattack(atom/target, mob/user , proximity)
	if(!proximity) return
	if(istype(target,/obj/item/device/radio/beacon))
		linked = target
		to_chat(user, "You succesfully attuned [src] to [target]!")
	else
		to_chat(user, "You can't attune [src] to [target]!")
