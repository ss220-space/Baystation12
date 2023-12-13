/obj/item/robot_parts/robot_component/armour/exosuit/combat/syndie
	name = "tactical combat plating"
	desc = "Special combat plating, designed for operating in field of battle."
	armor = list(
		melee = ARMOR_MELEE_MAJOR + 5, //55
		bullet = ARMOR_BALLISTIC_RESISTANT, //65
		laser = ARMOR_LASER_MAJOR, //55
		energy = ARMOR_ENERGY_STRONG, //EMP dont work actually
		bomb = ARMOR_BOMB_RESISTANT,
		bio = ARMOR_BIO_SHIELDED
		)
	origin_tech = list(TECH_MATERIAL = 7)
