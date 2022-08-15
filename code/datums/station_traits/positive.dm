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
	report_message = "Близкое расположение нашей станции снабжения, позволяет быстрее доставлять грузы на шаттле."
	blacklist = list(/datum/station_trait/slow_shuttle)

/datum/station_trait/quick_shuttle/on_round_start()
	SSsupply.movetime = 900

/datum/station_trait/premium_crewbox
	name = "Premium Survival Boxes"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Crew survival boxes оснащенные дополнительным оборудованием."

/datum/station_trait/cargo_lowcost
	name = "Cargo Lowcost"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	show_in_report = TRUE
	report_message = "В связи с изменением цен на товары, стоимость заказов пересмотрена - сверьтесь с прайсом"
	blacklist = list(/datum/station_trait/cargo_highcost)

/datum/station_trait/cargo_lowcost/on_round_start()
	var/costamp = pick(0.9,0.8)
	SSsupply.pack_price_modifier *= costamp
