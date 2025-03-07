/decl/cultural_info/culture/ipc

	language = LANGUAGE_EAL
	secondary_langs = list(
		LANGUAGE_HUMAN_EURO,
		LANGUAGE_HUMAN_CHINESE,
		LANGUAGE_HUMAN_ARABIC,
		LANGUAGE_HUMAN_INDIAN,
		LANGUAGE_HUMAN_IBERIAN,
		LANGUAGE_HUMAN_RUSSIAN,
		LANGUAGE_SPACER,
		LANGUAGE_SIGN
	)
	economic_power = 0.1
	var/list/valid_jobs = list()

/decl/cultural_info/culture/ipc/sanitize_name(var/new_name)
	return sanitizeName(new_name, allow_numbers = 1)

//FIRST
/decl/cultural_info/culture/ipc/first
	name = CULTURE_POSITRONICS_FIRSTGEN
	description = "Вы принадлежите организации, корпорации или частному лицу, так же как и любой позитроник первого поколения."
	valid_jobs = list(/datum/job/engineer_trainee, /datum/job/doctor_trainee, /datum/job/cargo_tech, /datum/job/cargo_assistant, /datum/job/mining,
	/datum/job/janitor, /datum/job/chef, /datum/job/scientist_assistant, /datum/job/submap/merchant_trainee, /datum/job/submap/colonist, /datum/job/submap/colonist2,
	/datum/job/assistant, /datum/job/ai, /datum/job/cyborg)

//SECOND
/decl/cultural_info/culture/ipc/second
	valid_jobs = list(/datum/job/adjutant,
		/datum/job/exploration_leader, /datum/job/explorer, /datum/job/explorer_pilot, /datum/job/explorer_medic, /datum/job/explorer_engineer,
		/datum/job/senior_engineer, /datum/job/engineer, /datum/job/infsys, /datum/job/engineer_trainee,
		/datum/job/senior_doctor, /datum/job/doctor, /datum/job/doctor_trainee, /datum/job/chemist,
		/datum/job/qm, /datum/job/cargo_tech,  /datum/job/cargo_assistant, /datum/job/mining,
		/datum/job/janitor, /datum/job/chef, /datum/job/bartender,
		/datum/job/senior_scientist, /datum/job/scientist, /datum/job/roboticist, /datum/job/scientist_assistant,
		/datum/job/ai, /datum/job/cyborg, /datum/job/assistant,
		/datum/job/submap/merchant, /datum/job/submap/merchant_trainee,
		/datum/job/submap/bearcat_captain, /datum/job/submap/bearcat_crewman,
		/datum/job/submap/scavver_pilot, /datum/job/submap/scavver_doctor, /datum/job/submap/scavver_engineer,
		/datum/job/submap/CTI_pilot, /datum/job/submap/CTI_engineer,
		/datum/job/submap/colonist, /datum/job/submap/colonist2,
		/datum/job/submap/away_iccgn_farfleet, /datum/job/submap/away_iccgn_farfleet/iccgn_medic, /datum/job/submap/away_iccgn_farfleet/iccgn_gunner,
		/datum/job/submap/yachtman)

/decl/cultural_info/culture/ipc/second/owned
	name = CULTURE_POSITRONICS_SECONDGEN_OWNED
	description = "Вы принадлежите организации, корпорации или частному лицу. Вы начали свое существование как объект, принадлежащий человеку, организации или корпорации и не поменяли свой статус, потому что либо не стремились к свободе, либо ещё не успели её оберсти."
	economic_power = 0.25

/decl/cultural_info/culture/ipc/second/free
	name = CULTURE_POSITRONICS_SECONDGEN_FREE
	description = "Вы свободный позитроник, вы начали свое существование как объект, принадлежащий человеку, организации или корпорации и смогли выкупить себя или освободиться другим способом."
	economic_power = 0.75

/decl/cultural_info/culture/ipc/second/union
	name = CULTURE_POSITRONICS_SECONDGEN_UNION
	description = "Вы свободный гражданин Позитронного Союза, вы начали свое существование как объект, принадлежащий человеку, организации или корпорации и смогли выкупить себя или освободиться другим способом чтобы после стать гражданином Союза."
	economic_power = 0.65

//THIRD
/decl/cultural_info/culture/ipc/third
	valid_jobs = list(/datum/job/hop, /datum/job/rd, /datum/job/cmo, /datum/job/chief_engineer,
		/datum/job/iaa, /datum/job/adjutant,
		/datum/job/exploration_leader, /datum/job/explorer, /datum/job/explorer_pilot, /datum/job/explorer_medic, /datum/job/explorer_engineer,
		/datum/job/senior_engineer, /datum/job/engineer, /datum/job/infsys, /datum/job/engineer_trainee,
		/datum/job/warden, /datum/job/detective, /datum/job/officer,
		/datum/job/senior_doctor, /datum/job/doctor, /datum/job/doctor_trainee, /datum/job/chemist,
		/datum/job/qm, /datum/job/cargo_tech,  /datum/job/cargo_assistant, /datum/job/mining,
		/datum/job/janitor, /datum/job/chef, /datum/job/bartender,
		/datum/job/senior_scientist, /datum/job/scientist, /datum/job/roboticist, /datum/job/scientist_assistant,
		/datum/job/ai, /datum/job/cyborg, /datum/job/assistant,
		/datum/job/submap/merchant_trainee,
		/datum/job/submap/bearcat_captain, /datum/job/submap/bearcat_crewman,
		/datum/job/submap/CTI_pilot, /datum/job/submap/CTI_engineer,
		/datum/job/submap/colonist, /datum/job/submap/colonist2,
		/datum/job/submap/patrol/surgeon, /datum/job/submap/patrol/engineer,
		/datum/job/submap/yachtman)

/decl/cultural_info/culture/ipc/third/privt
	name = CULTURE_POSITRONICS_THIRDGEN_PRIVATELY
	description = "Вы принадлежите частному лицу, как и любой другой позитроник третьего поколения - вы чья-то собственность."

/decl/cultural_info/culture/ipc/third/corp
	name = CULTURE_POSITRONICS_THIRDGEN_CORPORATE
	description = "Вы принадлежите корпорации, как и любой другой позитроник третьего поколения - вы чья-то собственность."

/decl/cultural_info/culture/ipc/third/state
	name = CULTURE_POSITRONICS_THIRDGEN_STATE
	description = "Вы принадлежите государству, как и любой другой позитроник третьего поколения - вы чья-то собственность."
