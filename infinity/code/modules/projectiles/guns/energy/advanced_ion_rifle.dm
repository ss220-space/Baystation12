/obj/item/gun/energy/ionrifle/advanced
	name = "MkII spec combat ion rifle"
	desc = "The NT MkII spec combat - modificated verison of NT Mk60 EW Halicon, adapted for combat. This one have additional Fire type - anti-energy shield, which overheat energy shields of differents synthetic units shielded from EMP."
	projectile_type = /obj/item/projectile/ion
	firemodes = list(
		list(mode_name="anti-mech shield", fire_delay=40, projectile_type = /obj/item/projectile/beam/antimech, charge_cost = 50),
		list(mode_name="ion bolt", fire_delay=30, projectile_type = /obj/item/projectile/ion, charge_cost = 30, accuracy = 7),
		)

/obj/item/projectile/beam/antimech
	name = "сoncentradet energy"
	damage = 300
	damage_type = PAIN
	icon_state = "pu_laser"
