/obj/structure/closet/secure_closet/guncabinet
	name = "gun cabinet"
	req_access = list(access_armory)
	icon = 'icons/obj/guncabinet.dmi'
	icon_state = "base"
	anchored = TRUE

	door_underlay = TRUE
	door_anim_squish = 0.12
	door_anim_angle = 119
	door_hinge = -9.5

/obj/structure/closet/secure_closet/guncabinet/New()
	. = ..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/LateInitialize(mapload, ...)
	. = ..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/toggle()
	..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/open() //There are plenty of things that can open it that don't use toggle
	..()
	update_icon()

/obj/structure/closet/secure_closet/guncabinet/update_icon()
	overlays.Cut()
	var/lazors = 0
	var/shottas = 0
	for (var/obj/item/gun/G in contents)
		if (istype(G, /obj/item/gun/energy))
			lazors++
		if (istype(G, /obj/item/gun/projectile/))
			shottas++
	if (lazors || shottas)
		for (var/i = 0 to 2)
			if (lazors > 0 && (shottas <= 0 || prob(50)))
				lazors--
				add_overlay("laser[i]")
			else if (shottas > 0)
				shottas--
				add_overlay("projectile[i]")
	. = ..()
