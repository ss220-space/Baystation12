#define WEBHOOK_SUBMAP_LOADED_SOL	"webhook_submap_sol"

/obj/effect/submap_landmark/joinable_submap/away_scg_patrol
	name = "Patrol Ship"
	archetype = /decl/submap_archetype/away_scg_patrol

/decl/submap_archetype/away_scg_patrol
	descriptor = "SCGF Patrol Ship"
	map = "Patrol Ship"
	crew_jobs = list(
		/datum/job/submap/patrol/commander,
		/datum/job/submap/patrol/pilot1,
		/datum/job/submap/patrol,
		/datum/job/submap/patrol/captain,
		/datum/job/submap/patrol/surgeon,
		/datum/job/submap/patrol/engineer
	)
	call_webhook = WEBHOOK_SUBMAP_LOADED_SOL

/obj/effect/submap_landmark/spawnpoint/away_patrol
	name = "Army SCGSO Trooper"
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/submap_landmark/spawnpoint/away_patrol/captain
	name = "Army SCGSO Leader"

/obj/effect/submap_landmark/spawnpoint/away_patrol/commander
	name = "Fleet Commander"

/obj/effect/submap_landmark/spawnpoint/away_patrol/pilot1
	name = "Fleet Pilot"

/obj/effect/submap_landmark/spawnpoint/away_patrol/surgeon
	name = "Fleet Corpsman"

/obj/effect/submap_landmark/spawnpoint/away_patrol/engineer
	name = "Fleet Technician"

/* ACCESS
 * =======
 */

/var/const/access_away_cavalry = "ACCESS_CAVALRY"
/var/const/access_away_cavalry_fleet_armory = "ACCESS_CAVALRY_EMERG_ARMORY"
/var/const/access_away_cavalry_ops = "ACCESS_CAVALRY_OPS"
/var/const/access_away_cavalry_pilot = "ACCESS_CAVALRY_PILOT"
/var/const/access_away_cavalry_captain = "ACCESS_CAVALRY_CAPTAIN"
/var/const/access_away_cavalry_commander = "ACCESS_CAVALRY_COMMANDER"

/* JOBS
 * =======
 */

/datum/job/submap/patrol
	title = "Army SCGSO Trooper"
	total_positions = 2
	outfit_type = /decl/hierarchy/outfit/job/patrol/army_ops
	branch = /datum/mil_branch/army
	allowed_branches = list(/datum/mil_branch/army)
	allowed_ranks = list(
		/datum/mil_rank/army/e5,
		/datum/mil_rank/army/e4,
		/datum/mil_rank/army/e4_alt
	)
	supervisors = "Army SCGSO Leader"
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа патрульного корабля 5-го флота ЦПСС, вы - член группы 'Буря', разведовательных войск СОЦПСС. \
	По данным бортового компьютера, поступал сигнал о неизвестных нападениях в этом регионе.\
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы терпите бедствие или на вашем судне аварийная ситуация."
	required_language = LANGUAGE_HUMAN_EURO
	whitelisted_species = list(SPECIES_HUMAN)
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_BASIC,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_EVA = SKILL_BASIC)

/datum/job/submap/patrol/captain
	title = "Army SCGSO Leader"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/patrol/captain
	branch = /datum/mil_branch/army
	allowed_branches = list(/datum/mil_branch/army)
	allowed_ranks = list(
		/datum/mil_rank/army/o3,
		/datum/mil_rank/army/o2
	)
	supervisors = "Fleet Commander, Command of the Battle Group Bravo of the 5th fleet, SCGDF"
	loadout_allowed = TRUE
	is_semi_antagonist = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов соединения, входящего в экипаж патрульного корабля 5-го флота ЦПСС, ваша задача состоит в руководстве группой 'Буря', разведовательных войск СОЦПСС. \
	По данным бортового компьютера, поступал сигнал о неизвестных нападениях в этом регионе.\
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы терпите бедствие или на вашем судне аварийная ситуация."
	required_language = LANGUAGE_HUMAN_EURO
	whitelisted_species = list(SPECIES_HUMAN)
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_BASIC,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_EVA = SKILL_BASIC)

