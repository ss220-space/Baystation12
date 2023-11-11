/datum/gear/suit/medcoat
	allowed_roles = MEDICAL_ROLES

/datum/gear/suit/poncho
	display_name = "poncho selection"
	path = /obj/item/clothing/suit/poncho/colored

/datum/gear/suit/security_poncho
	allowed_roles = list(/datum/job/hos, /datum/job/warden, /datum/job/detective, /datum/job/officer, /datum/job/submap/merchant, /datum/job/submap/merchant_trainee)

/datum/gear/suit/medical_poncho
	allowed_roles = list(/datum/job/cmo, /datum/job/senior_doctor, /datum/job/doctor, /datum/job/doctor_trainee, /datum/job/explorer_medic, /datum/job/psychiatrist, /datum/job/chemist, /datum/job/roboticist, /datum/job/submap/merchant, /datum/job/submap/merchant_trainee)

/datum/gear/suit/engineering_poncho
	allowed_roles = list(/datum/job/chief_engineer, /datum/job/senior_engineer, /datum/job/engineer, /datum/job/roboticist, /datum/job/engineer_trainee, /datum/job/explorer_engineer, /datum/job/submap/merchant, /datum/job/submap/merchant_trainee, /datum/job/infsys)

/datum/gear/suit/science_poncho
	allowed_roles = list(/datum/job/rd, /datum/job/scientist, /datum/job/scientist_assistant, /datum/job/senior_scientist, /datum/job/roboticist, /datum/job/submap/merchant, /datum/job/submap/merchant_trainee)

/datum/gear/suit/cargo_poncho
	allowed_roles = list(/datum/job/qm, /datum/job/cargo_tech, /datum/job/cargo_assistant, /datum/job/submap/merchant, /datum/job/submap/merchant_trainee)

/datum/gear/suit/wintercoat/engineering
	display_name = "expeditionary winter coat"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/solgov
	allowed_roles = EXPLORATION_ROLES

/datum/gear/suit/wintercoat/engineering
	display_name = "engineering winter coat"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/engineering
	allowed_roles = ENGINEERING_ROLES

/datum/gear/suit/wintercoat/cargo
	display_name = "cargo winter coat"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/cargo
	allowed_roles = SUPPLY_ROLES

/datum/gear/suit/wintercoat/medical
	display_name = "medical winter coat"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/medical
	allowed_roles = MEDICAL_ROLES

/datum/gear/suit/wintercoat/security
	display_name = "security winter coat"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/security
	allowed_roles = SECURITY_ROLES

/datum/gear/suit/wintercoat/research
	display_name = "science winter coat"
	path = /obj/item/clothing/suit/storage/hooded/wintercoat/science
	allowed_roles = list(/datum/job/rd, /datum/job/scientist, /datum/job/scientist_assistant, /datum/job/senior_scientist, /datum/job/roboticist, /datum/job/submap/merchant, /datum/job/submap/merchant_trainee)

/datum/gear/suit/wintercoat/dais
	display_name = "DAIS winter coat"
	allowed_roles = list(/datum/job/engineer, /datum/job/scientist, /datum/job/roboticist, /datum/job/infsys)
	allowed_branches = list(/datum/mil_branch/contractor)

/datum/gear/suit/labcoat
	allowed_roles = STERILE_ROLES

/datum/gear/suit/labcoat_corp_si
	display_name = "labcoat, NT or Hephaestus"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/science
	allowed_roles = RESEARCH_ROLES
	allowed_branches = list(/datum/mil_branch/employee, /datum/mil_branch/contractor)

/datum/gear/suit/labcoat_corp_si/New()
	..()
	var/labcoatsi = list()
	labcoatsi += /obj/item/clothing/suit/storage/toggle/labcoat/science/nanotrasen
	labcoatsi += /obj/item/clothing/suit/storage/toggle/labcoat/science/heph
	gear_tweaks += new/datum/gear_tweak/path/specified_types_list(labcoatsi)

/datum/gear/suit/labcoat_dais
	display_name = "labcoat, DAIS"
	path = /obj/item/clothing/suit/storage/toggle/labcoat/science/dais
	allowed_roles = list(/datum/job/engineer, /datum/job/scientist, /datum/job/roboticist, /datum/job/infsys)
	allowed_branches = list(/datum/mil_branch/contractor)

/datum/gear/suit/militaryjacket
	display_name = "military jacket"
	path = /obj/item/clothing/suit/storage/tgbomber/militaryjacket

/datum/gear/suit/sec_jacket
	allowed_roles = list(/datum/job/hos, /datum/job/warden, /datum/job/detective, /datum/job/officer, /datum/job/submap/merchant, /datum/job/submap/merchant_trainee)

/datum/gear/suit/snakeskin
	display_name = "snakeskin coat"
	path = /obj/item/clothing/suit/snakeskin

