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
		/datum/mil_rank/iccgn/e8_alt,
		/datum/mil_rank/iccgn/e9,
		/datum/mil_rank/iccgn/e9_alt,
		/datum/mil_rank/iccgn/e9_alt2,
		/datum/mil_rank/iccgn/w1,
		/datum/mil_rank/iccgn/w2,
		/datum/mil_rank/iccgn/w3,
		/datum/mil_rank/iccgn/w4,
		/datum/mil_rank/iccgn/w5,
		/datum/mil_rank/iccgn/o1,
		/datum/mil_rank/iccgn/o2,
		/datum/mil_rank/iccgn/o3,
		/datum/mil_rank/iccgn/o4,
		/datum/mil_rank/iccgn/o5,
		/datum/mil_rank/iccgn/o6,
		/datum/mil_rank/iccgn/o7,
		/datum/mil_rank/iccgn/o8,
		/datum/mil_rank/iccgn/o9,
		/datum/mil_rank/iccgn/o10
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
		/datum/mil_rank/iccgn/e8_alt,
		/datum/mil_rank/iccgn/e9,
		/datum/mil_rank/iccgn/e9_alt,
		/datum/mil_rank/iccgn/o1,
		/datum/mil_rank/iccgn/o2,
		/datum/mil_rank/iccgn/o3,
		/datum/mil_rank/iccgn/o4,
		/datum/mil_rank/iccgn/o5,
		/datum/mil_rank/iccgn/o6
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
	name = "Private First Class"
	name_short = "PFC"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e2)
	sort_order = 2

/datum/mil_rank/iccgn/e3
	name = "Lance Corporal"
	name_short = "LCpl"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e3)
	sort_order = 3

/datum/mil_rank/iccgn/e4
	name = "Corporal"
	name_short = "Cpl"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e4)
	sort_order = 4

/datum/mil_rank/iccgn/e5
	name = "Sergeant"
	name_short = "Sgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e5)
	sort_order = 5

/datum/mil_rank/iccgn/e6
	name = "Staff Sergeant"
	name_short = "SSgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e6)
	sort_order = 6

/datum/mil_rank/iccgn/e7
	name = "Gunnery Sergeant"
	name_short = "GySgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e7)
	sort_order = 7

/datum/mil_rank/iccgn/e8
	name = "Master Sergeant"
	name_short = "MSgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e8)
	sort_order = 8

/datum/mil_rank/iccgn/e8_alt
	name = "First Sergeant"
	name_short = "1stSg"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e8_alt)
	sort_order = 8

/datum/mil_rank/iccgn/e9
	name = "Master Gunnery Sergeant"
	name_short = "MGySgt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e9)
	sort_order = 9

/datum/mil_rank/iccgn/e9_alt
	name = "Sergeant Major"
	name_short = "SgtMaj"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e9_alt)
	sort_order = 9

/datum/mil_rank/iccgn/e9_alt2
	name = "Sergeant Major of the Marine Corps"
	name_short = "SMMC"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/enlisted/e9_alt2)
	sort_order = 9

/datum/mil_rank/iccgn/w1
	name = "Warrant Officer"
	name_short = "WO"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w1)
	sort_order = 11

/datum/mil_rank/iccgn/w2
	name = "Second Warrant Officer"
	name_short = "SWO"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w2)
	sort_order = 12

/datum/mil_rank/iccgn/w3
	name = "First Warrant Officer"
	name_short = "FWO"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w3)
	sort_order = 13

/datum/mil_rank/iccgn/w4
	name = "Major Warrant Officer"
	name_short = "MWO"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w4)
	sort_order = 14

/datum/mil_rank/iccgn/w5
	name = "General Warrant Officer"
	name_short = "GWO"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/warrant_officer/w5)
	sort_order = 15

/datum/mil_rank/iccgn/o1
	name = "Second Lieutenant"
	name_short = "2ndLt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer)
	sort_order = 16

/datum/mil_rank/iccgn/o2
	name = "First Lieutenant"
	name_short = "1stLt"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o2)
	sort_order = 17

/datum/mil_rank/iccgn/o3
	name = "Captain"
	name_short = "CPT"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3)
	sort_order = 18

// Specially, to avoid two "Capt" on-board.
/datum/mil_rank/iccgn/o3_alt
	name = "Marine Captain"
	name_short = "M-CPT"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3_alt)
	sort_order = 19

/datum/mil_rank/iccgn/o3_alt2
	name = "Specialist Captain"
	name_short = "SP-CPT"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o3_alt2)
	sort_order = 20

/datum/mil_rank/iccgn/o4
	name = "Major"
	name_short = "Maj"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o4)
	sort_order = 21

/datum/mil_rank/iccgn/o5
	name = "Lieutenant Colonel"
	name_short = "LtCol"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o5)
	sort_order = 22

/datum/mil_rank/iccgn/o6
	name = "Colonel"
	name_short = "Col"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/officer/o6)
	sort_order = 23

/datum/mil_rank/iccgn/o7
	name = "Brigadier General"
	name_short = "BGen"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag)
	sort_order = 24

/datum/mil_rank/iccgn/o8
	name = "Major General"
	name_short = "MGen"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o8)
	sort_order = 25

/datum/mil_rank/iccgn/o9
	name = "Lieutenant General"
	name_short = "LtGen"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o9)
	sort_order = 26

/datum/mil_rank/iccgn/o10
	name = "General"
	name_short = "Gen"
	accessory = list(/obj/item/clothing/accessory/iccgn_rank/marine/flag/o10)
	sort_order = 27