/datum/job/submap/patrol/commander
	title = "Fleet Commander"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/patrol/commander
	branch = /datum/mil_branch/fleet
	allowed_branches = list(/datum/mil_branch/fleet)
	allowed_ranks = list(
		/datum/mil_rank/fleet/o4,
		/datum/mil_rank/fleet/o3
	)
	supervisors = "Command of the Battle Group Bravo of the 5th fleet, SCGDF"
	loadout_allowed = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа патрульного корабля 5-го флота ЦПСС, ваша задача состоит в патруле и разведке данного сектора. \
	По данным бортового компьютера, поступал сигнал о неизвестных нападениях в этом регионе.\
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы терпите бедствие или на вашем судне аварийная ситуация."
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_BASIC,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_PILOT = SKILL_ADEPT,
					 SKILL_EVA = SKILL_BASIC)

/datum/job/submap/patrol/pilot1
	title = "Fleet Pilot"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/patrol/pilot1
	branch = /datum/mil_branch/fleet
	allowed_branches = list(/datum/mil_branch/fleet)
	allowed_ranks = list(
		/datum/mil_rank/fleet/o2,
		/datum/mil_rank/fleet/o1
	)
	supervisors = "Fleet Commander"
	loadout_allowed = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа патрульного корабля 5-го флота ЦПСС, ваша задача состоит в пилотировании и руководством экипажа. \
	По данным бортового компьютера, поступал сигнал о неизвестных нападениях в этом регионе.\
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы терпите бедствие или на вашем судне аварийная ситуация."
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_BASIC,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_PILOT = SKILL_ADEPT,
					 SKILL_EVA = SKILL_BASIC)

/datum/job/submap/patrol/surgeon
	title = "Fleet Corpsman"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/patrol/surgeon
	branch = /datum/mil_branch/fleet
	allowed_branches = list(/datum/mil_branch/fleet)
	allowed_ranks = list(
		/datum/mil_rank/fleet/o1,
		/datum/mil_rank/fleet/o2
	)
	supervisors = "Fleet Pilot, Fleet Commander"
	loadout_allowed = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа патрульного корабля 5-го флота ЦПСС, ваша задача состоит в медицинской поддержке экипажа. \
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы терпите бедствие или на вашем судне аварийная ситуация.<br>\
	\
	<b>Хоть вы и являетесь офицером, в ваши обязанности НЕ входит командование экипажем - это всего лишь показатель вашего профессионализма в медицинской сфере!</b>"
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_ADEPT,
					 SKILL_MEDICAL = SKILL_EXPERT,
					 SKILL_ANATOMY = SKILL_BASIC,
					 SKILL_CHEMISTRY = SKILL_BASIC,
					 SKILL_EVA = SKILL_BASIC)

/datum/job/submap/patrol/engineer
	title = "Fleet Technician"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/patrol/engineer
	branch = /datum/mil_branch/fleet
	allowed_branches = list(/datum/mil_branch/fleet)
	allowed_ranks = list(
		/datum/mil_rank/fleet/e6,
		/datum/mil_rank/fleet/e5,
		/datum/mil_rank/fleet/e4
	)
	supervisors = "Fleet Pilot, Fleet Commander"
	loadout_allowed = TRUE
	info = "Вы просыпаетесь и выходите из криосна, ощущая прохладный воздух на своём лице, а также лёгкую тошноту. \
	Являясь одним из членов экипажа патрульного корабля 5-го флота ЦПСС, ваша задача состоит в поддержании работоспособности судна и экипировки экипажа. \
	\
	 Вам крайне нежелательно приближаться к кораблям и станциям с опозновательными знаками без разрешения от командования группировкой. \
	 Исключением являются те ситуации, когда вы терпите бедствие или на вашем судне аварийная ситуация."
	min_skill = list(SKILL_COMBAT  = SKILL_BASIC,
					 SKILL_WEAPONS = SKILL_BASIC,
					 SKILL_HAULING = SKILL_ADEPT,
					 SKILL_MEDICAL = SKILL_BASIC,
					 SKILL_EVA = SKILL_ADEPT,
					 SKILL_CONSTRUCTION = SKILL_ADEPT,
					 SKILL_ELECTRICAL = SKILL_ADEPT,
					 SKILL_ATMOS  = SKILL_BASIC,
					 SKILL_ENGINES = SKILL_ADEPT,
					 SKILL_DEVICES = SKILL_BASIC)


/* BRANCH & RANKS
 * =======
 */

/datum/mil_branch/fleet
	name = "SCG Fleet"
	name_short = "SCGF"
	email_domain = "fleet.mil"
	rank_types = list(
		/datum/mil_rank/fleet/e4,
		/datum/mil_rank/fleet/e5,
		/datum/mil_rank/fleet/e6,
		/datum/mil_rank/fleet/o1,
		/datum/mil_rank/fleet/o2,
		/datum/mil_rank/fleet/o3,
		/datum/mil_rank/fleet/o4
	)
	spawn_rank_types = list(
		/datum/mil_rank/fleet/e4,
		/datum/mil_rank/fleet/e5,
		/datum/mil_rank/fleet/e6,
		/datum/mil_rank/fleet/o1,
		/datum/mil_rank/fleet/o2,
		/datum/mil_rank/fleet/o3,
		/datum/mil_rank/fleet/o4
	)

