/datum/gear/uniform/utility
	display_name = "utility uniform"
	path = /obj/item/clothing/under/solgov/utility

/datum/gear/uniform/roboticist_skirt
	allowed_roles = list(/datum/job/roboticist)

/datum/gear/uniform/sterile
	allowed_roles = STERILE_ROLES

/datum/gear/uniform/hazard
	allowed_roles = TECHNICAL_ROLES

/datum/gear/uniform/pmc/allowed_branches = list(/datum/mil_branch/contractor)

/datum/gear/uniform/corpsi
	display_name = "contractor uniform selection"
	allowed_branches = list(/datum/mil_branch/contractor)

/datum/gear/uniform/si_guard
	display_name = "NanoTrasen guard uniform"
	path = /obj/item/clothing/under/rank/guard/nanotrasen
	allowed_roles = list(/datum/job/officer)

/datum/gear/uniform/si_exec
	display_name = "NanoTrasen senior researcher alt uniform"
	path = /obj/item/clothing/under/rank/scientist/executive
	allowed_roles = list(/datum/job/senior_scientist)

/datum/gear/uniform/si_overalls
	display_name = "corporate coveralls"
	path = /obj/item/clothing/under/rank/ntwork
	allowed_branches = list(/datum/mil_branch/employee, /datum/mil_branch/contractor)

/datum/gear/uniform/si_overalls/New()
	..()
	var/overalls = list()
	overalls["NT beige and red coveralls"]			= /obj/item/clothing/under/rank/ntwork/nanotrasen
	overalls["Hephaestus grey and cyan coveralls"]	= /obj/item/clothing/under/rank/ntwork/heph
	gear_tweaks += new/datum/gear_tweak/path(overalls)

/datum/gear/uniform/si_flight
	display_name = "corporate pilot suit"
	path = /obj/item/clothing/under/rank/ntpilot
	allowed_branches = list(/datum/mil_branch/employee, /datum/mil_branch/contractor)

/datum/gear/uniform/si_flight/New()
	..()
	var/flight = list()
	flight["NT red flight suit"]			= /obj/item/clothing/under/rank/ntpilot/nanotrasen
	flight["Hephaestus cyan flight suit"]	= /obj/item/clothing/under/rank/ntpilot/heph
	gear_tweaks += new/datum/gear_tweak/path(flight)

/datum/gear/uniform/si_exec_jacket
	display_name = "NanoTrasen liason suit"
	path = /obj/item/clothing/under/suit_jacket/corp/nanotrasen
	allowed_roles = list(/datum/job/iaa)

/datum/gear/uniform/formal_shirt_and_pants
	display_name = "formal shirts with pants"
	path = /obj/item/clothing/under/suit_jacket


/datum/gear/uniform/formal_shirt_and_pants/New()
	..()
	var/list/shirts = list()
	shirts += /obj/item/clothing/under/suit_jacket/charcoal/no_accessories
	shirts += /obj/item/clothing/under/suit_jacket/navy/no_accessories
	shirts += /obj/item/clothing/under/suit_jacket/burgundy/no_accessories
	shirts += /obj/item/clothing/under/suit_jacket/checkered/no_accessories
	gear_tweaks += new/datum/gear_tweak/path/specified_types_list(shirts)
//New Leroy Stuff
/datum/gear/uniform/cherry
	display_name = "cherry suit"
	path = /obj/item/clothing/under/cherry

/datum/gear/uniform/cherry
	display_name = "female cherry suit"
	path = /obj/item/clothing/under/cherry_female
/datum/gear/uniform/neo_pants/
	display_name = "cargo trousers"
	path = /obj/item/clothing/under/neo_pants/trousers

/datum/gear/uniform/neo_pants/cargos
	display_name = "cargo pants"
	path = /obj/item/clothing/under/neo_pants/cargos

/datum/gear/uniform/neo_pants/neotac
	display_name = "neotac pants"
	path = /obj/item/clothing/under/neo_pants/neotac

/datum/gear/uniform/neo_pants/breeches
	display_name = "denim breeches"
	path = /obj/item/clothing/under/neo_pants/breeches

/datum/gear/uniform/netrunner
	display_name = "specialized netrunner suit"
	path = /obj/item/clothing/under/netrunner

/datum/gear/uniform/plain
	display_name = "plain suit"
	path = /obj/item/clothing/under/plain

/datum/gear/uniform/plaint/dark
	display_name = "dark plain suit"

/datum/gear/uniform/kitsch_dress
	display_name = "kitsch dress"
	path = /obj/item/clothing/under/kitsch_dress

/datum/gear/unfirom/kitsch_dress/one
	display_name = "Second type kitsch dress"
	path = /obj/item/clothing/under/kitsch_dress/one


/datum/gear/uniform/kitsch_dress/two
	display_name = "three type kitsch dress"
	path = /obj/item/clothing/under/kitsch_dress/two

/datum/gear/uniform/kitsch_dress/three
	display_name = "Fourth type kitsch dress"
	path = /obj/item/clothing/under/kitsch_dress/three

/datum/gear/uniform/startrek/captain
	display_name = "captain's jumpsuit"
	path = /obj/item/clothing/under/startrek/captain

/datum/gear/uniform/startrek/hop
	display_name = "head of personnel's jumpsuit"
	path = /obj/item/clothing/under/startrek/hop

/datum/gear/uniform/startrek/hos
	display_name = "head of security's jumpsuit"
	path = /obj/item/clothing/under/startrek/hos

/datum/gear/uniform/startrek/cmo
	display_name = "chief medical officer's jumpsuit"
	path = /obj/item/clothing/under/startrek/cmo

/datum/gear/uniform/startrek/rd
	display_name = "research director's jumpsuit"
	path = /obj/item/clothing/under/startrek/rd

/datum/gear/uniform/startrek/ce
	display_name = "chief engineer's jumpsuit"
	path = /obj/item/clothing/under/startrek/ce

/datum/gear/uniform/startrek/sergeant
	display_name = "sergeant's jumpsuit"
	path = /obj/item/clothing/under/startrek/sergeant

/datum/gear/uniform/startrek/adjutant
	display_name = "adjutant's jumpsuit"
	path = /obj/item/clothing/under/startrek/adjutant

/datum/gear/uniform/startrek/eng
	display_name = "engineer's jumpsuit"
	path = /obj/item/clothing/under/startrek/eng

/datum/gear/uniform/startrek/sec
	display_name = "security guard's jumpsuit"
	path = /obj/item/clothing/under/startrek/sec

/datum/gear/uniform/startrek/med
	display_name = "physician's jumpsuit"
	path = /obj/item/clothing/under/startrek/med

/datum/gear/uniform/startrek/sci
	display_name = "researcher's jumpsuit"
	path = /obj/item/clothing/under/startrek/sci

/datum/gear/uniform/bdu
	display_name = "battle dress uniform"
	path = /obj/item/clothing/under/bdu

/datum/gear/uniform/ems
	display_name = "emergency medical responder's jumpsuit"
	path = /obj/item/clothing/under/ems

/datum/gear/uniform/ems/dark
	display_name = "black emergency medical responder's jumpsuit"
	path = /obj/item/clothing/under/ems/dark

/datum/gear/uniform/ems/white
	display_name = "black emergency medical responder's jumpsuit"
	path = /obj/item/clothing/under/ems/white
