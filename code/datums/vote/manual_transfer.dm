#define CHOICE_TRANSFER "Initiate crew transfer"
#define CHOICE_EXTEND "Extend the round"

/datum/vote/transfer_manual
	name = "manual transfer"
	question = "End the shift?"
	var/static/last_vote = 0

/datum/vote/transfer_manual/can_run(mob/creator, automatic)
	if(!(. = ..()))
		return
	if(!evacuation_controller || !evacuation_controller.should_call_autotransfer_vote())
		return FALSE
	if(!automatic && !config.allow_vote_manual_transfer && !isadmin(creator))
		return FALSE // Admins and autovotes bypass the config setting.
	if(check_rights(R_INVESTIGATE, 0, creator))
		return //Mods bypass further checks.
	if(world.time < config.vote_manual_transfer_initial)
		to_chat(creator, "Manual crew transfer could be called after [(config.vote_manual_transfer_initial - world.time) / 600] minutes!")
		return FALSE
	if (world.time < last_vote + config.vote_manual_transfer_cooldown)
		to_chat(creator, "Manual crew transfer could be called after [((last_vote + config.vote_manual_transfer_cooldown) - world.time) / 600] minutes!")
		return FALSE
	var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
	if (!automatic && security_state.current_security_level_is_same_or_higher_than(security_state.high_security_level))
		to_chat(creator, "The current alert status is too high to call for a crew transfer!")
		return FALSE
	if(GAME_STATE <= RUNLEVEL_SETUP)
		to_chat(creator, "The crew transfer button has been disabled!")
		return FALSE

/datum/vote/transfer_manual/setup_vote(mob/creator, automatic)
	choices = list(CHOICE_TRANSFER, CHOICE_EXTEND)
	last_vote = world.time
	..()

/datum/vote/transfer_manual/handle_default_votes()
	if(config.vote_no_default)
		return
	var/factor = 0.5
	switch(world.time / (1 MINUTE))
		if(0 to 60)
			factor = 0.5
		if(61 to 120)
			factor = 0.8
		if(121 to 240)
			factor = 1
		if(241 to 300)
			factor = 1.2
		else
			factor = 1.4
	choices[CHOICE_TRANSFER] = round(choices[CHOICE_TRANSFER] * factor)
	to_world("<font color='purple'>Crew Transfer Factor: [factor]</font>")

/datum/vote/transfer_manual/report_result()
	if(..())
		return 1
	if(result[1] == CHOICE_TRANSFER)
		init_autotransfer()

/datum/vote/transfer_manual/mob_not_participating(mob/user)
	if((. = ..()))
		return
	if(config.vote_no_dead_crew_transfer)
		return !isliving(user) || ismouse(user) || is_drone(user)

/datum/vote/transfer_manual/check_toggle()
	return config.allow_vote_manual_transfer ? "Allowed" : "Disallowed"

/datum/vote/transfer_manual/toggle(mob/user)
	if(isadmin(user))
		config.allow_vote_manual_transfer = !config.allow_vote_manual_transfer

#undef CHOICE_TRANSFER
#undef CHOICE_EXTEND