/datum/mil_rank/grade()
	. = ..()
	if(!sort_order)
		return ""
	if(sort_order <= 10)
		return "E[sort_order]"
	return "O[sort_order - 10]"

/datum/mil_rank/fleet/e4
	name = "Petty Officer Third Class"
	name_short = "PO3"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e4, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 4

/datum/mil_rank/fleet/e5
	name = "Petty Officer Second Class"
	name_short = "PO2"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e5, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 5

/datum/mil_rank/fleet/e6
	name = "Petty Officer First Class"
	name_short = "PO1"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/enlisted/e6, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 6

/datum/mil_rank/fleet/o1
	name = "Ensign"
	name_short = "ENS"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 11

/datum/mil_rank/fleet/o2
	name = "Sub-lieutenant"
	name_short = "SLT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/o2, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 12

/datum/mil_rank/fleet/o3
	name = "Lieutenant"
	name_short = "LT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/o3, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 13

/datum/mil_rank/fleet/o4
	name = "Lieutenant Commander"
	name_short = "LCDR"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/o4, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 14

/datum/mil_branch/army
	name = "SCG Army"
	name_short = "SCGA"
	email_domain = "army.mil"
	rank_types = list(
		/datum/mil_rank/army/e4_alt,
		/datum/mil_rank/army/e4,
		/datum/mil_rank/army/e5,
		/datum/mil_rank/army/o2,
		/datum/mil_rank/army/o3
	)
	spawn_rank_types = list(
		/datum/mil_rank/army/e4_alt,
		/datum/mil_rank/army/e4,
		/datum/mil_rank/army/e5,
		/datum/mil_rank/army/o2,
		/datum/mil_rank/army/o3
	)


/datum/mil_rank/army/e4_alt
	name = "Specialist"
	name_short = "SPT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/army/enlisted/e4_alt, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 4

/datum/mil_rank/army/e4
	name = "Corporal"
	name_short = "CPL"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/army/enlisted/e4, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 4

/datum/mil_rank/army/e5
	name = "Sergeant"
	name_short = "SGT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/army/enlisted/e5, /obj/item/clothing/accessory/solgov/specialty/enlisted)
	sort_order = 5

/datum/mil_rank/army/o2
	name = "First Lieutenant"
	name_short = "1LT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/army/officer/o2, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 12

/datum/mil_rank/army/o3
	name = "Captain"
	name_short = "CAPT"
	accessory = list(/obj/item/clothing/accessory/solgov/rank/army/officer/o3, /obj/item/clothing/accessory/solgov/specialty/officer)
	sort_order = 13

/* OUTFITS
 * =======
 */

#define PATROL_OUTFIT_JOB_NAME(job_name) ("SCG Patrol Ship - Job - " + job_name)

/decl/hierarchy/outfit/job/patrol
	hierarchy_type = /decl/hierarchy/outfit/job/patrol
	uniform = /obj/item/clothing/under/solgov/utility/fleet/away_solpatrol
	shoes = /obj/item/clothing/shoes/dutyboots
	l_ear = /obj/item/device/radio/headset/away_scg_patrol
	l_pocket = /obj/item/device/radio
	r_pocket = /obj/item/crowbar/prybar
	suit_store = /obj/item/tank/oxygen
	id_types = list(/obj/item/card/id/awaycavalry/fleet)
	id_slot = slot_wear_id
	pda_type = null
	belt = null
	back = /obj/item/storage/backpack/satchel/pocketbook/navy
	backpack_contents = null
	flags = OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/patrol/army_ops
	name = PATROL_OUTFIT_JOB_NAME("Ops")
	head = /obj/item/clothing/head/solgov/utility/army/urban
	uniform = /obj/item/clothing/under/solgov/utility/army/urban
	id_types = list(/obj/item/card/id/awaycavalry/ops)
	gloves = /obj/item/clothing/gloves/thick/combat/marine

/decl/hierarchy/outfit/job/patrol/captain
	name = PATROL_OUTFIT_JOB_NAME("Captain")
	head = /obj/item/clothing/head/solgov/utility/army/urban
	uniform = /obj/item/clothing/under/solgov/utility/army/urban
	id_types = list(/obj/item/card/id/awaycavalry/ops/captain)
	gloves = /obj/item/clothing/gloves/thick/combat/marine

