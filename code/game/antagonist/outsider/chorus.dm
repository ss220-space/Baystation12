GLOBAL_DATUM_INIT(chorus, /datum/antagonist/chorus, new)

/datum/antagonist/chorus
	id = MODE_DEITY
	role_text = "Chorus"
	role_text_plural = "Chorus"
	welcome_text = "Ты один из многих! Используй это судно как жилище. Взрасти Рой и проложи путь для нового потомства. \
	Общайся с другими из Роя, используя функции чата."
	landmark_id = "xeno_spawn"

	flags = ANTAG_OVERRIDE_MOB | ANTAG_OVERRIDE_JOB
	mob_path = /mob/living/carbon/alien/chorus

	hard_cap = 10
	hard_cap_round = 10
	initial_spawn_req = 1
	initial_spawn_target = 3
	skill_setter = null // we are a flesh beast and do not use skills
