/datum/station_trait/exploration_grant
	name = "Exploration Grant"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Ваш корабль был выбран для получения специального гранта. Дополнительные очки будут отправлены в ваш отдел снабжения."

/datum/station_trait/exploration_grant/on_round_start()
	SSsupply.points *= 2 // Normally you have 50.

/datum/station_trait/quick_shuttle
	name = "Quick Shuttle"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Благодаря близости к нашей ближайшей станции снабжения, ваш шаттл снабжения будет иметь более быстрое время доставки."
	blacklist = list(/datum/station_trait/slow_shuttle)

/datum/station_trait/quick_shuttle/on_round_start()
	SSsupply.movetime = 900

/datum/station_trait/premium_crewbox
	name = "Premium Survival Boxes"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Crew survival boxes оснащены дополнительным оборудованием."
