/obj/item/mech_equipment/mounted_system/taser/plasma_rifle
	name = "mounted plasma rifle"
	desc = "A very deadly mounted plasma rifle, capable of destroying everything."
	icon_state = "mech_pulse"
	holding_type = /obj/item/gun/energy/pulse_rifle/mounted/mech

/obj/item/gun/energy/pulse_rifle/mounted/mech
	self_recharge = TRUE
	use_external_power = TRUE
	has_safety = FALSE
	one_hand_penalty= 0

//Mech machinegun START
/obj/item/gun/energy/machingegun/mounted/mech
	name = "mech machingegun"
	desc = "You shouldn't see this!"
	icon = 'icons/obj/guns/saw.dmi'
	icon_state = "l6closed50"
	item_state = "l6closedmag"
	force = 10
	projectile_type = /obj/item/projectile/bullet/rifle
	max_shots = 30
	multi_aim = 1
	fire_delay=0
	autofire_enabled=1
	burst=5
	accuracy = -1
	bulk = GUN_BULK_RIFLE
	w_class = ITEM_SIZE_HUGE
	one_hand_penalty= 0

	self_recharge = TRUE
	recharge_time = 3
	use_external_power = TRUE
	has_safety = FALSE

/obj/item/mech_equipment/mounted_system/taser/machinegun
	name = "mounted machinegun"
	desc = "An exosuit-mounted machinegun. Handle with care."
	icon_state = "mech_scatter"
	holding_type = /obj/item/gun/energy/machingegun/mounted/mech
//Mech machinegun END

//Mech autoshotgun START
/obj/item/gun/energy/shotgun/mounted/mech
	name = "mech autoshotgun"
	desc = "Stop shitspawn,pedal'!"
	icon = 'icons/obj/guns/saw.dmi'
	icon_state = "l6closed50"
	item_state = "l6closedmag"
	projectile_type = /obj/item/projectile/bullet/shotgun
	firemodes = list(
		list(mode_name="Beanbang", projectile_type=/obj/item/projectile/bullet/shotgun/beanbag),
		list(mode_name="Manstoppers", projectile_type=/obj/item/projectile/bullet/shotgun/manstopper),
		list(mode_name="Slugs", projectile_type=/obj/item/projectile/bullet/shotgun),
		)
	max_shots = 10
	multi_aim = 1
	fire_delay=15
	autofire_enabled=1
	burst=3
	accuracy = 2
	bulk = GUN_BULK_RIFLE
	w_class = ITEM_SIZE_HUGE
	one_hand_penalty= 0
	self_recharge = TRUE
	recharge_time = 10
	use_external_power = TRUE
	has_safety = FALSE
	charge_cost = 60

/obj/item/mech_equipment/mounted_system/taser/shotgun
	name = "mounted automatic shotgun"
	desc = "An exosuit-mounted automatic shotgun. Handle with care."
	icon_state = "mech_shotgun"
	holding_type = /obj/item/gun/energy/shotgun/mounted/mech
//Mech autoshotgun END

/obj/item/mech_equipment/mounted_system/taser/advanced //Mech elecrolaser for shoulders
	restricted_hardpoints = list(HARDPOINT_LEFT_HAND, HARDPOINT_RIGHT_HAND,HARDPOINT_LEFT_SHOULDER,HARDPOINT_RIGHT_SHOULDER)

//Lasercanon START

/obj/item/mech_equipment/mounted_system/taser/laser/Ert //Mech laser canon (Danger shit)
	name = "\improper CH-PS \"Anigilator\" laser"
	desc = "An exosuit-mounted laser rifle. Handle with care."
	icon_state = "mech_lasercarbine"
	holding_type = /obj/item/gun/energy/lasercannon/mounted

/obj/item/gun/energy/lasercannon/mounted
	name = "mounted laser cannon"
	self_recharge = 1
	use_external_power = 1
	recharge_time = 40
	accuracy = 5
	charge_cost = 100
	fire_delay = 30
	accuracy = 4 //mounted laser cannons don't need any help, thanks
	one_hand_penalty = 0
	has_safety = FALSE
//Lasercanon END

//MechRPG START
/obj/item/mech_equipment/mounted_system/taser/rocketlauncher
	name = "Advanced mech rocket launcher"
	desc = "An exosuit-mounted rocket launcher, placed on shoulder"
	icon_state = "mech_missilerack"
	restricted_hardpoints = list(HARDPOINT_LEFT_SHOULDER,HARDPOINT_RIGHT_SHOULDER)
	holding_type = /obj/item/gun/energy/rocketlauncher/mounted

/obj/item/gun/energy/rocketlauncher/mounted
	self_recharge = 1
	use_external_power = 1
	recharge_time = 100
	fire_delay=40
	accuracy = 1
	one_hand_penalty = 0
	has_safety = FALSE

/obj/item/gun/energy/rocketlauncher
	name = "Mech rocketlauncher"
	desc = "Most dangerous mech weapon off all"
	icon_state = "mech_missilerack"
	has_safety = FALSE
	projectile_type = /obj/item/projectile/Mechmissle

/obj/item/projectile/Mechmissle
	icon_state = "missile"
	throwforce = 15

/obj/item/projectile/Mechmissle/on_impact(var/atom/target, var/blocked = 0)
	explosion(target, 0, 2, 2, 4)
//MechRPG END
