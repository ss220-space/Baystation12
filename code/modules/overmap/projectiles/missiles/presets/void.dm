// Torp, for Ascent ship.
/obj/structure/missile/void
	name = "Void Torpedo"
	overmap_name = "void torpedo"
	desc = "This weapon finds a vessel, punches into it and quite literally nullvoids whatever is in range. \
	This is based off of technology not able to be understood by both the SCG and Skrell."

	equipment = list(
		/obj/item/missile_equipment/thruster/point,
		/obj/item/missile_equipment/autoarm,
		/obj/item/missile_equipment/payload/void
	)

/obj/structure/missile/void/attackby(var/obj/item/I, var/mob/user)// :)
	return
