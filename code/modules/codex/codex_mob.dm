/mob/proc/can_use_codex(var/examine_check = 0)
	return FALSE

/mob/new_player/can_use_codex(var/examine_check = 0)
	return TRUE

/mob/living/silicon/can_use_codex(var/examine_check = 0)
	return TRUE

/mob/observer/can_use_codex(var/examine_check = 0)
	return TRUE

/mob/living/carbon/human/can_use_codex(var/examine_check = 0)
	if (examine_check)
		return has_codex_augment()
	else
		return TRUE

/mob/living/carbon/human/get_codex_value(var/examine_check = 0)
	return "[lowertext(species.name)] (species)"
