//#include "whitemesa_areas.dm"
//#include "whitemesa_shuttle.dm"

/obj/effect/overmap/visitable/sector/whitemesa
	scanner_name = "Deserted planetoid"
	scanner_desc = @{"[i]Stellar Body[/i]: UNKNOWN
[i]Class[/i]: L-Class Planetoid
[i]Habitability[/i]: Moderate (Medium Temperature)
[b]Notice[/b]: Sensor array detects an deserted planet with an encrypted NanoTrasen sygnal coming from the planet's surface. Scans further indicate EMI fields below the planet's surface."}
	sector_flags = 0
	color = "#fc0404"
	icon_state = "globe"
	start_x = 20
	start_y = 20
	initial_generic_waypoints = list(
		"mesashuttle_port_dock",
		"nav_mesashuttle_start",
		"nav_ert_deck1"
	)

/obj/effect/overmap/visitable/sector/whitemesa/New(nloc, max_x, max_y)
	name = "[generate_planet_name()], \a [name]"
	..()

/datum/map_template/ruin/away_site/whitemesa
	name = "White Mesa"
	id = "awaysite_mesa"
	description = "Half Life inspired underground base"
	spawn_cost = 1 // WAS 0.5
	spawn_weight = 99
	prefix = "maps/away_inf/"
	template_flags = TEMPLATE_FLAG_SPAWN_GUARANTEED
	suffixes = list("whitemesa/white_mesa1.dmm", "whitemesa/white_mesa2.dmm", "whitemesa/white_mesa3.dmm")
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/mesashuttle)

