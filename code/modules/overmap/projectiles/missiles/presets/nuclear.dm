// Nuclear, for specific uses and admin shittery.
/obj/structure/missile/nuke
	name = "SNDM-M missile"
	overmap_name = "ballistic missile"
	desc = "A weapon designed to squash insurrections and, in proper configurations, crack planets. If you're the target? Start praying."

	equipment = list(
		/obj/item/missile_equipment/thruster/point,
		/obj/item/missile_equipment/autoarm,
		/obj/item/missile_equipment/payload/nuclear
	)

/obj/structure/missile/nuke/attackby(var/obj/item/I, var/mob/user)// :)
	return
