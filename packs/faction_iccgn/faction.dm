/datum/mil_branch/iccgn
	name = "Gilgamesh Confederation Navy"
	name_short = "ICCGN"
	email_domain = "navy.gcc"
	assistant_job = null
	min_skill = list(
		SKILL_HAULING = SKILL_BASIC,
		SKILL_WEAPONS = SKILL_BASIC,
		SKILL_EVA = SKILL_BASIC
	)

	rank_types = list(
		/datum/mil_rank/iccgn/e1,
		/datum/mil_rank/iccgn/e2,
		/datum/mil_rank/iccgn/e3,
		/datum/mil_rank/iccgn/e4,
		/datum/mil_rank/iccgn/e5,
		/datum/mil_rank/iccgn/e6,
		/datum/mil_rank/iccgn/e7,
		/datum/mil_rank/iccgn/e8,
		/datum/mil_rank/iccgn/o1,
		/datum/mil_rank/iccgn/o2,
		/datum/mil_rank/iccgn/o3,
		/datum/mil_rank/iccgn/o4,
		/datum/mil_rank/iccgn/o5,
		/datum/mil_rank/iccgn/o6,
		/datum/mil_rank/iccgn/o7,
		/datum/mil_rank/iccgn/o8,
		/datum/mil_rank/iccgn/o9,
		/datum/mil_rank/iccgn/o10,
		/datum/mil_rank/iccgn/o11
	)

	spawn_rank_types = list(
		/datum/mil_rank/iccgn/e1,
		/datum/mil_rank/iccgn/e2,
		/datum/mil_rank/iccgn/e3,
		/datum/mil_rank/iccgn/e4,
		/datum/mil_rank/iccgn/e5,
		/datum/mil_rank/iccgn/e6,
		/datum/mil_rank/iccgn/e7,
		/datum/mil_rank/iccgn/e8,
		/datum/mil_rank/iccgn/o1,
		/datum/mil_rank/iccgn/o2,
		/datum/mil_rank/iccgn/o3,
		/datum/mil_rank/iccgn/o4,
		/datum/mil_rank/iccgn/o5,
	)


/datum/mil_branch/iccgn/New()
	rank_types = subtypesof(/datum/mil_rank/iccgn)
	..()

/datum/mil_rank/iccgn/e1
	name = "Private"
	name_short = "Pvt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted)
	sort_order = 1

/datum/mil_rank/iccgn/e2
	name = "Corporal"
	name_short = "Cpl"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e2)
	sort_order = 2

/datum/mil_rank/iccgn/e3
	name = "Junior Sergeant"
	name_short = "JrSgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e3)
	sort_order = 3

/datum/mil_rank/iccgn/e4
	name = "Sergeant"
	name_short = "Sgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e4)
	sort_order = 4

/datum/mil_rank/iccgn/e5
	name = "Senior Sergeant"
	name_short = "SrSgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e5)
	sort_order = 5

/datum/mil_rank/iccgn/e6
	name = "Staff Sergeant"
	name_short = "SSgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e6)
	sort_order = 6

/datum/mil_rank/iccgn/e7
	name = "Michman"
	name_short = "Mmn"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e7)
	sort_order = 7

/datum/mil_rank/iccgn/e8
	name = "Senior Michman"
	name_short = "SrMmn"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e8)
	sort_order = 8

/datum/mil_rank/iccgn/o1
	name = "Junior Lieutenant"
	name_short = "jrLt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer)
	sort_order = 16

/datum/mil_rank/iccgn/o2
	name = "Lieutenant"
	name_short = "Lt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o2)
	sort_order = 17

/datum/mil_rank/iccgn/o3
	name = "Senior Lieutenant"
	name_short = "SrLt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3)
	sort_order = 18

/datum/mil_rank/iccgn/o4
	name = "Captain-leutnant"
	name_short = "CptLt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o4)
	sort_order = 19

/datum/mil_rank/iccgn/o5
	name = "Captain of the third rank"
	name_short = "Cpt3"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o5)
	sort_order = 20

/datum/mil_rank/iccgn/o6
	name = "Captain of the second rank"
	name_short = "Cpt2"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag)
	sort_order = 21

/datum/mil_rank/iccgn/o7
	name = "Captain of the first rank"
	name_short = "Cpt1"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o7)
	sort_order = 22

/datum/mil_rank/iccgn/o8
	name = "Rear Admiral"
	name_short = "RAdm"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o8)
	sort_order = 23

/datum/mil_rank/iccgn/o9
	name = "Vice Admiral"
	name_short = "VAdm"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o9)
	sort_order = 24

/datum/mil_rank/iccgn/o10
	name = "Admiral"
	name_short = "Adm"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o10)
	sort_order = 25

/datum/mil_rank/iccgn/o11
	name = "Admiral of the Fleet"
	name_short = "FADM"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o10)
	sort_order = 26
