/datum/species/machine
	name = SPECIES_IPC
	name_plural = "machines"

	description = "Positronic intelligence really took off in the 24th century, and it is not uncommon to see independant, free-willed \
	robots on many human stations, particularly in fringe systems where standards are slightly lax and public opinion less relevant \
	to corporate operations. IPCs (Integrated Positronic Chassis) are a loose category of self-willed robots with a humanoid form, \
	generally self-owned after being 'born' into servitude; they are reliable and dedicated workers, albeit more than slightly \
	inhuman in outlook and perspective."
	cyborg_noun = null

	preview_icon = 'icons/mob/human_races/species/ipc/preview.dmi'

	unarmed_types = list(/datum/unarmed_attack/punch, /datum/unarmed_attack/kick, /datum/unarmed_attack/stomp)
	rarity_value = 2
	strength = STR_HIGH

	min_age = 1
	max_age = 95

	warning_low_pressure = 50
	hazard_low_pressure = -1

	cold_level_1 = SYNTH_COLD_LEVEL_1
	cold_level_2 = SYNTH_COLD_LEVEL_2
	cold_level_3 = SYNTH_COLD_LEVEL_3

	heat_level_1 = SYNTH_HEAT_LEVEL_1		// Gives them about 25 seconds in space before taking damage
	heat_level_2 = SYNTH_HEAT_LEVEL_2
	heat_level_3 = SYNTH_HEAT_LEVEL_3

	body_temperature = null
	passive_temp_gain = 0  // This should cause IPCs to stabilize at ~80 C in a 20 C environment.(5)

	species_flags = SPECIES_FLAG_NO_SCAN | SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_POISON | SPECIES_ALL_ROBOPARTS
	spawn_flags = SPECIES_CAN_JOIN | SPECIES_IS_WHITELISTED | SPECIES_NO_FBP_CONSTRUCTION
	appearance_flags = HAS_UNDERWEAR | HAS_EYE_COLOR //IPCs can wear undies too :(

	blood_color = "#1f181f"
	flesh_color = "#575757"

	has_organ = list(
		BP_POSIBRAIN = /obj/item/organ/internal/posibrain,
		BP_EYES = /obj/item/organ/internal/eyes/robot,
		BP_COOLING = /obj/item/organ/internal/cooling_system
		)

	heat_discomfort_level = 373.15
	heat_discomfort_strings = list(
		"Your CPU temperature probes warn you that you are approaching critical heat levels!"
		)
	genders = list(NEUTER)

	available_cultural_info = list(
		TAG_CULTURE = list(
			CULTURE_POSITRONICS_FIRSTGEN,
			CULTURE_POSITRONICS_SECONDGEN_OWNED,
			CULTURE_POSITRONICS_SECONDGEN_FREE,
			CULTURE_POSITRONICS_SECONDGEN_UNION,
			CULTURE_POSITRONICS_THIRDGEN_PRIVATELY,
			CULTURE_POSITRONICS_THIRDGEN_CORPORATE,
			CULTURE_POSITRONICS_THIRDGEN_STATE
		),
		TAG_HOMEWORLD = list(
			HOME_SYSTEM_ROOT,
			//HOME_SYSTEM_TIAMATH,
			HOME_SYSTEM_EARTH,
			HOME_SYSTEM_LUNA,
			HOME_SYSTEM_MARS,
			HOME_SYSTEM_VENUS,
			HOME_SYSTEM_CERES,
			HOME_SYSTEM_PLUTO,
			HOME_SYSTEM_TAU_CETI,
			HOME_SYSTEM_HELIOS,
			HOME_SYSTEM_TERSTEN,
			HOME_SYSTEM_AHDOMAI,
			HOME_SYSTEM_TERRA,
			HOME_SYSTEM_LORRIMAN,
			HOME_SYSTEM_CINU,
			HOME_SYSTEM_YUKLID,
			HOME_SYSTEM_LORDANIA,
			HOME_SYSTEM_KINGSTON,
			HOME_SYSTEM_GAIA,
			HOME_SYSTEM_OTHER

		),
		TAG_FACTION = list(
			FACTION_POSITRONICS,
			FACTION_SOL_CENTRAL,
			FACTION_INDIE_CONFED,
			FACTION_NANOTRASEN,
			FACTION_FREETRADE,
			FACTION_HEPHAESTUS,
			FACTION_XYNERGY,
			FACTION_FLEET,
			FACTION_EXPEDITIONARY,
			FACTION_PCRC,
			FACTION_CORPORATE,
			FACTION_DAIS,
			FACTION_ZENG_HU,
			FACTION_WARD_TAKAHASHI,
			FACTION_GRAYSON,
			FACTION_AERTHER,
			FACTION_SAARE,
			FACTION_MAJOR_BILL,
			FACTION_FOCAL_POINT,
			FACTION_XION,
			FACTION_MORPHEUS,
			FACTION_VEY_MED,
			FACTION_BISHOP,
			FACTION_ZPCI,
			FACTION_OTHER
		)
	)

	default_cultural_info = list(
		TAG_CULTURE = CULTURE_POSITRONICS_FIRSTGEN,
		TAG_HOMEWORLD = HOME_SYSTEM_ROOT,
		TAG_FACTION = FACTION_POSITRONICS
	)

	exertion_effect_chance = 10
	exertion_charge_scale = 1
	exertion_emotes_synthetic = list(
		/decl/emote/exertion/synthetic,
		/decl/emote/exertion/synthetic/creak
	)

/datum/species/machine/handle_death(var/mob/living/carbon/human/H)
	..()
	if(istype(H.wear_mask,/obj/item/clothing/mask/monitor))
		var/obj/item/clothing/mask/monitor/M = H.wear_mask
		M.monitor_state_index = "blank"
		M.update_icon()

/datum/species/machine/post_organ_rejuvenate(var/obj/item/organ/org, var/mob/living/carbon/human/H)
	var/obj/item/organ/external/E = org
	if(istype(E) && !BP_IS_ROBOTIC(E))
		E.robotize("Morpheus")

/datum/species/machine/get_blood_name()
	return "oil"

/datum/species/machine/disfigure_msg(var/mob/living/carbon/human/H)
	var/datum/gender/T = gender_datums[H.get_gender()]
	return "<span class='danger'>[T.His] monitor is completely busted!</span>\n"

/datum/species/machine/can_float(mob/living/carbon/human/H)
	return FALSE

/datum/species/machine/check_background(var/datum/job/job, var/datum/preferences/prefs)
	var/decl/cultural_info/culture/ipc/c = SSculture.get_culture(prefs.cultural_info[TAG_CULTURE])
	. = istype(c) ? (job.type in c.valid_jobs) : ..()

/datum/species/machine/skills_from_age(age)	//Converts an age into a skill point allocation modifier. Can be used to give skill point bonuses/penalities not depending on job.
	switch(age)
		if(0 to 10)    . = 0
		if(11 to 25)   . =  2
		if(26 to 40)   . =  4
		if(41 to 55)   . =  6
		if(56 to 71)   . =  8
		else           . =  2
