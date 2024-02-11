// These are basically USB data sticks and may be used to transfer files between devices
/obj/item/stock_parts/computer/hard_drive/portable/
	name = "basic data crystal"
	desc = "Small crystal with imprinted photonic circuits that can be used to store data. Its capacity is 16 GQ."
	power_usage = 10
	icon_state = "flashdrive_basic"
	hardware_size = 1
	max_capacity = 16
	origin_tech = list(TECH_DATA = 1)
	exonets_ipc_computer_suitable = TRUE

/obj/item/stock_parts/computer/hard_drive/portable/advanced
	name = "advanced data crystal"
	desc = "Small crystal with imprinted high-density photonic circuits that can be used to store data. Its capacity is 64 GQ."
	power_usage = 20
	icon_state = "flashdrive_advanced"
	hardware_size = 1
	max_capacity = 64
	origin_tech = list(TECH_DATA = 2)

/obj/item/stock_parts/computer/hard_drive/portable/super
	name = "super data crystal"
	desc = "Small crystal with imprinted ultra-density photonic circuits that can be used to store data. Its capacity is 256 GQ."
	power_usage = 40
	icon_state = "flashdrive_super"
	hardware_size = 1
	max_capacity = 256
	origin_tech = list(TECH_DATA = 4)

/obj/item/stock_parts/computer/hard_drive/portable/New()
	..()
	stored_files = list()
	recalculate_size()

// For idiot merchants who wipe the program from their console.
/obj/item/stock_parts/computer/hard_drive/portable/merchant
	name = "merchant_list_1155_CRACKZ_1155_no_keygen_repack"
	desc = "An obviously pirated copy of well-known trading software."

/obj/item/stock_parts/computer/hard_drive/portable/merchant/Initialize()
	. = ..()
	store_file(new/datum/computer_file/program/merchant(src))

/obj/item/stock_parts/computer/hard_drive/portable/attack(var/mob/living/carbon/human/H, var/mob/living/user, target_zone, animate = TRUE)
	if(H.is_species(SPECIES_IPC) && ishuman(user) && (user.zone_sel.selecting == BP_MOUTH || user.zone_sel.selecting == BP_HEAD))
		var/obj/item/organ/internal/ecs/T = H.internal_organs_by_name[BP_EXONET]
		T.computer.try_install_component(user, src)
