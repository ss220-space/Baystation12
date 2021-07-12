/mob/observer/ghost/var/ghost_magic_cd = 0

/datum/antagonist/cultist/proc/add_ghost_magic(var/mob/observer/ghost/M)
	if(max_cult_rating >= CULT_GHOSTS_1)
		M.verbs += /mob/observer/ghost/proc/flick_lights
		M.verbs += /mob/observer/ghost/proc/bloody_doodle
		M.verbs += /mob/observer/ghost/proc/shatter_glass
		M.verbs += /mob/observer/ghost/proc/slice
		if(max_cult_rating >= CULT_GHOSTS_2)
			M.verbs += /mob/observer/ghost/proc/move_item
			M.verbs += /mob/observer/ghost/proc/whisper_to_cultist
			M.verbs += /mob/observer/ghost/proc/bite_someone
			M.verbs += /mob/observer/ghost/proc/chill_someone
			if(max_cult_rating >= CULT_GHOSTS_3)
				M.verbs += /mob/observer/ghost/proc/whisper_to_anyone
				M.verbs += /mob/observer/ghost/proc/bloodless_doodle
				M.verbs += /mob/observer/ghost/proc/toggle_visiblity

/mob/observer/ghost/proc/ghost_ability_check()
	var/turf/T = get_turf(src)
	if(T.holy)
		to_chat(src, "<span class='notice'>Вы не можете использовать свои способности на освященной земле.</span>")
		return 0
	if(ghost_magic_cd > world.time)
		to_chat(src, "<span class='notice'>Вам необходимо подождать еще [round((ghost_magic_cd - world.time) / 10)] перед тем, как использовать свои способности.</span>")
		return 0
	return 1

/mob/observer/ghost/proc/flick_lights()
	set category = "Cult"
	set name = "Мерцание света"
	set desc = "Некоторые лампы начнуть моргать."

	if(!ghost_ability_check())
		return

	for(var/obj/machinery/light/L in range(3))
		L.flicker()

	ghost_magic_cd = world.time + 30 SECONDS

/mob/observer/ghost/proc/bloody_doodle()
	set category = "Cult"
	set name = "Сообщение кровью"
	set desc = "Напишите короткое сообщение кровью на полу или стене. Помните, никакого IC в OOC или OOC в IC."

	bloody_doodle_proc(0)

/mob/observer/ghost/proc/bloody_doodle_proc(var/bloodless = 0)
	if(!ghost_ability_check())
		return

	var/doodle_color = COLOR_BLOOD_HUMAN

	var/turf/simulated/T = get_turf(src)
	if(!istype(T))
		to_chat(src, "<span class='warning'>Неподходящее место.</span>")
		return

	var/num_doodles = 0
	for(var/obj/effect/decal/cleanable/blood/writing/W in T)
		num_doodles++
	if(num_doodles > 4)
		to_chat(src, "<span class='warning'>Недостаточно места для сообщения!</span>")
		return

	var/obj/effect/decal/cleanable/blood/choice
	if(!bloodless)
		var/list/choices = list()
		for(var/obj/effect/decal/cleanable/blood/B in range(1))
			if(B.amount > 0)
				choices += B

		if(!choices.len)
			to_chat(src, "<span class = 'warning'>Рядом нет крови для использования.</span>")
			return

		choice = input(src, "Какую кровь вы бы хотели использовать?") as null|anything in choices
		if(!choice)
			return

		if(choice.basecolor)
			doodle_color = choice.basecolor

	var/max_length = 50

	var/message = sanitize(input("Напишите сообщение. Оно не должно быть длиннее [max_length] символов.", "Сообщение пишется", ""))

	if(!ghost_ability_check())
		return

	if(message && (bloodless || (choice && (choice in range(1)))))
		if(length(message) > max_length)
			message += "-"
			to_chat(src, "<span class='warning'>Недостаточно крови для сообщения!</span>")

		var/obj/effect/decal/cleanable/blood/writing/W = new(T)
		W.basecolor = doodle_color
		W.update_icon()
		W.message = message
		W.add_hiddenprint(src)
		if(!bloodless)
			W.visible_message("<span class='warning'>Невидимые пальцы грубо рисуют что-то кровью на [T].</span>")
		else
			W.visible_message("<span class='warning'>Кровь появляется из ниоткуда, когда невидимые пальцы грубо что то рисуют на [T].</span>")

		log_admin("[src] ([src.key]) used ghost magic to write '[message]' - [x]-[y]-[z]")

	ghost_magic_cd = world.time + 30 SECONDS

/mob/observer/ghost/proc/shatter_glass()
	set category = "Cult"
	set name = "Шум: разбитое стекло"
	set desc = "Издайте звук бьющегося стекла."

	if(!ghost_ability_check())
		return

	playsound(loc, "shatter", 50, 1)

	ghost_magic_cd = world.time + 5 SECONDS

/mob/observer/ghost/proc/slice()
	set category = "Cult"
	set name = "Шум: порез"
	set desc = "Издайте звук удара клинком."

	if(!ghost_ability_check())
		return

	playsound(loc, 'sound/weapons/bladeslice.ogg', 50, 1)

	ghost_magic_cd = world.time + 5 SECONDS

