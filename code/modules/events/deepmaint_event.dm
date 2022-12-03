/datum/event/deepmaint
	announceWhen = 10
	var/list/free_deepmaint_ladders_copy = list()
	var/list/spawned_ladders = list()


/datum/event/deepmaint/setup()
	endWhen = rand(1500, 3500)

/datum/event/deepmaint/start()
	var/attempts = 5
	free_deepmaint_ladders_copy = free_deepmaint_ladders.Copy()
	do
		if (!free_deepmaint_ladders_copy.len)
			break

		create_deepmaint_ladder_connection()

	while(--attempts > 0)

	if(spawned_ladders.len == 0)
		log_debug("Failed to spawn any ladders for deepmaint event. Aborting.")
		kill(TRUE)

/datum/event/deepmaint/end()
	for (var/obj/structure/ladder/updown/L in spawned_ladders)
		L.target_down = null
		L.target_up = null
		L.visible_message(SPAN_WARNING("\The [L] внезапно исчезает у вас на глазах!"))
		qdel(L)

	command_announcement.Announce("Все подпространственные искажения прекратились. Весь персонал и/или имущество, отсутствующие на борту, следует считать потерянными.")


/datum/event/deepmaint/announce()
	command_announcement.Announce("Обнаружены экстремальные подпространственные аномалии. Убедитесь, что все люди и имущество находятся на своих местах.", "[location_name()] Spooky Sensor Network", zlevels = affecting_z)

/datum/event/deepmaint/proc/create_deepmaint_ladder_connection()
	var/area/location = pick_area(list(/proc/is_not_space_area, /proc/is_station_area, /proc/is_maint_area))
	if(!location)
		log_debug("Could not find suitable location(s) to spawn ladders to deepmaint. Aborting.")
		kill()
		return FALSE

	var/list/ladder_turfs = get_area_turfs(location, list(/proc/not_turf_contains_dense_objects, /proc/IsTurfAtmosSafe))
	if(!ladder_turfs.len)
		log_debug("Failed to find viable turfs to spawn ladders in \the [location].")
		return FALSE

	var/turf/station_turf = pick(ladder_turfs)
	var/turf/deepmaint_turf = pick(free_deepmaint_ladders_copy)
	free_deepmaint_ladders_copy -= deepmaint_turf
	var/obj/structure/ladder/updown/station_ladder = new (station_turf)
	var/obj/structure/ladder/updown/deepmaint_ladder = new (deepmaint_turf)
	station_ladder.desc = "[station_ladder.desc] Эта кажется... не на своем месте."
	station_ladder.target_down = deepmaint_ladder
	deepmaint_ladder.target_down = station_ladder
	spawned_ladders += station_ladder
	spawned_ladders += deepmaint_ladder

	return TRUE
