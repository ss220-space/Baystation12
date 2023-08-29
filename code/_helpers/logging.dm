
// On Linux/Unix systems the line endings are LF, on windows it's CRLF, admins that don't use notepad++
// will get logs that are one big line if the system is Linux and they are using notepad.  This solves it by adding CR to every line ending
// in the logs.  ascii character 13 = CR

GLOBAL_VAR_INIT(log_end, (ascii2text(13))) // CRLF for all logs
GLOBAL_PROTECT(log_end)

#define DIRECT_OUTPUT(A, B) A << B
#define SEND_IMAGE(target, image) DIRECT_OUTPUT(target, image)
#define SEND_SOUND(target, sound) DIRECT_OUTPUT(target, sound)
#define SEND_TEXT(target, text) DIRECT_OUTPUT(target, text)
#define WRITE_FILE(file, text) DIRECT_OUTPUT(file, text)

/proc/start_log(log)
	WRITE_LOG(log, "Starting up. Round ID is [game_id ? game_id : "NULL"]\n-------------------------[GLOB.log_end]")

/proc/error(msg)
	log_world(msg)


/proc/log_ss(subsystem, text, log_world = TRUE)
	if (!subsystem)
		subsystem = "UNKNOWN"
	var/msg = "[subsystem]: [text]"
	game_log("SS", msg)
	if (log_world)
		log_world("## ERROR: [msg]")

/proc/log_ss_init(text)
	game_log("SS", "[text]")


//print a warning message to world.log
#define WARNING(MSG) warning("[MSG] in [__FILE__] at line [__LINE__] src: [src] usr: [usr].")
/proc/warning(msg)
	log_world("## WARNING: [msg]")
	to_debug_listeners(msg, "WARNING")
//error and warning messages
/proc/log_error(text)
	error(text)
	to_debug_listeners(text, "ERROR")

/proc/log_warning(text)
	warning(text)
	to_debug_listeners(text, "WARNING")
//print a testing-mode debug message to world.log and world
#ifdef TESTING
#define testing(msg) log_world("## TESTING: [msg]"); to_chat(world, "## TESTING: [msg]")
#else
#define testing(msg)
#endif


/proc/game_log(category, text)
	WRITE_LOG(GLOB.world_game_log, "[category]: [text][GLOB.log_end]")

// All the log_type() procs are used for writing down into game.log
// don't use this for logging. We have add_type_logs() for this situation
// you can look all the way down in this file for those procs

/proc/log_admin(text)
	GLOB.admin_log.Add(text)
	if(config.log_admin)
		WRITE_LOG(GLOB.world_game_log, "ADMIN: [text][GLOB.log_end]")

/proc/to_debug_listeners(text, prefix = "DEBUG")
	for(var/client/C in GLOB.admins)
		if(C.get_preference_value(/datum/client_preference/staff/show_debug_logs) == GLOB.PREF_SHOW)
			to_chat(C, SPAN_DEBUG("<b>[prefix]</b>: [text]"))

/proc/log_debug(text)
	if(config.log_debug)
		WRITE_LOG(GLOB.world_game_log, "DEBUG: [text][GLOB.log_end]")
	to_debug_listeners(text)


/proc/log_game(text)
	if(config.log_game)
		WRITE_LOG(GLOB.world_game_log, "GAME: [text][GLOB.log_end]")

/proc/log_vote(text)
	if(config.log_vote)
		WRITE_LOG(GLOB.world_game_log, "VOTE: [text][GLOB.log_end]")

/proc/log_access_in(client/new_client)
	if(config.log_access)
		var/message = "[key_name(new_client)] - IP:[new_client.address] - CID:[new_client.computer_id] - BYOND v[new_client.byond_version].[new_client.byond_build]"
		WRITE_LOG(GLOB.world_game_log, "ACCESS IN: [message][GLOB.log_end]")
		if(new_client.ckey in GLOB.admin_datums)
			var/datum/admins/admin = GLOB.admin_datums[new_client.ckey]
			WRITE_LOG(GLOB.world_game_log, "ADMIN: Admin [key_name(new_client)] ([admin.rank]) logged in[GLOB.log_end]")

/proc/log_access_out(mob/last_mob)
	if(config.log_access)
		var/message = "[key_name(last_mob)] - IP:[last_mob.lastKnownIP] - CID:[last_mob.computer_id] - BYOND Logged Out"
		WRITE_LOG(GLOB.world_game_log, "ACCESS OUT: [message][GLOB.log_end]")
		if(last_mob.ckey in GLOB.admin_datums)
			WRITE_LOG(GLOB.world_game_log, "ADMIN: Admin [key_name(last_mob)] logged out[GLOB.log_end]")