/decl/hierarchy/outfit/job/patrol/engineer
	name = PATROL_OUTFIT_JOB_NAME("Technician")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/engineering/away_solpatrol
	belt = /obj/item/storage/belt/holster/security/tactical/away_solpatrol
	gloves = /obj/item/clothing/gloves/insulated/black

/decl/hierarchy/outfit/job/patrol/surgeon
	name = PATROL_OUTFIT_JOB_NAME("Doctor")
	uniform = /obj/item/clothing/under/solgov/utility/fleet/medical/away_solpatrol
	belt = /obj/item/storage/belt/holster/security/tactical/away_solpatrol
	gloves = /obj/item/clothing/gloves/latex/nitrile

/decl/hierarchy/outfit/job/patrol/commander
	name = PATROL_OUTFIT_JOB_NAME("Commander")
	head = /obj/item/clothing/head/beret/solgov/fleet/branch/fifth
	uniform = /obj/item/clothing/under/solgov/utility/fleet/officer/command/commander/away_solpatrol
	belt = /obj/item/storage/belt/holster/security/tactical/away_solpatrol
	id_types = list(/obj/item/card/id/awaycavalry/fleet/commander)
	gloves = /obj/item/clothing/gloves/thick/duty/solgov/cmd

/decl/hierarchy/outfit/job/patrol/pilot1
	name = PATROL_OUTFIT_JOB_NAME("Pilot")
	head = /obj/item/clothing/head/beret/solgov/fleet/branch/fifth
	uniform = /obj/item/clothing/under/solgov/utility/fleet/officer/pilot1/away_solpatrol
	belt = /obj/item/storage/belt/holster/security/tactical/away_solpatrol
	id_types = list(/obj/item/card/id/awaycavalry/fleet/pilot)
	gloves = /obj/item/clothing/gloves/thick/duty/rivalgloves

/decl/hierarchy/outfit/job/patrol/centcom/bridge_officer
	name = PATROL_OUTFIT_JOB_NAME("Bridge Officer")
	head = /obj/item/clothing/head/beret/solgov/fleet/branch/fifth
	l_ear = /obj/item/device/radio/headset/headset_com/alt
	uniform = /obj/item/clothing/under/solgov/service/fleet
	belt = /obj/item/storage/belt/holster/general/away_solpatrol
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/solgov/service/fleet/command/away_solpatrol/bridge_officer
	r_pocket = /obj/item/card/id/syndicate
	l_pocket = /obj/item/clothing/accessory/solgov/rank/fleet/officer
	id_types = list(/obj/item/card/id/centcom/NtPass/station)
	id_pda_assignment = "5th Fleet Bridge Officer"

/decl/hierarchy/outfit/job/patrol/centcom/comms_officer
	name = PATROL_OUTFIT_JOB_NAME("Communications Officer")
	head = /obj/item/clothing/head/solgov/dress/fleet
	l_ear = /obj/item/device/radio/headset/headset_com/alt
	uniform = /obj/item/clothing/under/solgov/service/fleet
	belt = /obj/item/storage/belt/holster/general/away_solpatrol
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/solgov/service/fleet/command/away_solpatrol/comms_officer
	r_pocket = /obj/item/card/id/syndicate
	l_pocket = /obj/item/clothing/head/beret/solgov/fleet/command
	id_types = list(/obj/item/card/id/centcom/NtPass/station)
	id_pda_assignment = "5th Fleet Communications Officer"

/decl/hierarchy/outfit/job/patrol/centcom/commanding_officer
	name = PATROL_OUTFIT_JOB_NAME("Commanding Officer")
	head = /obj/item/clothing/head/solgov/dress/fleet/command
	uniform = /obj/item/clothing/under/solgov/service/fleet
	belt = /obj/item/storage/belt/holster/general/away_solpatrol
	shoes = /obj/item/clothing/shoes/dress
	suit = /obj/item/clothing/suit/storage/solgov/service/fleet/command/away_solpatrol/commanding_officer
	r_pocket = /obj/item/card/id/syndicate
	l_pocket = /obj/item/clothing/accessory/solgov/rank/fleet/flag
	id_types = list(/obj/item/card/id/centcom/NtPass/station)
	id_pda_assignment = "5th Fleet Commanding Officer"

#undef PATROL_OUTFIT_JOB_NAME
#undef WEBHOOK_SUBMAP_LOADED_SOL
