//added by cael from old bs12
//not sure if there's an immediate place for secure wall lockers, but i'm sure the players will think of something

/obj/structure/closet/walllocker
	name = "Wall Locker"
	desc = "A wall mounted storage locker."
	icon = 'icons/obj/closets/walllocker.dmi'
	icon_state = "walllocker" //..how OLD is this $#!?
	door_anim_angle = 132
	door_anim_squish = 0.38
	door_hinge = -7
	door_anim_time = 2.7
	density = FALSE
	anchored = TRUE
	wall_mounted = TRUE
	storage_types = CLOSET_STORAGE_ITEMS
	setup = FALSE
	wall_mounted = TRUE

//spawns endless (3 sets) amounts of breathmask, emergency oxy tank and crowbar

/obj/structure/closet/walllocker/emerglocker
	name = "emergency locker"
	desc = "A wall mounted locker with emergency supplies."
	var/list/spawnitems = list(/obj/item/tank/emergency/oxygen,/obj/item/clothing/mask/breath)
	var/amount = 2 // spawns each items X times.
	icon_state = "emerg"
	door_anim_time = 0

/obj/structure/closet/walllocker/emerglocker/toggle(mob/user as mob)
	src.attack_hand(user)
	return

/obj/structure/closet/walllocker/emerglocker/attackby(obj/item/W as obj, mob/user as mob)
	return

/obj/structure/closet/walllocker/emerglocker/attack_hand(mob/user as mob)
	if (istype(user, /mob/living/silicon/ai))	//Added by Strumpetplaya - AI shouldn't be able to
		return									//activate emergency lockers.  This fixes that.  (Does this make sense, the AI can't call attack_hand, can it? --Mloc)
	if(!amount)
		to_chat(usr, "<spawn class='notice'>It's empty..")
		return
	if(amount)
		to_chat(usr, "<spawn class='notice'>You take out some items from \the [src].")
		for(var/path in spawnitems)
			new path(src.loc)
		amount--
	return

/obj/structure/closet/walllocker/emerglocker/north
	pixel_y = 32
	dir = SOUTH

/obj/structure/closet/walllocker/emerglocker/south
	pixel_y = -32
	dir = NORTH

/obj/structure/closet/walllocker/emerglocker/west
	pixel_x = -32
	dir = WEST

/obj/structure/closet/walllocker/emerglocker/east
	pixel_x = 32
	dir = EAST

/obj/structure/closet/walllocker/firecloset //wall mounted fire closet
	name = "fire-safety closet"
	desc = "It's a storage unit for fire-fighting supplies."
	icon_state = "hydrant"

/obj/structure/closet/walllocker/morgue
	name = "Wall Locker"
	desc = "A wall mounted morgue storage locker."
	icon_state = "morgue_wall"

/obj/structure/closet/walllocker/firecloset/WillContain()
	return list(
		/obj/item/inflatable/door = 2,
		/obj/item/storage/med_pouch/burn = 2,
		/obj/item/clothing/mask/gas/half,
		/obj/item/storage/backpack/dufflebag/firefighter
		)

/obj/structure/closet/walllocker/firecloset/medical/WillContain()
	return list(
		/obj/random/firstaid,
		/obj/random/medical/lite = 12)


/obj/structure/closet/walllocker/medical //wall mounted medical closet
	name = "first-aid closet"
	desc = "It's wall-mounted storage unit for first aid supplies."
	icon_state = "medical_wall"

/obj/structure/closet/walllocker/medical/filled/WillContain()
	return list(
		/obj/random/firstaid,
		/obj/random/medical/lite = 12)

/obj/structure/closet/secure_closet/lawyer
	name = "internal affairs secure closet"
	req_access = list(access_lawyer)

/obj/structure/closet/secure_closet/walllocker/secure/lawyer/WillContain()
	return list(
		/obj/item/device/flash = 2,
		/obj/item/device/camera = 2,
		/obj/item/device/camera_film = 2,
		/obj/item/device/taperecorder = 2,
		/obj/item/storage/secure/briefcase = 2,
	)