/proc/log_say(text, mob/speaker)
	if(config.log_say)
		WRITE_LOG(GLOB.world_game_log, "SAY: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_whisper(text, mob/speaker)
	if(config.log_whisper)
		WRITE_LOG(GLOB.world_game_log, "WHISPER: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_ooc(text, client/user)
	if(config.log_ooc)
		WRITE_LOG(GLOB.world_game_log, "OOC: [user.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_aooc(text, client/user)
	if(config.log_ooc)
		WRITE_LOG(GLOB.world_game_log, "OOC: (AOOC) [user.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_looc(text, client/user)
	if(config.log_ooc)
		WRITE_LOG(GLOB.world_game_log, "LOOC: [user.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_emote(text, mob/speaker)
	if(config.log_emote)
		WRITE_LOG(GLOB.world_game_log, "EMOTE: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_attack(mob/attacker, mob/victim, message)
	if(config.log_attack)
		WRITE_LOG(GLOB.world_game_log, "ATTACK: [attacker.simple_info_line()] against [victim.simple_info_line()]: [message][GLOB.log_end]") //Seperate attack logs? Why?

/proc/log_adminsay(text, mob/speaker)
	if(config.log_adminchat)
		WRITE_LOG(GLOB.world_game_log, "ADMINSAY: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_staff_say(text, mob/speaker)
	if(config.log_adminchat)
		WRITE_LOG(GLOB.world_game_log, "STAFFSAY: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_adminwarn(text)
	if (config.log_adminwarn)
		WRITE_LOG(GLOB.world_game_log, "ADMINWARN: [html_decode(text)][GLOB.log_end]")

/proc/log_permissions(text)
	if (config.log_permissions)
		WRITE_LOG(GLOB.world_game_log,"PERMISSIONS: [html_decode(text)][GLOB.log_end]")

/proc/log_fax(text)
	WRITE_LOG(GLOB.world_game_log, "FAX: [html_decode(text)][GLOB.log_end]")

/proc/log_qdel(text)
	WRITE_LOG(GLOB.world_qdel_log, "QDEL: [text][GLOB.log_end]")

/proc/log_mentorsay(text, mob/speaker)
	if(config.log_adminchat)
		WRITE_LOG(GLOB.world_game_log, "MENTORSAY: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_ghostsay(text, mob/speaker)
	if(config.log_say)
		WRITE_LOG(GLOB.world_game_log, "DEADCHAT: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_ghostemote(text, mob/speaker)
	if(config.log_emote)
		WRITE_LOG(GLOB.world_game_log, "DEADEMOTE: [speaker.simple_info_line()]: [html_decode(text)][GLOB.log_end]")

/proc/log_chat(text, mob/speaker)
	if(config.log_pda)
		WRITE_LOG(GLOB.world_game_log, "CHAT: [speaker.simple_info_line()] [html_decode(text)][GLOB.log_end]")

/proc/log_misc(text)
	WRITE_LOG(GLOB.world_game_log, "MISC: [text][GLOB.log_end]")

/proc/log_unit_test(text)
	to_world_log("## UNIT_TEST ##: [text]")
	WRITE_LOG(GLOB.world_game_log, "UNITTEST: [text][GLOB.log_end]")

/proc/log_asset(text)
	WRITE_LOG(GLOB.world_game_log, "ASSETS: [text][GLOB.log_end]")

/proc/log_tgui(user_or_client, text)
	if(!text)
		stack_trace("Pointless log_tgui message")
		return
	var/entry = ""
	if(!user_or_client)
		entry += "no user"
	else if(istype(user_or_client, /mob))
		var/mob/user = user_or_client
		entry += "[user.ckey] (as [user])"
	else if(istype(user_or_client, /client))
		var/client/client = user_or_client
		entry += "[client.ckey]"
	entry += ":\n[text]"
	WRITE_LOG(GLOB.world_game_log, "TGUI: [entry][GLOB.log_end]")

/proc/log_antag_objectives(datum/mind/Mind)
	if(length(Mind.objectives))
		WRITE_LOG(GLOB.world_game_log, "GAME: Start objective log for [html_decode(Mind.key)]/[html_decode(Mind.name)][GLOB.log_end]")
		var/count = 1
		for(var/datum/objective/objective in Mind.objectives)
			WRITE_LOG(GLOB.world_game_log, "GAME: Objective #[count]: [objective.explanation_text][GLOB.log_end]")
			count++
		WRITE_LOG(GLOB.world_game_log, "GAME: End objective log for [html_decode(Mind.key)]/[html_decode(Mind.name)][GLOB.log_end]")

/proc/log_goals(datum/mind/Mind)
	if(length(Mind.goals))
		WRITE_LOG(GLOB.world_game_log, "GAME: Start goal log for [html_decode(Mind.key)]/[html_decode(Mind.name)][GLOB.log_end]")
		var/count = 1
		for(var/datum/goal/goal in Mind.goals)
			WRITE_LOG(GLOB.world_game_log, "GAME: Goal #[count]: [goal.description][GLOB.log_end]")
			count++
		WRITE_LOG(GLOB.world_game_log, "GAME: End goal log for [html_decode(Mind.key)]/[html_decode(Mind.name)][GLOB.log_end]")

/proc/log_memories(datum/mind/Mind)
	if(length(Mind.goals))
		WRITE_LOG(GLOB.world_game_log, "GAME: Start memory log for [html_decode(Mind.key)]/[html_decode(Mind.name)][GLOB.log_end]")
		var/count = 1
		for(var/datum/memory/memory in Mind.memories)
			WRITE_LOG(GLOB.world_game_log, "GAME:  Memory #[count]: [memory.memory][GLOB.log_end]")
			count++
		WRITE_LOG(GLOB.world_game_log, "GAME: End memory log for [html_decode(Mind.key)]/[html_decode(Mind.name)][GLOB.log_end]")

/proc/log_world(text)
	if(config && config.log_world_output)
		WRITE_LOG(GLOB.world_game_log, "WORLD: [html_decode(text)][GLOB.log_end]")

/proc/log_config(text)
	WRITE_LOG(GLOB.config_error_log, "[text][GLOB.log_end]")
	SEND_TEXT(world.log, text)

/proc/log_href(text)
	WRITE_LOG(GLOB.world_href_log, "HREF: [html_decode(text)][GLOB.log_end]")


/proc/log_sql(text)
	WRITE_LOG(GLOB.sql_log, "[text][GLOB.log_end]")
	SEND_TEXT(world.log, text)

//pretty print a direction bitflag, can be useful for debugging.
/proc/dir_text(var/dir)
	var/list/comps = list()
	if(dir & NORTH) comps += "NORTH"
	if(dir & SOUTH) comps += "SOUTH"
	if(dir & EAST) comps += "EAST"
	if(dir & WEST) comps += "WEST"
	if(dir & UP) comps += "UP"
	if(dir & DOWN) comps += "DOWN"

	return english_list(comps, nothing_text="0", and_text="|", comma_text="|")

//more or less a logging utility
/proc/key_name(var/whom, var/include_link = null, var/include_name = 1, var/highlight_special_characters = 1, var/datum/ticket/ticket = null)
	var/mob/M
	var/client/C
	var/key

	if(!whom)	return "*null*"
	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
	else if(ismob(whom))
		M = whom
		C = M.client
		key = LAST_KEY(M)
	else if(istype(whom, /datum/mind))
		var/datum/mind/D = whom
		key = D.key
		M = D.current
		if(D.current)
			C = D.current.client
	else if(istype(whom, /datum))
		var/datum/D = whom
		return "*INVALID:[D.type]*"
	else
		return "*INVALID*"

	. = ""

	if(key)
		if(include_link && C)
			. += "<a href='?priv_msg=\ref[C];ticket=\ref[ticket]'>"

		. += key

		if(include_link)
			if(C)	. += "</a>"
			else	. += " (DC)"
	else
		. += "*INVALID*"

	if(include_name && M)
		var/name

		if(M.real_name)
			name = M.real_name
		else if(M.name)
			name = M.name


		if(is_special_character(M) && highlight_special_characters)
			. += "/(<font color='#ffa500'>[name]</font>)" //Orange
		else
			. += "/([name])"

	return .


/proc/key_name_admin(var/whom, var/include_name = 1)
	return key_name(whom, 1, include_name)

/proc/get_key(var/whom)
	return key_name(whom, include_name = 0)

// Helper procs for building detailed log lines
/datum/proc/get_log_info_line()
	return "[src] ([type]) ([any2ref(src)])"

/area/get_log_info_line()
	return "[..()] ([isnum(z) ? "[x],[y],[z]" : "0,0,0"])"

/turf/get_log_info_line()
	return "[..()] ([x],[y],[z]) ([loc ? loc.type : "NULL"])"

/atom/movable/get_log_info_line()
	var/turf/t = get_turf(src)
	return "[..()] ([t ? t : "NULL"]) ([t ? "[t.x],[t.y],[t.z]" : "0,0,0"]) ([t ? t.type : "NULL"])"

/mob/get_log_info_line()
	return ckey ? "[..()] ([ckey])" : ..()

/proc/log_info_line(var/datum/d)
	if(isnull(d))
		return "*null*"
	if(islist(d))
		var/list/L = list()
		for(var/e in d)
			// Indexing on numbers just gives us the same number again in the best case and causes an index out of bounds runtime in the worst
			var/v = isnum(e) ? null : d[e]
			L += "[log_info_line(e)][v ? " - [log_info_line(v)]" : ""]"
		return "\[[jointext(L, ", ")]\]" // We format the string ourselves, rather than use json_encode(), because it becomes difficult to read recursively escaped "
	if(!istype(d))
		return json_encode(d)
	return d.get_log_info_line()

/proc/report_progress(var/progress_message)
	admin_notice("<span class='boldannounce'>[progress_message]</span>", R_DEBUG)
	to_world_log(progress_message)
	log_world(progress_message)

/mob/proc/simple_info_line()
	return "[key_name(src)] ([x],[y],[z])"

/client/proc/simple_info_line()
	return "[key_name(src)] ([mob.x],[mob.y],[mob.z])"
