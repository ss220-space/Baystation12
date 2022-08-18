#define ABOVE_TABLE 1
#define UNDER_TABLE -1
/obj/structure/closet/crate
	name = "crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/closets/crate.dmi'
	icon_state = "crate"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	setup = 0
	storage_types = CLOSET_STORAGE_ITEMS
	var/points_per_crate = 5
	var/rigged = 0
	store_structures = TRUE
	dense_when_open = FALSE
	door_anim_squish = 0.30
	door_anim_time = 3
	door_anim_angle = 140
	door_hinge = 0.5
	var/tablestatus = 0

	var/azimuth_angle_2 = 180 //in this context the azimuth angle for over 90 degree
	var/radius_2 = 1.35
	var/static/list/animation_math //assoc list with pre calculated values


/obj/structure/closet/crate/can_open()
	if(tablestatus == BELOW_TABLE_LAYER)//Can't be opened while under a table
		return 0
	. = ..()

/obj/structure/closet/crate/can_close()
	return 1


/obj/structure/closet/crate/animate_door(var/closing = FALSE)
	if(!door_anim_time)
		return
	if(!door_obj) door_obj = new
	if(animation_math == null) //checks if there is already a list for animation_math if not creates one to avoid runtimes
		animation_math = new/list()
	if(!door_anim_time == 0 && !animation_math["[door_anim_time]-[door_anim_angle]-[azimuth_angle_2]-[radius_2]-[door_hinge]"])
		animation_list()
	vis_contents |= door_obj
	door_obj.icon = icon
	door_obj.icon_state = "[icon_door || icon_state]_door"
	is_animating_door = TRUE
	var/num_steps = door_anim_time / world.tick_lag
	var/list/animation_math_list = animation_math["[door_anim_time]-[door_anim_angle]-[azimuth_angle_2]-[radius_2]-[door_hinge]"]
	for(var/step in 0 to num_steps)
		var/door_state = step == (closing ? num_steps : 0) ? "[icon_door || icon_state]_door" : animation_math_list[closing ? 2 * num_steps - step : num_steps + step] <= 0 ? "[icon_door_override ? icon_door : icon_state]_back" : "[icon_door || icon_state]_door"
		var/door_layer = step == (closing ? num_steps : 0) ? ABOVE_HUMAN_LAYER : animation_math_list[closing ? 2 * num_steps - step : num_steps + step] <= 0 ? FLOAT_LAYER : ABOVE_HUMAN_LAYER
		var/matrix/M = get_door_transform(step == (closing ? num_steps : 0) ? 0 : animation_math_list[closing ? num_steps - step : step], step == (closing ? num_steps : 0) ? 1 : animation_math_list[closing ?  2 * num_steps - step : num_steps + step])
		if(step == 0)
			door_obj.transform = M
			door_obj.icon_state = door_state
			door_obj.layer = door_layer
		else if(step == 1)
			animate(door_obj, transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag, flags = ANIMATION_END_NOW)
		else
			animate(transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag)
	addtimer(CALLBACK(src,.proc/end_door_animation),door_anim_time,TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/closet/crate/get_door_transform(crateanim_1, crateanim_2)
	var/matrix/M = matrix()
	M.Translate(0, -door_hinge)
	M.Multiply(matrix(1, crateanim_1, 0, 0, crateanim_2, 0))
	M.Translate(0, door_hinge)
	return M

/obj/structure/closet/crate/proc/animation_list() //pre calculates a list of values for the crate animation cause byond not like math
	var/num_steps_1 = door_anim_time / world.tick_lag
	var/list/new_animation_math_sublist[num_steps_1 * 2]
	for(var/step in 1 to num_steps_1) //loop to save the animation values into the lists
		var/angle_1 = door_anim_angle * (step / num_steps_1)
		var/polar_angle = abs(arcsin(cos(angle_1)))
		var/azimuth_angle = angle_1 >= 90 ? azimuth_angle_2 : 0
		var/radius_cr = angle_1 >= 90 ? radius_2 : 1
		new_animation_math_sublist[step] = -sin(polar_angle) * sin(azimuth_angle) * radius_cr
		new_animation_math_sublist[num_steps_1 + step] = cos(azimuth_angle) * sin(polar_angle) * radius_cr
	animation_math["[door_anim_time]-[door_anim_angle]-[azimuth_angle_2]-[radius_2]-[door_hinge]"] = new_animation_math_sublist


/obj/structure/closet/crate/secure
	desc = "A secure crate."
	name = "Secure crate"
	icon_state = "secure_crate"
	door_hinge = 0.5
	setup = CLOSET_HAS_LOCK
	locked = TRUE
	secure = TRUE
	broken = FALSE
	secure_lights = TRUE

/obj/structure/closet/crate/secure/Initialize()
	. = ..()
	update_icon()

/obj/structure/closet/crate/plastic
	name = "plastic crate"
	desc = "A rectangular plastic crate."
	points_per_crate = 1
	icon_state = "crateold"

/obj/structure/closet/crate/coffin/Initialize()
	. = ..()
	store_mobs(0)

/obj/structure/closet/crate/coffin
	name = "coffin"
	desc = "It's a burial receptacle for the dearly departed."
	icon_state = "coffin"
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	storage_types = CLOSET_STORAGE_MOBS|CLOSET_STORAGE_ITEMS
	density = FALSE
	dense_when_open = FALSE
	door_anim_angle = 140
	azimuth_angle_2 = 180
	door_anim_time = 5
	door_hinge = 5

/obj/structure/closet/crate/internals
	name = "internals crate"
	desc = "A internals crate."
	icon_state = "o2"
	door_hinge = 0.5

/obj/structure/closet/crate/internals/fuel
	name = "\improper Fuel tank crate"
	desc = "A fuel tank crate."
	icon_state = "crate"

/obj/structure/closet/crate/internals/fuel/WillContain()
	return list(/obj/item/tank/hydrogen = 4)

/obj/structure/closet/crate/trashcart
	name = "trash cart"
	desc = "A heavy, metal trashcart with wheels."
	icon_state = "trashcart"
	door_hinge = 2.5

/obj/structure/closet/crate/medical
	name = "medical crate"
	desc = "A medical crate."
	icon_state = "medical_crate"

/obj/structure/closet/crate/rcd
	name = "\improper RCD crate"
	desc = "A crate with rapid construction device."

/obj/structure/closet/crate/rcd/WillContain()
	return list(
		/obj/item/rcd_ammo = 3,
		/obj/item/rcd
	)

/obj/structure/closet/crate/solar
	name = "solar pack crate"

/obj/structure/closet/crate/solar/WillContain()
	return list(
		/obj/item/solar_assembly = 14,
		/obj/item/stock_parts/circuitboard/solar_control,
		/obj/item/tracker_electronics,
		/obj/item/paper/solar
	)

/obj/structure/closet/crate/solar_assembly
	name = "solar assembly crate"

/obj/structure/closet/crate/solar_assembly/WillContain()
	return list(/obj/item/solar_assembly = 16)

/obj/structure/closet/crate/freezer
	name = "freezer"
	desc = "A freezer."
	temperature = -16 CELSIUS
	icon_state = "freezeralt"
	door_hinge = 0.5
	var/target_temp = T0C - 40
	var/cooling_power = 40

/obj/structure/closet/crate/freezer/return_air()
	var/datum/gas_mixture/gas = (..())
	if(!gas)	return null
	var/datum/gas_mixture/newgas = new/datum/gas_mixture()
	newgas.copy_from(gas)
	if(newgas.temperature <= target_temp)	return

	if((newgas.temperature - cooling_power) > target_temp)
		newgas.temperature -= cooling_power
	else
		newgas.temperature = target_temp
	return newgas

/obj/structure/closet/crate/freezer/ProcessAtomTemperature()
	return PROCESS_KILL

/obj/structure/closet/crate/freezer/rations //For use in the escape shuttle
	name = "emergency rations"
	desc = "A crate of emergency rations."

/obj/structure/closet/crate/freezer/rations/WillContain()
	return list(/obj/random/mre = 6, /obj/item/reagent_containers/food/drinks/cans/waterbottle = 12)

/obj/structure/closet/crate/freezer/meat
	name = "meat crate"
	desc = "A crate of meat."

/obj/structure/closet/crate/freezer/meat/WillContain()
	return list(
		/obj/item/reagent_containers/food/snacks/meat/beef = 4,
		/obj/item/reagent_containers/food/snacks/meat/syntiflesh = 4,
		/obj/item/reagent_containers/food/snacks/fish = 4
	)

/obj/structure/closet/crate/bin
	name = "large bin"
	desc = "A large bin."
	icon_state = "largebin"

/obj/structure/closet/crate/radiation
	name = "radioactive crate"
	desc = "A leadlined crate with a radiation sign on it."
	icon_state = "oldrad"
	door_hinge = 0.5

/obj/structure/closet/crate/radiation_gear
	name = "radioactive gear crate"
	desc = "A crate with a radiation sign on it."
	icon_state = "oldrad"
	door_hinge = 0.5


/obj/structure/closet/crate/radiation_gear/WillContain()
	return list(/obj/item/clothing/suit/radiation = 8)

/obj/structure/closet/crate/secure/weapon
	name = "weapons crate"
	desc = "A secure weapons crate."
	icon_state = "seccrate"
	door_hinge = 0.5

/obj/structure/closet/crate/secure/phoron
	name = "phoron crate"
	desc = "A secure phoron crate."
	icon_state = "phoronold"
	door_hinge = 0.5

/obj/structure/closet/crate/secure/shuttle
	name = "storage compartment"
	desc = "A secure storage compartment bolted to the floor, to secure loose objects on Zero-G flights."
	anchored = TRUE
	icon_state = "drop_crate-grey"
	door_hinge = 0.5

/obj/structure/closet/crate/secure/gear
	name = "gear crate"
	desc = "A secure gear crate."
	icon_state = "seccrate"
	door_hinge = 0.5

/obj/structure/closet/crate/secure/hydrosec
	name = "secure hydroponics crate"
	desc = "A crate with a lock on it, painted in the scheme of botany and botanists."
	icon_state = "botold_secure"
	icon_door_override = TRUE
	icon_door = "botold"
	door_hinge = 0.5

/obj/structure/closet/crate/large
	name = "large crate"
	desc = "A hefty metal crate."
	storage_capacity = 2 * MOB_LARGE
	storage_types = CLOSET_STORAGE_ITEMS|CLOSET_STORAGE_STRUCTURES
	icon_state = "largemetal"
	door_anim_time = 0

/obj/structure/closet/crate/large/hydroponics
	closet_appearance = /decl/closet_appearance/large_crate/hydroponics

/obj/structure/closet/crate/secure/large
	name = "large crate"
	desc = "A hefty metal crate with an electronic locking system."
	icon_state = "largemetal"
	icon_door_overlay = "largemetal"
	door_anim_time = 0
	secure_lights = FALSE

	storage_capacity = 2 * MOB_LARGE
	storage_types = CLOSET_STORAGE_ITEMS|CLOSET_STORAGE_STRUCTURES

/obj/structure/closet/crate/secure/large/phoron
	icon_state = "largemetal"

//fluff variant
/obj/structure/closet/crate/secure/large/reinforced
	desc = "A hefty, reinforced metal crate with an electronic locking system."

/obj/structure/closet/crate/hydroponics
	name = "hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon_state = "botold"
	door_hinge = 0.5

/obj/structure/closet/crate/hydroponics/prespawned/WillContain()
	return list(
		/obj/item/reagent_containers/spray/plantbgone = 2,
		/obj/item/material/minihoe = 2,
		/obj/item/storage/plants = 2,
		/obj/item/material/hatchet = 2,
		/obj/item/wirecutters/clippers = 2,
		/obj/item/device/scanner/plant = 2
	)

/obj/structure/closet/crate/secure/biohazard
	name = "biohazard crate"
	desc = "A heavy crate with extensive sealing. You shouldn't eat things you find in it."
	open_sound = 'sound/items/Deconstruct.ogg'
	close_sound = 'sound/items/Deconstruct.ogg'
	req_access = list(access_xenobiology)
	icon_state = "heph_crate"
	door_hinge = 0.5
	storage_capacity = 2 * MOB_LARGE
	storage_types = CLOSET_STORAGE_ITEMS|CLOSET_STORAGE_MOBS|CLOSET_STORAGE_STRUCTURES

/obj/structure/closet/crate/secure/biohazard/blanks/WillContain()
	return list(/obj/structure/closet/body_bag/cryobag/blank)

/obj/structure/closet/crate/secure/biohazard/blanks/can_close()
	for(var/obj/structure/closet/closet in get_turf(src))
		if(closet != src && !(istype(closet, /obj/structure/closet/body_bag/cryobag)))
			return 0
	return 1

/obj/structure/closet/crate/secure/biohazard/alt
	name = "biowaste disposal crate"
	desc = "A heavy crate used for organ disposal with markings indicating the things inside are probably gross."
	req_access = list(access_surgery)
	closet_appearance = /decl/closet_appearance/cart/biohazard/alt

/obj/structure/closet/crate/paper_refill
	name = "paper refill crate"
	desc = "A rectangular plastic crate, filled up with blank papers for refilling bins and printers. A bureaucrat's favorite."

/obj/structure/closet/crate/paper_refill/WillContain()
	return list(/obj/item/paper = 30)

/obj/structure/closet/crate/uranium
	name = "fissibles crate"
	desc = "A crate with a radiation sign on it."
	icon_state = "oldrad"
	door_hinge = 0.5


/obj/structure/closet/crate/uranium/WillContain()
	return list(/obj/item/stack/material/uranium/ten = 5)