//Custom shit from Leroy
/datum/gear/suit/storage/shortcoat
	display_name = "shortcoat"
	path = /obj/item/clothing/suit/storage/shortcoat

/datum/gear/suit/storage/toggle/bomber/navy
	display_name = "navy bomber jacket"
	path = /obj/item/clothing/suit/storage/toggle/bomber/navy
/datum/gear/suit/storage/greatcoat
	display_name = "sleek greatcoat"
	path = /obj/item/clothing/suit/storage/greatcoat
/datum/gear/suit/storage/denim
	display_name = "denim jacket"
	path = /obj/item/clothing/suit/storage/denim
/datum/gear/suit/storage/denim/gray
	display_name = "gray denim jacket"
	path = /obj/item/clothing/suit/storage/denim/gray

/datum/gear/suit/crop_sweater_selection
	display_name = "crop sweater selection"
	path = /obj/item/clothing/suit/crop_sweater

/datum/gear/suit/crop_sweater_selection/New()
	..()
	var/crop_sweater_selection_type = list()
	crop_sweater_selection_typee["black crop sweater with red stripes"] = /obj/item/clothing/suit/crop_sweater/black_with_red
	crop_sweater_selection_type["black crop sweater with yellow stripes"] = /obj/item/clothing/suit/storage/crop_sweater/black_with_yellow
	crop_sweater_selection_type["white crop sweater with white stripes"] = /obj/item/clothing/suit/storage/crop_sweater/white_with_blue
	gear_tweaks += new/datum/gear_tweak/path(crop_sweater_selection_type)
/datum/gear/suit/crystaljock
	display_name = "crystaljock bobmer"
	path =/obj/item/clothing/suit/crystaljock

/datum/gear/suit/sturage/hooded/anorak/khaki
	display_name = "khaki anorak"
	path = /obj/item/clothing/suit/storage/hooded/anorak/khaki

/datum/gear/suit/storage/hooded/anorak/desert
	path = /obj/item/clothing/suit/storage/hooded/anorak/desert
	display_name = "desert anorak"
/datum/gear/suit/rugby_selection
	display_name = "rugby selection"
	path = /obj/item/clothing/suit/rugby

/datum/gear/suit/rugby_selection/New()
	..()
	var/rugby_selection_type = list()
	rugby_selection_type["red rugby"] = /obj/item/clothing/suit/storage/rugby/red
	rugby_selection_type["black rugby"] = /obj/item/clothing/suit/storage/rugby/black
	rugby_selection_type["blue rugby"] = /obj/item/clothing/suit/storage/rugby/blue
	rugby_selectionn_type["brown rugby"] = /obj/item/clothing/suit/storage/rugby/brown
	gear_tweaks += new/datum/gear_tweak/path(rugby_selectionn_type)

/datum/gear/suit/storage/engi_jacket
	display_name = "hazard jacket"
	path = /obj/item/clothing/suit/storage/engi_jacket

/datum/gear/suit/storage/cargo_jacket
	display_name = "lanor jacket"
	path = /obj/item/clothing/suit/storage/cargo_jacket

/datum/gear/suit/storage/amizov
	display_name = "striped pullover"
	path = /obj/item/clothing/suit/amizov

/datum/gear/suit/storage/grimbomber
	display_name = "black bomber"
	path = /obj/item/clothing/suit/storage/grimbomber

/datum/gear/suit/storage/neo_blaser
	display_name = "neokitsch blaser"
	path = /obj/item/clothing/suit/color/storage/neo_blaser
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/storage/neo_blaser_female
	display_name = "female neokitsch blaser"
	path = /obj/item/clothing/suit/color/storage/neo_blaser_female
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/storage/neo_jacket
	display_name = "neokitsch jacket"
	path = /obj/item/clothing/suit/color/storage/neo_jacket
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/strage/neo_jacket_female
	display_name = "female neokitsch jacket"
	path = /obj/item/clothing/suit/color/storage/neo_jacket_female
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/suit/freefit_shirt_selection
	display_name = "freefit shirt selection"
	path = /obj/item/clothing/suit/freefit_shirt

/datum/gear/suit/freefit_shirt_selection/New()
	..()
	var/freefit_selection_type = list()
	freefit_selection_type["light blue freefit shirt"] = /obj/item/clothing/suit/freefit_shirt/one
	freefit_selection_type["black freefit shirt"] = /obj/item/clothing/suit/freefit_shirt/two
	freefit_selection_type["green freefit shirt"] = /obj/item/clothing/suit/freefit_shirt/three
	gear_tweaks += new/datum/gear_tweak/path(freefit_selection_type)

/datum/gear/suit/storage/biker_jacket
	path = /obj/item/clothing/suit/storage/toggle/inf/biker_jacket
	display_name = "biker jacket"