// Submap shuttles.
// Mule - Shuttle One, Port Side
/obj/effect/overmap/visitable/ship/landable/mesa
	shuttle = "Mesa"
	scanner_name = "Unknown Shuttle"
	scanner_desc = @{"[i]Registration[/i]: PRIVATE
[i]Class[/i]: Small Shuttle
[i]Transponder[/i]: Transmitting (CIV), non-hostile
[b]Notice[/b]: Small private vessel"}
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = WEST
	skill_needed = SKILL_BASIC
	vessel_size = SHIP_SIZE_SMALL

/obj/machinery/computer/shuttle_control/explore/mesa
	name = "shuttle control console"
	shuttle_tag = "mesashuttle"

/area/white_mesa/mesashuttle
	name = "Mesa Shuttle Area"
	icon_state = "yellow"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	req_access = list()

/obj/effect/shuttle_landmark/mesashuttle/start
	name = "MesaShuttle Docked"
	landmark_tag = "nav_mesashuttle_start"
	docking_controller = "mesashuttle_port_dock"
	base_area = /area/ship/farfleet/command/snz_exterior_dock
	base_turf = /turf/unsimulated/floor

/datum/shuttle/autodock/overmap/mesashuttle
	name = "mesashuttle"
	warmup_time = 5
	current_location = "nav_mesashuttle_start"
	range = 2
	dock_target = "nav_ert_deck1"
	shuttle_area = list(/area/white_mesa/mesashuttle)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling

/obj/effect/shuttle_landmark/mesashuttle/dock
	name = "NSV Sierra Dock"
	landmark_tag = "nav_ert_deck1"
	docking_controller = "rescue_shuttle_dock_airlock"

	//////////
	//TURFS///
	/////////

/turf/simulated/floor/exoplanet/lava_mesa
	name = "Green Acid"
	icon = 'acid.dmi'
	icon_state = "riverwater_motion"
	movement_delay = 1
	dirt_color = COLOR_GRAY20
	var/list/victims

/turf/simulated/floor/exoplanet/lava_mesa/on_update_icon()
	return

/turf/simulated/floor/exoplanet/lava_mesa/Initialize()
	. = ..()
	set_light(0.7, 1, 5, l_color = "#3cff00")

/turf/simulated/floor/exoplanet/lava_mesa/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/turf/simulated/floor/exoplanet/lava_mesa/Entered(atom/movable/AM)
	..()
	if(locate(/obj/structure/catwalk/) in src)
		return
	var/mob/living/L = AM
	if (istype(L) && L.can_overcome_gravity())
		return
	if(AM.is_burnable())
		LAZYADD(victims, weakref(AM))
		START_PROCESSING(SSobj, src)

/turf/simulated/floor/exoplanet/lava_mesa/Exited(atom/movable/AM)
	. = ..()
	LAZYREMOVE(victims, weakref(AM))

/turf/simulated/floor/exoplanet/lava_mesa/Process()
	if(locate(/obj/structure/catwalk/) in src)
		victims = null
		return PROCESS_KILL
	for(var/weakref/W in victims)
		var/atom/movable/AM = W.resolve()
		if (AM == null || get_turf(AM) != src || AM.is_burnable() == FALSE)
			victims -= W
			continue
		var/datum/gas_mixture/environment = return_air()
		var/pressure = environment.return_pressure()
		var/destroyed = AM.lava_act(environment, 5000 + environment.temperature, pressure)
		if(destroyed == TRUE)
			victims -= W
	if(!LAZYLEN(victims))
		return PROCESS_KILL

/turf/simulated/floor/exoplanet/lava_mesa/get_footstep_sound(var/mob/caller)
	return get_footstep(/decl/footsteps/lava, caller)

/turf/unsimulated/floor/away_inf/whitemesa/Zen_acid
	name = "Green Acid"
	desc = "It's unsafe to touch"
	icon = 'acid.dmi'
	icon_state = "riverwater_motion"
	temperature = 293
	color = "#33ff00"

/turf/unsimulated/floor/away_inf/whitemesa/Zen_acid/Initialize()
	.=..()

	set_light(0.7, 1, 5, l_color = "#3cff00")

/turf/unsimulated/floor/away_inf/whitemesa/Zen_floor
	name = "Xen floor"
	desc = "Am I really here?"
	icon = 'xen_turfs.dmi'
	icon_state = "xen_turf"
	temperature = 293

/turf/unsimulated/wall/away_inf/whitemesa/Zen
	name = "alien wall"
	desc = "You feel a sense of dread from just looking at this wall. Its surface seems to be constantly moving, as if it were breathing."
	icon = 'riverturfs.dmi'
	icon_state = "evilwall_1"
	opacity = TRUE
	density = TRUE
	temperature = 293
	color = "#3cff00"

/turf/unsimulated/wall/away_inf/whitemesa/Zen/Initialize()
	.=..()

	if(prob(80))
		icon_state = "evilwall_[rand(1,8)]"

//mobs//
//NEW HEADCRAB//


/mob/living/simple_animal/hostile/Headcrab
	name = "Headcrab"
	real_name = "Headcrab"
	desc = "A horrible creature!"
	icon = 'icons/mob/mob_headcrab.dmi'
	icon_state = "headcrab"
	icon_living = "headcrab"
	icon_dead = "headcrab_dead"
	turns_per_move = 3
	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"
	speed = 1
	maxHealth = 20
	health = 20

	harm_intent_damage = 8
	natural_weapon = /obj/item/natural_weapon/bite
	pry_time = 10 SECONDS
	pry_desc = "biting"

	ai_holder = /datum/ai_holder/simple_animal/hostile/Headcrab

	break_stuff_probability = 25
	faction = "mesa"
	bleed_colour = "#088504"

	var/Headcrab_color = "headcrab" //holder for icon set
	var/list/icon_sets = list("headcrab", "fast_headcrab", "poison_headcrab", "headcrab_armored")

/datum/ai_holder/simple_animal/hostile/Headcrab/engage_target()
	. = ..()

	var/mob/living/L = .
	if(istype(L))
		if(prob(15))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")

/datum/ai_holder/simple_animal/hostile/Headcrab/find_target(list/possible_targets, has_targets_list)
	. = ..()

	if(.)
		holder.custom_emote(1,"nashes at [.]")

/mob/living/simple_animal/hostile/Headcrab/Initialize()
	. = ..()
	Headcrab_randomify()
	update_icon()

/mob/living/simple_animal/hostile/Headcrab/proc/Headcrab_randomify()
	maxHealth = rand(initial(maxHealth), (1.5 * initial(maxHealth)))
	health = maxHealth
	if(prob(1))
		Headcrab_color = pick("white", "black")
	else
		Headcrab_color = pick(icon_sets)
	icon_state = "[Headcrab_color]"
	icon_living = "[Headcrab_color]"
	icon_dead = "[Headcrab_color]_dead"

//ORIGINAL ZOMBIE///

/mob/living/simple_animal/hostile/Xen_zombie
	name = "Zombie"
	desc = "Ugh... that smell can only mean zombies."
	icon = 'icons/mob/mobs_mesa.dmi'
	icon_state = "scientist_zombie"
	icon_living = "scientist_zombie"
	icon_dead = "zombie_dead"
	turns_per_move = 3
	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"
	speed = 1
	maxHealth = 50
	health = 50

	harm_intent_damage = 8
	natural_weapon = /obj/item/natural_weapon/bite
	pry_time = 10 SECONDS
	pry_desc = "biting"

	ai_holder = /datum/ai_holder/simple_animal/hostile/Xen_zombie

	break_stuff_probability = 25
	faction = "mesa"
	bleed_colour = "#85041a"

	var/zombie_color = "scientist_zombie" //holder for icon set
	var/list/icon_sets = list("scientist_zombie", "security_zombie", "hev_zombie", "hecu_zombie")

/datum/ai_holder/simple_animal/hostile/Xen_zombie/engage_target()
	. = ..()

	var/mob/living/L = .
	if(istype(L))
		if(prob(15))
			L.Weaken(3)
			L.visible_message("<span class='danger'>\the [src] knocks down \the [L]!</span>")

/datum/ai_holder/simple_animal/hostile/Xen_zombie/find_target(list/possible_targets, has_targets_list)
	. = ..()

	if(.)
		holder.custom_emote(1,"nashes at [.]")

/mob/living/simple_animal/hostile/Xen_zombie/Initialize()
	. = ..()
	zombie_randomify()
	update_icon()

/mob/living/simple_animal/hostile/Xen_zombie/proc/zombie_randomify()
	maxHealth = rand(initial(maxHealth), (1.5 * initial(maxHealth)))
	health = maxHealth
	if(prob(1))
		zombie_color = pick("white", "black")
	else
		zombie_color = pick(icon_sets)
	icon_state = "[zombie_color]"
	icon_living = "[zombie_color]"
	icon_dead = "[zombie_color]_dead"

/mob/living/simple_animal/hostile/bullsquid
	name = "bullsquid"
	desc = "Why, just look at those peculiar markings..."
	icon = 'icons/mob/mobs_mesa.dmi'
	icon_state = "bullsquid"
	icon_living = "bullsquid"
	icon_dead = "bullsquid_dead"
	turns_per_move = 3
	speed = 0
	faction = "mesa"
	maxHealth = 30
	health = 30
	natural_weapon = /obj/item/natural_weapon/bite/bullsquid
	mob_size = MOB_SMALL
	meat_amount = 2
	can_escape = TRUE

/obj/item/natural_weapon/bite/bullsquid
	name = "mouth"
	attack_verb = list("mauled")
	hitsound = 'sound/whitemesa/battack.ogg'
	force = 20
	sharp = TRUE


/mob/living/simple_animal/hostile/houndeye
	name = "houndeye"
	desc = "Did you see that thing, with the... the missing leg?"
	icon = 'icons/mob/mobs_mesa.dmi'
	icon_state = "houndeye"
	icon_living = "houndeye"
	icon_dead = "houndeye_dead"
	speed = 2
	maxHealth = 45
	health = 45
	faction = "mesa"
	natural_weapon = /obj/item/natural_weapon/bite/bullsquid
	meat_amount = 2
	can_escape = FALSE

/obj/item/natural_weapon/bite/bullsquid
	name = "sonic attacks"
	attack_verb = list("shock waves")
	hitsound = 'sound/whitemesa/sonicattack.ogg'
	force = 20
	sharp = TRUE

//

/mob/living/simple_animal/hostile/vortigaunt_slave
	name = "vortigaunt"
	desc = "Subservient Alien Beast"
	icon = 'icons/mob/mobs_mesa.dmi'
	icon_state = "vortigaunt_slave"
	icon_living = "vortigaunt_slave"
	icon_dead = "vortigaunt_dead"
	speed = 5
	maxHealth = 40
	health = 40
	faction = "mesa"
	natural_weapon = /obj/item/natural_weapon/vortigaunt
	meat_amount = 0
	projectilesound = 'sound/weapons/laser.ogg'
	ranged = 1
	projectiletype = /obj/item/projectile/beam/vortigaunt

/obj/item/natural_weapon/vortigaunt
	force = 17
	attack_verb = list("slammed")

//projectile

/obj/item/projectile/beam/vortigaunt
	damage = 10
	agony = 10
	armor_penetration = 5

	muzzle_type = /obj/effect/projectile/vortigaunt/muzzle
	tracer_type = /obj/effect/projectile/vortigaunt/tracer
	impact_type = /obj/effect/projectile/vortigaunt/impact

/obj/effect/projectile/mesa/vovortigaunt
	light_color = "#00ff15"
	icon = 'impact.dmi'

/obj/effect/projectile/vortigaunt/tracer
	icon_state = "redstun"

/obj/effect/projectile/vortigaunt/muzzle
	icon_state = "muzzle_redstun"

/obj/effect/projectile/vortigaunt/impact
	icon_state = "impact_redstun"
