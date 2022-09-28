/mob/proc/can_use_codex()
	return FALSE

/mob/new_player/can_use_codex()
	return TRUE

/mob/living/silicon/can_use_codex()
	return TRUE

/mob/observer/can_use_codex()
	return TRUE

/mob/living/carbon/human/can_use_codex()
	return has_codex_augment()

/mob/living/carbon/human/get_codex_value()
	return "[lowertext(species.name)] (species)"
