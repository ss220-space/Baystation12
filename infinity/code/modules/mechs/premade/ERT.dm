/mob/living/exosuit/premade/Ert
	name = "Nanotrasen special combat mech"
	desc = "A sleek, modern combat exosuit created by Nanotrasen for specific missions."

/mob/living/exosuit/premade/Ert/Initialize()
	if(!arms)
		arms = new /obj/item/mech_component/manipulators/Ert(src)
		arms.color = COLOR_CYAN_BLUE
	if(!legs)
		legs = new /obj/item/mech_component/propulsion/merc(src)
		legs.color = COLOR_CYAN_BLUE
	if(!head)
		head = new /obj/item/mech_component/sensors/merc(src)
		head.color = COLOR_WHITE
	if(!body)
		body = new /obj/item/mech_component/chassis/merc(src)
		body.color = COLOR_WHITE

	. = ..()

/mob/living/exosuit/premade/Ert/spawn_mech_equipment()
	..()
	install_system(new /obj/item/mech_equipment/mounted_system/taser/laser/Ert(src), HARDPOINT_RIGHT_HAND)
	install_system(new /obj/item/mech_equipment/mounted_system/taser/shotgun(src), HARDPOINT_LEFT_HAND)
	install_system(new /obj/item/mech_equipment/shields(src), HARDPOINT_BACK)
	install_system(new /obj/item/mech_equipment/light(src), HARDPOINT_RIGHT_SHOULDER)
	install_system(new /obj/item/mech_equipment/flash(src), HARDPOINT_LEFT_SHOULDER)

/obj/item/mech_component/manipulators/Ert
	name = "Nanotrasen combat arms"
	exosuit_desc_string = "flexible, advanced manipulators"
	icon_state = "combat_arms"
	melee_damage = 40
	action_delay = 10
	power_use = 50

/obj/item/mech_component/propulsion/Ert
	name = "Nanotrasen combat legs"
	exosuit_desc_string = "sleek hydraulic legs"
	icon_state = "combat_legs"
	move_delay = 3
	turn_delay = 3
	power_use = 20

/obj/item/mech_component/sensors/Ert
	name = "Nanotrasen combat sensors"
	gender = PLURAL
	exosuit_desc_string = "high-resolution thermal sensors"
	icon_state = "combat_head"
	vision_flags = SEE_MOBS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	power_use = 200

/obj/item/mech_component/sensors/Ert/prebuild()
	..()
	software = new(src)
	software.installed_software = list(MECH_SOFTWARE_WEAPONS,MECH_SOFTWARE_UTILITY)


/obj/item/mech_component/chassis/Ert
	name = "sealed exosuit chassis"
	hatch_descriptor = "canopy"
	pilot_coverage = 100
	exosuit_desc_string = "an armoured chassis"
	icon_state = "combat_body"
	power_use = 40

/obj/item/mech_component/chassis/Ert/prebuild()
	. = ..()
	QDEL_NULL(cell)
	cell = new /obj/item/cell/hyper(src)
	m_armour = new /obj/item/robot_parts/robot_component/armour/exosuit/combat/syndie(src)


/obj/item/mech_component/chassis/Ert/Initialize()
	pilot_positions = list(
		list(
			"[NORTH]" = list("x" = 8,  "y" = 8),
			"[SOUTH]" = list("x" = 8,  "y" = 8),
			"[EAST]"  = list("x" = 4,  "y" = 8),
			"[WEST]"  = list("x" = 12, "y" = 8)
		)
	)

	. = ..()
