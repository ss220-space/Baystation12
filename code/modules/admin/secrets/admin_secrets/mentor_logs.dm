/datum/admin_secret_item/admin_secret/mentor_logs
	name = "Mentor Logs"

/datum/admin_secret_item/admin_secret/mentor_logs/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	var/dat = SPAN_BOLD("Mentor Log<hr>")
	for(var/l in GLOB.mentor_log)
		dat += "<li>[l]</li>"
	if(!GLOB.mentor_log.len)
		dat += "No mentors have done anything this round!"
	var/datum/browser/popup = new(user, "mentor_log", "Mentor Log")
	popup.set_content(dat)
	popup.open()
