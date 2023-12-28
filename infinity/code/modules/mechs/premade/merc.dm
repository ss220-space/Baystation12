/mob/living/exosuit/premade/merc
	name = "Mercenary exosuit"
	desc = "A sleek, modern combat exosuit."

/mob/living/exosuit/premade/merc/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/merc(src)
		arms.color = COLOR_RED
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/merc(src)
		legs.color = COLOR_RED
	if(!head)
		head = new /obj/item/mech_component/sensors/merc(src)
		head.color = COLOR_RED
	if(!body)
		body = new /obj/item/mech_component/chassis/merc(src)
		body.color = COLOR_RED

	. = ..()

/mob/living/exosuit/premade/merc/spawn_mech_equipment()
	..()
	install_system(new /obj/item/mech_equipment/mounted_system/taser/plasma_rifle(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/machinegun(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/shields(src), HARDPOINT_BACK)
	install_system(new /obj/item/mech_equipment/light(src), HARDPOINT_HEAD)

/obj/item/mech_component/manipulators/merc
	name = "combat arms"
	exosuit_desc_string = "flexible, advanced manipulators"
	icon_state = "combat_arms"
	melee_damage = 30
	max_damage = 180
	action_delay = 10
	power_use = 50

/obj/item/mech_component/propulsion/merc
	name = "combat legs"
	exosuit_desc_string = "sleek hydraulic legs"
	icon_state = "combat_legs"
	max_damage = 180
	move_delay = 3
	turn_delay = 3
	power_use = 20

/obj/item/mech_component/sensors/merc
	name = "combat sensors"
	gender = PLURAL
	exosuit_desc_string = "high-resolution thermal sensors"
	icon_state = "combat_head"
	max_damage = 160
	vision_flags = SEE_MOBS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	power_use = 200

/obj/item/mech_component/sensors/merc/prebuild()
	..()
	software = new(src)
	software.installed_software = list(MECH_SOFTWARE_WEAPONS)

/obj/item/mech_component/chassis/merc
	name = "sealed exosuit chassis"
	hatch_descriptor = "canopy"
	max_damage = 300
	pilot_coverage = 100
	exosuit_desc_string = "an armoured chassis"
	icon_state = "combat_body"
	power_use = 40

/obj/item/mech_component/chassis/merc/prebuild()
	. = ..()
	QDEL_NULL(cell)
	cell = new /obj/item/cell/hyper(src)
	m_armour = new /obj/item/robot_parts/robot_component/armour/exosuit/combat/syndie(src)


/obj/item/mech_component/chassis/merc/Initialize()
	pilot_positions = list(
		list(
			"[NORTH]" = list("x" = 8,  "y" = 8),
			"[SOUTH]" = list("x" = 8,  "y" = 8),
			"[EAST]"  = list("x" = 4,  "y" = 8),
			"[WEST]"  = list("x" = 12, "y" = 8)
		)
	)

	. = ..()
