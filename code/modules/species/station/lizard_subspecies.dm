/datum/species/unathi/yeosa
	name = SPECIES_YEOSA
	name_plural = SPECIES_YEOSA

	genders = list(MALE, FEMALE, PLURAL)

	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/tail, /datum/unarmed_attack/claws, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite/sharp, /datum/unarmed_attack/bite/venom)
	darksight_range = 5
	darksight_tint = DARKTINT_GOOD
	slowdown = 0.4
	brute_mod = 0.85
	flash_mod = 1.4
	blood_volume = 700
	water_soothe_amount = 5
	description = "A heavily aquatic offshoot of the Sinta species, Yeosa originally hail from the \
	Salt Swamps, leaving their former home for unclear reasons.<br/><br/>Now dwelling in the islands and seas, \
	their culture has diverged majorly from the Sinta, spending less time performing acts of violence and more time socializing. \
	Their biology is heavily attuned to surviving Moghes' dangerous waters, including gills, fins, and a venomous bite."

	base_auras = list(
		/obj/aura/regenerating/human/unathi/yeosa
		)

	inherent_verbs = list(
		/mob/living/carbon/human/proc/diona_heal_toggle, /mob/living/carbon/human/unathi/yeosa/proc/decant_venom
		)

	additional_available_cultural_info = list(
		TAG_CULTURE = list(
			CULTURE_UNATHI_YEOSA_ABYSS,
			CULTURE_UNATHI_YEOSA_LITTORAL
		),
		TAG_FACTION = list(
			FACTION_UNATHI_RAH_ZAKEH,
			FACTION_UNATHI_KHARZA
		),
		TAG_RELIGION = list(
			RELIGION_UNATHI_AGA_EAKHE
		)
	)

	default_cultural_info = list(TAG_FACTION = FACTION_UNATHI_INDEPENDENT)

	has_organ = list(
		BP_HEAD =     /obj/item/organ/external/head/yeosa,
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_STOMACH =  /obj/item/organ/internal/stomach,
		BP_LUNGS =    /obj/item/organ/internal/lungs/gills,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain/unathi,
		BP_EYES =     /obj/item/organ/internal/eyes/unathi
		)


/datum/species/unathi/yeosa/can_float(mob/living/carbon/human/H)
	if(!H.is_physically_disabled())
		if(H.encumbrance() < 2)
			return TRUE
	return FALSE
