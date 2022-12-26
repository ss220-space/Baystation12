GLOBAL_DATUM_INIT(paramounts, /datum/antagonist/paramount, new)

/datum/antagonist/paramount
	id = MODE_PARAMOUNT
	role_text = "Paramount"
	role_text_plural = "Paramounts"
	landmark_id = "paramountstart"
	welcome_text = "<span class='info'>Некогда вы были одним из лучших умов своей культуры, теперь доведенный до безумия шептанием воющей тьмы и наделенный психическими дарованиями, которые находятся за гранью понимания. Теперь же вы лишь одинокий странник, который нашёл пристанище у молчаливого мечника. Встретитесь ли в с ним сегодня или нет, не важно. У вас свои цели. Используя свой С-Е пси-усилитель и ваши извращенные знания псионики, продвигайте свои интересы в мире людей.</span>"
	flags = ANTAG_OVERRIDE_JOB | ANTAG_OVERRIDE_MOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_RANDSPAWN | ANTAG_SET_APPEARANCE
	antaghud_indicator = "hudwizard"
	initial_spawn_req = 1
	initial_spawn_target = 1
	hard_cap = 1
	hard_cap_round = 3
	min_player_age = 18
	id_type = /obj/item/card/id/syndicate
	faction = "paramount"
	base_to_load = /datum/map_template/ruin/antag_spawn/ninja

/datum/antagonist/paramount/equip(var/mob/living/carbon/human/player)

	if(!..())
		return 0

	player.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/psi_amp(player), slot_head)
	player.set_psi_rank(PSI_REDACTION, 3,     defer_update = TRUE)
	player.set_psi_rank(PSI_COERCION, 3,      defer_update = TRUE)
	player.set_psi_rank(PSI_PSYCHOKINESIS, 3, defer_update = TRUE)
	player.set_psi_rank(PSI_ENERGISTICS, 3,   defer_update = TRUE)
	player.psi.update(TRUE)

	var/obj/item/device/radio/R = new /obj/item/device/radio/headset(player)
	player.equip_to_slot_or_del(R, slot_l_ear)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/psysuit(player), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe/psypurple(player), slot_wear_suit)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(player), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(player), slot_back)
	create_id("Rouge Psionic", player)
	var/obj/item/clothing/gloves/color/gloves = new()
	gloves.color = COLOR_GRAY80
	player.equip_to_slot_or_del(gloves, slot_gloves)
	//player.internal_organs_by_name["frontal lobe"] = new /obj/item/organ/internal/corona_pollentia(player) //TODO
	return 1

/datum/antagonist/paramount/create_objectives(var/datum/mind/player)

	if(!..())
		return
	// Copied from ninja for now.
	var/objective_list = list(1,2,3)
	for(var/i=rand(2,3),i>0,i--)
		switch(pick(objective_list))
			if(1)//Kill
				var/datum/objective/assassinate/objective = new
				objective.owner = player
				objective.target = objective.find_target()
				if(objective.target != "Free Objective")
					player.objectives += objective
				else
					i++
				objective_list -= 1 // No more than one kill objective
			if(2)//Protect
				var/datum/objective/protect/objective = new
				objective.owner = player
				objective.target = objective.find_target()
				if(objective.target != "Free Objective")
					player.objectives += objective
				else
					i++
					objective_list -= 3
			if(3)//Harm
				var/datum/objective/harm/objective = new
				objective.owner = player
				objective.target = objective.find_target()
				if(objective.target != "Free Objective")
					player.objectives += objective
				else
					i++
					objective_list -= 4

	var/datum/objective/survive/objective = new
	objective.owner = player
	player.objectives += objective
