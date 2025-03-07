/obj/item/gun/energy/laser
	name = "G40E laser carbine"
	desc = "A Hephaestus Industries G40E carbine, designed to kill with concentrated energy blasts."
	icon = 'icons/obj/guns/laser_carbine.dmi'
	icon_state = "laser"
	item_state = "laser"
	slot_flags = SLOT_BELT|SLOT_BACK
	force = 10
	origin_tech = list(TECH_COMBAT = 3, TECH_MAGNET = 2)
	matter = list(MATERIAL_STEEL = 2000)
	projectile_type = /obj/item/projectile/beam/midlaser
	wielded_item_state = "laser-wielded"

	bulk = GUN_BULK_CARABINE
	w_class = ITEM_SIZE_LARGE
	one_hand_penalty = 2
	s_gun = "G40E"
	is_serial = 1

/obj/item/gun/energy/laser/mounted
	self_recharge = 1
	use_external_power = 1
	one_hand_penalty = 0 //just in case
	has_safety = FALSE

/obj/item/gun/energy/laser/practice
	name = "practice laser carbine"
	desc = "A modified version of the HI G40E, this one fires less concentrated energy bolts designed for target practice."
	icon_state = "laserp"
	projectile_type = /obj/item/projectile/beam/practice
	charge_cost = 10 //How much energy is needed to fire.
	is_serial = 0

/obj/item/gun/energy/laser/practice/proc/hacked()
	return projectile_type != /obj/item/projectile/beam/practice

/obj/item/gun/energy/laser/practice/emag_act(var/remaining_charges, var/mob/user, var/emag_source)
	if(hacked())
		return NO_EMAG_ACT
	to_chat(user, "<span class='warning'>You disable the safeties on [src] and crank the output to the lethal levels.</span>")
	desc += " Its safeties are disabled and output is set to dangerous levels."
	projectile_type = /obj/item/projectile/beam/midlaser
	charge_cost = 20
	max_shots = rand(3,6) //will melt down after those
	return 1

/obj/item/gun/energy/laser/practice/handle_post_fire(mob/user, atom/target, var/pointblank=0, var/reflex=0)
	..()
	if(hacked())
		max_shots--
		if(!max_shots) //uh hoh gig is up
			to_chat(user, "<span class='danger'>\The [src] sizzles in your hands, acrid smoke rising from the firing end!</span>")
			desc += " The optical pathway is melted and useless."
			projectile_type = null

obj/item/gun/energy/retro
	name = "G21E laser pistol"
	icon = 'icons/obj/guns/retro_laser.dmi'
	icon_state = "retro"
	item_state = "retro"
	desc = "An older model of the basic lasergun. Nevertheless, it is still quite deadly and easy to maintain, making it a favorite amongst pirates and other outlaws."
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	projectile_type = /obj/item/projectile/beam
	fire_delay = 15 //old technology, and a pistol

	bulk = GUN_BULK_REVOLVER
	w_class = ITEM_SIZE_NORMAL
	s_gun = "G21E"
	is_serial = 1

/obj/item/gun/energy/captain
	name = "antique laser gun"
	icon = 'icons/obj/guns/caplaser.dmi'
	icon_state = "caplaser"
	item_state = "caplaser"
	desc = "A rare weapon, handcrafted by a now defunct specialty manufacturer on Luna for a small fortune. It's certainly aged well."
	force = 5
	slot_flags = SLOT_BELT //too unusually shaped to fit in a holster
	projectile_type = /obj/item/projectile/beam
	origin_tech = null
	max_shots = 5 //to compensate a bit for self-recharging
	self_recharge = 1

	w_class = ITEM_SIZE_NORMAL
	bulk = GUN_BULK_REVOLVER //inf
	one_hand_penalty = 1 //a little bulky

/obj/item/gun/energy/lasercannon
	name = "expermental laser cannon"
	desc = "With the laser cannon, the lasing medium is enclosed in a tube lined with uranium-235 and subjected to high neutron flux in a nuclear reactor core. This incredible technology may help YOU achieve high excitation rates with small laser volumes!"
	icon_state = "lasercannon"
	icon = 'icons/obj/guns/laser_cannon.dmi'
	item_state = null
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_POWER = 3)
	slot_flags = SLOT_BELT|SLOT_BACK
	projectile_type = /obj/item/projectile/beam/heavylaser
	charge_cost = 40
	max_shots = 6
	fire_delay = 20
	wielded_item_state = "gun_wielded"

//	accuracy = 2
	one_hand_penalty = 6 //large and heavy
	bulk = GUN_BULK_MACHINEGUN
	w_class = ITEM_SIZE_HUGE
	is_serial = 1
	s_gun = "LC"


