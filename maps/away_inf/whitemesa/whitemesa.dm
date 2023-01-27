//#include "whitemesa_areas.dm"

/obj/effect/overmap/visitable/sector/whitemesa
	scanner_name = "Ciphered signal"
	scanner_desc = @{"[i]Stellar Body[/i]: Planet
[i]Class[/i]: L-Class Planetoid
[i]Habitability[/i]: Moderate (Medium Temperature)
[b]Notice[/b]: Sensor array detects an deserted planet. There is encrypted NanoTrasen signal coming from it's surface. Scans further indicate EMI fields below the planet's surface and strange anomaly activity."}
	sector_flags = 0
	color = "#830b0b"
	icon_state = "globe"
	start_x = 20
	start_y = 20
	initial_generic_waypoints = list(
		"mesashuttle_port_dock",
		"nav_mesashuttle_start",
		"nav_mesa_dock"
	)

/obj/effect/overmap/visitable/sector/whitemesa/New(nloc, max_x, max_y)
	name = "[generate_planet_name()], \a [name]"
	..()

/datum/map_template/ruin/away_site/whitemesa
	name = "White Mesa"
	id = "awaysite_mesa"
	description = "Half Life inspired underground base"
	spawn_cost = 1
	spawn_weight = 1
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
	name = "Mesa Shuttle"
	icon_state = "yellow"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED
	req_access = list()

/obj/effect/shuttle_landmark/mesashuttle/start
	name = "Mesa Shuttle Dock"
	landmark_tag = "nav_mesashuttle_start"
	docking_controller = "mesashuttle_port_dock"
	base_area = /area/ship/farfleet/command/snz_exterior_dock
	base_turf = /turf/unsimulated/floor/reinforced

/datum/shuttle/autodock/overmap/mesashuttle
	name = "mesashuttle"
	warmup_time = 5
	current_location = "nav_mesashuttle_start"
	range = 2
	dock_target = "nav_mesa_dock"
	shuttle_area = list(/area/white_mesa/mesashuttle)
	defer_initialisation = TRUE
	flags = SHUTTLE_FLAGS_PROCESS
	skill_needed = SKILL_BASIC
	ceiling_type = /turf/simulated/floor/shuttle_ceiling

/obj/effect/shuttle_landmark/mesashuttle/dock
	name = "NSV Sierra Dock"
	landmark_tag = "nav_mesa_dock"
	docking_controller = "rescue_shuttle_dock_airlock"

	//////////
	//TURFS///
	/////////

/turf/simulated/floor/exoplanet/lava_mesa
	name = "Green Acid"
	icon = 'maps/away_inf/whitemesa/acid.dmi'
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
	icon = 'maps/away_inf/whitemesa/acid.dmi'
	icon_state = "riverwater_motion"
	temperature = 293
	color = "#33ff00"

/turf/unsimulated/floor/away_inf/whitemesa/Zen_acid/Initialize()
	.=..()

	set_light(0.7, 1, 5, l_color = "#3cff00")

/turf/unsimulated/floor/away_inf/whitemesa/Zen_floor
	name = "Alien floor"
	desc = "Am I really here?"
	icon = 'maps/away_inf/whitemesa/xen_turfs.dmi'
	icon_state = "xen_turf"
	temperature = 293
	color = "#af6324"

/turf/unsimulated/wall/away_inf/whitemesa/Zen
	name = "alien wall"
	desc = "You feel a sense of dread from just looking at this wall. Its surface seems to be constantly moving, as if it were breathing."
	icon = 'maps/away_inf/whitemesa/riverturfs.dmi'
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
	base_attack_cooldown = 23
	can_escape = TRUE
	projectilesound = 'sound/whitemesa/splat1.ogg'
	ranged = 1
	projectiletype = /obj/item/projectile/squidvenom


/obj/item/natural_weapon/bite/bullsquid
	name = "mouth"
	attack_verb = list("mauled")
	hitsound = 'sound/whitemesa/battack.ogg'
	force = 20
	sharp = TRUE
	armor_penetration = 2

/obj/item/projectile/squidvenom
	damage = 10
	damage_type = BURN
	agony = 10
	armor_penetration = 5
	color = "#9fdf09"
	light_color = "#b3ff00"
	light_max_bright	= 0.4
	light_inner_range	= 2
	light_outer_range	= 3
	icon_state = "toxin"



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
	natural_weapon = /obj/item/natural_weapon/bite/houndeye
	meat_amount = 2
	can_escape = FALSE

/obj/item/natural_weapon/bite/houndeye
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
	can_escape = TRUE
	base_attack_cooldown = 20
	projectilesound = 'sound/whitemesa/attack_shoot1.ogg'
	ranged = 1
	projectiletype = /obj/item/projectile/beam/vortigaunt

/obj/item/natural_weapon/vortigaunt
	force = 17
	attack_verb = list("slammed")

//projectile

/obj/item/projectile/beam/vortigaunt
	name = "Green energy beam"
	damage = 20
	agony = 10
	armor_penetration = 5

	muzzle_type = /obj/effect/projectile/vortigaunt/muzzle
	tracer_type = /obj/effect/projectile/vortigaunt/tracer
	impact_type = /obj/effect/projectile/vortigaunt/impact

/obj/effect/projectile/vortigaunt
	icon = 'maps/away_inf/whitemesa/Impact.dmi'
	color = "#00ff15"
	light_color = "#00ff15"
	light_max_bright	= 0.4
	light_inner_range	= 2
	light_outer_range	= 3

/obj/effect/projectile/vortigaunt/tracer
	icon_state = "redstun"

/obj/effect/projectile/vortigaunt/muzzle
	icon_state = "muzzle_redstun"

/obj/effect/projectile/vortigaunt/impact
	icon_state = "impact_redstun"

//OBJECTS AND EFFECTS//

/obj/machinery/artifact/gg3883
	name = "Yellow crystal"
	desc = "This is a strange alien crystal. It looks heavy, fragile and emits weak light"
	icon = 'maps/away_inf/whitemesa/gg-3883.dmi'
	icon_state = "CrystalGG"
	my_effect = null
	icon_num = 12

/obj/structure/decor/antimassspectrometer
	name = "Anti-Mass Spectrometer"
	desc = "This is a giant science devise. There is a crystall in the "
	icon = 'maps/away_inf/whitemesa/Spectrometer.dmi'
	icon_state = "Spectrometer"
	anchored = TRUE
	pixel_x = -32

/obj/structure/decor/antimassspectrometer/effect0
	name = "Tear in reality"
	desc = ""
	icon = 'maps/away_inf/whitemesa/Portals.dmi'
	icon_state = "portal"
	anchored = TRUE
	color = "#1ac41a"

/obj/structure/decor/antimassspectrometer/effect1
	name = "Energy Beam"
	desc = ""
	icon = 'maps/away_inf/whitemesa/beam.dmi'
	icon_state = "sm_arc_supercharged"
	anchored = TRUE
	color = "#dad60e"

/obj/structure/decor/antimassspectrometer/effect2
	name = "Energy net"
	desc = ""
	icon = 'maps/away_inf/whitemesa/beam.dmi'
	icon_state = "red_lightning"
	anchored = TRUE
	color = "#0eda29"

/obj/structure/decor/antimassspectrometer/effect3
	name = "Something is wrong"
	desc = ""
	icon = 'maps/away_inf/whitemesa/cme_effect.dmi'
	icon_state = "cme_effect"
	anchored = TRUE
	color = "#0eda29"

/obj/structure/decor/bluespacedriveeffect
	name = "Stability Core"
	desc = ""
	icon = 'maps/away_inf/whitemesa/bluespacedrive.dmi'
	icon_state = "bsd_c_1"
	anchored = TRUE

//XEN PORTAL FOR HOSTILE MOBS//

/obj/effect/xenportal
	name = "Xenportal"
	desc = "Small tear to another universe."
	icon = 'maps/away_inf/whitemesa/Portals.dmi'
	icon_state = "portal"
	color = "#0eda29"
	density = TRUE
	unacidable = TRUE
	anchored = TRUE
	var/spawnable = null
	var/activation_sound = 'sound/whitemesa/portalsound.ogg'
	var/activation_messages = list(
		"lets loose a thousand agonized screams as it forces reality around it to bleed and distort!",
		"cracks and blisters!",
		"emits a pained, groan as it disfigures reality!"
	)

/obj/effect/xenportal/active
	light_outer_range=5
	light_color="#09fd15"
	light_max_bright	= 0.5
	light_inner_range	= 2
	light_outer_range	= 5
	spawnable=list(
		/mob/living/simple_animal/hostile/Xen_zombie,
		/mob/living/simple_animal/hostile/Headcrab,
		/mob/living/simple_animal/hostile/bullsquid,
		/mob/living/simple_animal/hostile/houndeye,
		/mob/living/simple_animal/hostile/vortigaunt_slave
	)

/obj/effect/xenportal/active/New()
	..()
	addtimer(CALLBACK(src, .proc/create_and_delete), 5 SECONDS)
	playsound(src, activation_sound, 100)

/obj/effect/xenportal/active/proc/create_and_delete()
	var/t = pick(spawnable)
	new t(src.loc)
	qdel(src)

/////////////////CRYSTALS///////////////////////////////////////////

/obj/structure/xen_crystal
	name = "Alien crystal"
	desc = "Glowing crystal. Looks like you can take some parts of it. "
	icon = 'maps/away_inf/whitemesa/plants.dmi'
	icon_state = "crystal"
	light_inner_range = 0.5
	light_outer_range = 4
	light_max_bright = 0.5
	light_color = "#b1a007"
	density = FALSE
	anchored = TRUE
	/// Have we been harvested?
	var/harvested = FALSE

/obj/structure/xen_crystal/Initialize(mapload)
	. = ..()
	var/color_to_set = pick(COLOR_GOLD, COLOR_BLUE, COLOR_RED, LIGHT_COLOR_ORANGE, LIGHT_COLOR_BLUE, LIGHT_COLOR_GREEN)
	color = color_to_set
	light_color = color_to_set

/obj/structure/xen_crystal/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(harvested)
		to_chat(user, "[src] has already been harvested!")
		return
	to_chat(user, "You start harvesting [src]!")
	if(do_after(user, 5 SECONDS, src))
		harvest(user)

/obj/structure/xen_crystal/proc/harvest(mob/living/user)
	if(harvested)
		return
	to_chat(user, "You harvest [src]!")
	var/obj/item/xen_crystal/nade = new (get_turf(src))
	nade.color = color
	harvested = TRUE
	icon_state = "crystal_harvested"

/obj/item/xen_crystal
	name = "Alien crystal"
	desc = "Small piece of an alien glowing crystal"
	icon = 'maps/away_inf/whitemesa/plants.dmi'
	icon_state = "crystal_grenade"
	w_class = ITEM_SIZE_TINY
	light_inner_range = 0.5
	light_outer_range = 2
	light_max_bright = 0.5
	light_color = "#d3d014"

/obj/structure/headcrabnest
	name = "Nasty nest"
	desc = ""
	icon = 'icons/mob/mob_headcrab.dmi'
	icon_state = "headcrab_nest"
	density = TRUE
	anchored = TRUE

/obj/effect/blob/ravaging/xen/xentree
	name = "Strange tree"
	desc = "Looks like it alive!"
	icon = 'maps/away_inf/whitemesa/zen_flora.dmi'
	icon_state = "zen_angrytree"

/obj/effect/blob/ravaging/xen
	name = "Vine mass"
	desc = "A mass of interwoven tendrils. They thrash around haphazardly at anything in reach."
	maxHealth = 20
	damage_min = 27
	damage_max = 36
	attack_freq = 3
	light_color = BLOB_COLOR_RAV
	color = "#db5a03" //Temporary, for until they get a new sprite.

	/obj/effect/blob/shield/xen
	name = "Strong vine mass"
	desc = "A pulsating mass of interwoven tendrils. These seem particularly robust, but not quite as active."
	icon_state = "blob_idle"
	maxHealth = 120
	damage_min = 13
	damage_max = 25
	attack_freq = 7
	regen_rate = 4
	expandType = /obj/effect/blob/ravaging
	light_color = BLOB_COLOR_SHIELD
	color = "#963c00"

///WEEEDS///

/obj/structure/xenfloorweeds
	name = "xen weeds"
	desc = "A thick vine-like surface covers the floor."
	color = "#c4230d"
	icon = 'maps/away_inf/whitemesa/xen_weeds.dmi'
	icon_state = "Hvy1"


/obj/structure/xenfloorweeds/Initialize()
	.=..()

	if(prob(80))
		icon_state = "Hvy[rand(1,9)]"

///PUDDLE///

/obj/structure/healingpuddle
	name = "Small puddle"
	desc = "Even when you look on it, you already feel better."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-splash"
	color = "#71ffff"
	anchored = TRUE
	light_inner_range = 0.5
	light_outer_range = 4
	light_max_bright = 0.5
	light_color = "#71ffff"
	/// How much do we heal the current person?
	var/heal_amount = 2

/obj/structure/healingpuddle/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/healingpuddle/Process()
	for(var/mob/living/iterating_mob in loc)
		iterating_mob.heal_overall_damage(2, 2)
		playsound(src, 'sound/whitemesa/healingpuddle.ogg', 3, 0, 0, 0.8)


///////////////////////////////////////////////////////////////////////
