/obj/item/gun/energy/antimech
	name = "Anti-mech shields energy rifle"
	desc = "Specializated anti-energy shield rifle,created for overheat enemy energy shields."
	icon = 'icons/obj/guns/laser_sniper.dmi'
	icon_state = "sniper"
	item_state = "sniper"
	charge_cost = 40
	accuracy = 10
	fire_delay = 40
	max_shots = 4
	recharge_time = 0
	slot_flags = SLOT_BACK
	projectile_type = /obj/item/projectile/beam/antienergy
	wielded_item_state = "laser-wielded"
	wielded_item_state = "sniper-wielded"

/obj/item/projectile/beam/antienergy
	damage = 200
	armor_penetration = -3000
	force = -3000
	penetration_modifier = 0
	damage_type = PAIN
