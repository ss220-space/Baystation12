/datum/station_trait/slow_shuttle
	name = "Slow Shuttle"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Из-за отдаленности до станции снабжения, доставка грузов на шаттле замедленна."
	blacklist = list(/datum/station_trait/quick_shuttle)

/datum/station_trait/slow_shuttle/on_round_start()
	SSsupply.movetime = 1500

/datum/station_trait/disabled_lighting
	name = "Overloaded Lighting"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Корабль пережил легкий электрический шторм, и поэтому некоторые лампы могут потребовать замены."

/datum/station_trait/disabled_lighting/on_round_start()
	for(var/obj/machinery/power/apc/C in SSmachines.machinery)
		if(!C.is_critical && (C.z in GLOB.using_map.station_levels))
			C.overload_lighting(25) // Every fourth light

/datum/station_trait/cargo_penalty
	name = "Cargo Penalty"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 3
	show_in_report = TRUE
	report_message = "Ваш корабль израсходовал квоту снабжения, количество очков снабжения - урезано."

/datum/station_trait/cargo_penalty/on_round_start()
	SSsupply.points *= 0.5 // Normally you have 50.


/datum/station_trait/cargo_highcost
	name = "Cargo Highcost"
	trait_type = STATION_TRAIT_NEGATIVE
	weight = 3
	show_in_report = TRUE
	report_message = "В связи с изменением цен на товары, стоимость заказов пересмотрена - сверьтесь с прайсом"
	blacklist = list(/datum/station_trait/cargo_lowcost)

/datum/station_trait/cargo_highcost/on_round_start()
	var/costamp = pick(1.3,1.4,1.5,1.6,1.8,1.9,2,2.1)
	SSsupply.pack_price_modifier *= costamp