/mob/observer/ghost/proc/move_item()
	set category = "Cult"
	set name = "Подвинуть предмет"
	set desc = "Переместите небольшой предмет туда, где вы находитесь."

	if(!ghost_ability_check())
		return

	var/turf/T = get_turf(src)

	var/list/obj/item/choices = list()
	for(var/obj/item/I in range(1))
		if(I.w_class <= 2)
			choices += I

	if(!choices.len)
		to_chat(src, "<span class='warning'>Поблизости нет подходящих предметов.</span>")
		return

	var/obj/item/choice = input(src, "Какой предмет вы хотите перетащить?") as null|anything in choices
	if(!choice || !(choice in range(1)) || choice.w_class > 2)
		return

	if(!ghost_ability_check())
		return

	if(step_to(choice, T))
		choice.visible_message("<span class='warning'>\[choice] внезапно сдвинулся!</span>")

	ghost_magic_cd = world.time + 60 SECONDS

/mob/observer/ghost/proc/whisper_to_cultist()
	set category = "Cult"
	set name = "Нашептать культисту"
	set desc = "Шепните человеку по вашему выбору. Он не поймет Вас, если только он не культист."

	whisper_proc()

/mob/observer/ghost/proc/whisper_proc(var/anyone = 0)
	if(!ghost_ability_check())
		return

	var/list/mob/living/choices = list()
	for(var/mob/living/M in range(1))
		choices += M

	var/mob/living/choice = input(src, "Кому Вы хотите нашептать?") as null|anything in choices
	if(!choice)
		return

	var/message = sanitize(input("Что Вы хотите нашептать?", "Нашептать", ""))

	if(!ghost_ability_check())
		return

	if(message)
		if(iscultist(choice) || anyone)
			to_chat(choice, "<span class='notice'>Вы слышите слабый шепот... Слышите... \"[message]\"</span>")
			log_and_message_admins("использовал призрачную магию, чтобы сказать '[message]' - [choice] и был услышан - [x]-[y]-[z]")
		else
			to_chat(choice, "<span class='notice'>Вы слышите слабый шепот, но не можете разобрать слов.</span>")
			log_and_message_admins("использовал призрачную магию, чтобы сказать '[message]' - [choice] но не был услышан - [x]-[y]-[z]")
		to_chat(src, "Вы шепчете [choice]. Возможно ваши слова услышаны.")

	ghost_magic_cd = world.time + 100 SECONDS

/mob/observer/ghost/proc/bite_someone()
	set category = "Cult"
	set name = "Укус"
	set desc = "Укусите или поцарапайте кого нибудь."

	if(!ghost_ability_check())
		return

	var/list/mob/living/carbon/human/choices = list()
	for(var/mob/living/carbon/human/H in range(1))
		choices += H

	var/mob/living/carbon/human/choice = input(src, "Кого Вы хотите укусить?") as null|anything in choices
	if(!choice)
		return

	if(!ghost_ability_check())
		return

	var/method = pick("кусает", "царапает")
	to_chat(choice, "<span class='danger'>Что то невидимое [method] Вас!</span>")
	choice.apply_effect(5, PAIN, 0)
	var/method2 = (method == "кусает") ? "кусаете" : "царапаете"
	to_chat(src, "<span class='notice'>Вы [method2] [choice].</span>")

	log_and_message_admins("использовал призрачную магию, чтобы укусить [choice] - [x]-[y]-[z]")

	ghost_magic_cd = world.time + 60 SECONDS

/mob/observer/ghost/proc/chill_someone()
	set category = "Cult"
	set name = "Дрожь"
	set desc = "Пройдите через кого нибудь, заставив его на мгновение почувствовать дрожь загробной жизни."

	if(!ghost_ability_check())
		return

	var/list/mob/living/carbon/human/choices = list()
	for(var/mob/living/carbon/human/H in range(1))
		choices += H

	var/mob/living/carbon/human/choice = input(src, "Кого вы хотите напугать?") as null|anything in choices
	if(!choice)
		return

	if(!ghost_ability_check())
		return

	to_chat(choice, "<span class='danger'>Вы чувствуете, как будто что то холодное прошло сквозь вас!</span>")
	if(choice.bodytemperature >= choice.species.cold_level_1 + 1)
		choice.bodytemperature = max(choice.species.cold_level_1 + 1, choice.bodytemperature - 30)
	to_chat(src, "<span class='notice'>Вы прошли сквозь [choice], заставив их почувствовать внезапную дрожь.</span>")

	log_and_message_admins("used ghost magic to chill \the [choice] - [x]-[y]-[z]")

	ghost_magic_cd = world.time + 60 SECONDS

/mob/observer/ghost/proc/whisper_to_anyone()
	set category = "Cult"
	set name = "Нашептать"
	set desc = "Шепните человеку по вашему выбору."

	whisper_proc(1)

/mob/observer/ghost/proc/bloodless_doodle()
	set category = "Cult"
	set name = "Написать собственной кровью"
	set desc = "Напишите короткое сообщение кровью на полу или стене. Вам не нужна кровь поблизости, чтобы использовать это."

	bloody_doodle_proc(1)

/mob/observer/ghost/proc/toggle_visiblity()
	set category = "Cult"
	set name = "Переключение видимости"
	set desc = "Позволяет становиться видимым или невидимым по желанию."

	if(invisibility && !ghost_ability_check())
		return

	if(invisibility == 0)
		ghost_magic_cd = world.time + 60 SECONDS
		to_chat(src, "<span class='info'>Теперь вы невидимы.</span>")
		visible_message("<span class='emote'>Исчезает из поля зрения...</span>")
		set_invisibility(INVISIBILITY_OBSERVER)
		mouse_opacity = 1
	else
		ghost_magic_cd = world.time + 60 SECONDS
		to_chat(src, "<span class='info'>Теперь вы видимы.</span>")
		set_invisibility(0)
		mouse_opacity = 0 // This is so they don't make people invincible to melee attacks by hovering over them