/obj/item/gun/energy/laser/assault
	name = "Laser assault rifle"
	desc = "An advanced fully automatic laser rifle, dubbed LAR-1. Capable of firing in several firemodes."
	icon = 'icons/obj/guns/laserauto.dmi'
	icon_state = "laserauto"
	item_state = "laserauto"
	wielded_item_state = "laserauto-wielded"
	projectile_type = /obj/item/projectile/beam/auto
	max_shots = 12
	origin_tech = list(TECH_COMBAT = 4, TECH_MAGNET = 3)
	matter = list(MATERIAL_STEEL = 4000)

	firemodes = list(
		list(mode_name="single fire", fire_delay=4, burst=1, one_hand_penalty = 2, dispersion=list(0, 0.2, 0.4)),
		list(mode_name="short bursts", fire_delay=4, burst=3, burst_delay = 3.1, one_hand_penalty=6, dispersion=list(0.6, 0.8, 1.0, 1.2, 1.4), burst_accuracy=list(0,-1,-1,-2,-3)),
		list(mode_name="full auto", fire_delay=2, burst=1, burst_delay=2.8, one_hand_penalty=4, dispersion=list(0.4, 0.8, 1.2, 1.4), burst_accuracy=list(0,-1,-1,-2), autofire_enabled=1),
		)


/obj/item/gun/energy/xray
	name = "G56E x-ray carbine"
	desc = "A high-power laser gun capable of emitting concentrated x-ray blasts, that are able to penetrate laser-resistant armor much more readily than standard photonic beams."
	icon = 'icons/obj/guns/xray.dmi'
	icon_state = "xray"
	item_state = "xray"
	slot_flags = SLOT_BELT|SLOT_BACK
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 3, TECH_MAGNET = 2, TECH_ESOTERIC = 2)
	projectile_type = /obj/item/projectile/beam/xray/midlaser
	charge_cost = 15
	max_shots = 10
	wielded_item_state = "xray_wielded"
	combustion = 0

	bulk = GUN_BULK_CARABINE //inf
	w_class = ITEM_SIZE_LARGE
	one_hand_penalty = 2
	s_gun = "G56E"
	is_serial = 1

/obj/item/gun/energy/xray/pistol
	name = "G56E-s x-ray pistol"
	icon = 'icons/obj/guns/xray_pistol.dmi'
	icon_state = "oldxray"
	item_state = "oldxray"
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	origin_tech = list(TECH_COMBAT = 4, TECH_MATERIAL = 3, TECH_MAGNET = 2, TECH_ESOTERIC = 2)
	projectile_type = /obj/item/projectile/beam/xray
	fire_delay = 10

	bulk = GUN_BULK_REVOLVER
	w_class = ITEM_SIZE_NORMAL
	one_hand_penalty = 1
	s_gun = "G56E-S"

/obj/item/gun/energy/sniperrifle
	name = "9E marksman energy rifle"
	desc = "The HI DMR 9E is an older design of Hephaestus Industries. A designated marksman rifle capable of shooting powerful ionized beams, this is a weapon to kill from a distance."
	icon = 'icons/obj/guns/laser_sniper.dmi'
	icon_state = "sniper"
	item_state = null
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 5, TECH_POWER = 4)
	projectile_type = /obj/item/projectile/beam/sniper
	slot_flags = SLOT_BACK
	charge_cost = 40
	max_shots = 4
	fire_delay = 35
	force = 10
	wielded_item_state = "sniper-wielded"
	scope_zoom = 2

	accuracy = -2 //shooting at the hip
	scoped_accuracy = 9
	bulk = GUN_BULK_SNIPER_RIFLE
	w_class = ITEM_SIZE_HUGE
	one_hand_penalty = 5 // The weapon itself is heavy, and the long barrel makes it hard to hold steady with just one hand.
	s_gun = "9E"
	is_serial = 1

////////Laser Tag////////////////////

/obj/item/gun/energy/lasertag
	name = "laser tag gun"
	icon = 'icons/obj/guns/lasertag.dmi'
	icon_state = "bluetag"
	item_state = "laser"
	desc = "Standard issue weapon of the Imperial Guard."
	origin_tech = list(TECH_COMBAT = 1, TECH_MAGNET = 2)
	self_recharge = 1
	matter = list(MATERIAL_STEEL = 2000)
	projectile_type = /obj/item/projectile/beam/lastertag/blue
	var/required_vest

/obj/item/gun/energy/lasertag/special_check(var/mob/living/carbon/human/M)
	if(ishuman(M))
		if(!istype(M.wear_suit, required_vest))
			to_chat(M, "<span class='warning'>You need to be wearing your laser tag vest!</span>")
			return 0
	return ..()

/obj/item/gun/energy/lasertag/blue
	icon_state = "bluetag"
	item_state = "bluetag"
	projectile_type = /obj/item/projectile/beam/lastertag/blue
	required_vest = /obj/item/clothing/suit/bluetag

/obj/item/gun/energy/lasertag/red
	icon_state = "redtag"
	item_state = "redtag"
	projectile_type = /obj/item/projectile/beam/lastertag/red
	required_vest = /obj/item/clothing/suit/redtag
