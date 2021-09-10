/obj/structure/cult
	density = TRUE
	anchored = TRUE
	icon = 'icons/obj/cult.dmi'

/obj/structure/cult/talisman
	name = "Алтарь"
	desc = "Окровавленный алтарь, посвященный Нар-Си."
	icon_state = "talismanaltar"


/obj/structure/cult/forge
	name = "Демоническая кузня"
	desc = "Кузница, используемая для изготовления нечестивого оружия, используемого армиями Нар-Си."
	icon_state = "forge"

/obj/structure/cult/pylon
	name = "Стела"
	desc = "Парящий кристалл, гудящий от неземной энергии."
	icon = 'icons/obj/pylon.dmi'
	icon_state = "pylon"
	light_max_bright = 0.5
	light_inner_range = 1
	light_outer_range = 13
	light_color = "#3e0000"
	var/health = 20
	var/maxhealth = 20

/obj/structure/cult/pylon/attackby(obj/item/W, mob/user)
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	if (istype(W, /obj/item/natural_weapon/cult_builder))
		if (health >= maxhealth)
			to_chat(user, SPAN_WARNING("[src] полностью восстановлена."))
		else
			user.visible_message(
				SPAN_NOTICE("[user] заделывает некоторые трещины на [src]."),
				SPAN_NOTICE("Вы исправляете часть повреждений [src].")
			)
			health = min(maxhealth, health + 5)
		return
	user.do_attack_animation(src)
	if (W.force < 4)
		user.visible_message(
			SPAN_DANGER("[user] ударяет [src]не нанеся никаких видимых повреждений!"),
			SPAN_DANGER("Вы ударили [src] не нанеся никаких видимых повреждений!"),
			SPAN_WARNING("Вы слышите, как чем то бьют по толстому стеклу.")
		)
		playsound(get_turf(src), 'sound/effects/Glasshit.ogg', 50, TRUE)
		return
	health = max(0, health - W.force)
	if(!health)
		user.visible_message(
			SPAN_DANGER("[user] разбивает [src]!"),
			SPAN_DANGER("Вы разбиваете [src] на кусочки!"),
			SPAN_WARNING("Вы слышите как разбивается стекло и разлетаются осколки.")
		)
		playsound(get_turf(src), 'sound/effects/Glassbr3.ogg', 75, TRUE)
		qdel(src)
	else
		user.visible_message(
			SPAN_DANGER("[user] бьет [src]!"),
			SPAN_DANGER("Вы бьете [src]!"),
			SPAN_WARNING("Вы слышите, как чем то бьют по толстому стеклу.")
		)
		playsound(get_turf(src), 'sound/effects/Glasshit.ogg', 75, TRUE)

/obj/structure/cult/tome
	name = "Аналой"
	desc = "Аналой, заваленный таинственными рукописями и фолиантами на неизвестных языках. От одного взгляда на текст у Вас бегут мурашки по коже."
	icon_state = "tomealtar"
	light_color = "#ed9200"
	light_outer_range = 3
	light_color= "ed9200"

//sprites for this no longer exist	-Pete
//(they were stolen from another game anyway)
/*
/obj/structure/cult/pillar
	name = "Pillar"
	desc = "This should not exist."
	icon_state = "pillar"
	icon = 'magic_pillar.dmi'
*/

/obj/effect/gateway
	name = "Портал"
	desc = "Вы почти уверены, что бездна смотрит в ответ."
	icon = 'icons/obj/cult.dmi'
	icon_state = "hole"
	density = TRUE
	unacidable = TRUE
	anchored = TRUE
	var/spawnable = null

/obj/effect/gateway/active
	light_outer_range=5
	light_color="#ff0000"
	spawnable=list(
		/mob/living/simple_animal/hostile/scarybat,
		/mob/living/simple_animal/hostile/creature,
		/mob/living/simple_animal/hostile/faithless
	)

/obj/effect/gateway/active/cult
	light_max_bright	= 0.5
	light_inner_range	= 2
	light_outer_range	= 5
	light_color			= "#ff0000"
	spawnable=list(
		/mob/living/simple_animal/hostile/scarybat/cult,
		/mob/living/simple_animal/hostile/creature/cult,
		/mob/living/simple_animal/hostile/faithless/cult
	)

/obj/effect/gateway/active/New()
	..()
	addtimer(CALLBACK(src, .proc/create_and_delete), rand(30,60) SECONDS)


/obj/effect/gateway/active/proc/create_and_delete()
	var/t = pick(spawnable)
	new t(src.loc)
	qdel(src)

/obj/effect/gateway/active/Crossed(var/atom/A)
	if(!istype(A, /mob/living))
		return

	var/mob/living/M = A

	if(M.stat != DEAD)
		if(M.HasMovementHandler(/datum/movement_handler/mob/transformation))
			return
		if(M.has_brain_worms())
			return //Borer stuff - RR

		if(iscultist(M)) return
		if(!ishuman(M) && !isrobot(M)) return

		M.AddMovementHandler(/datum/movement_handler/mob/transformation)
		M.icon = null
		M.overlays.len = 0
		M.set_invisibility(101)

		if(istype(M, /mob/living/silicon/robot))
			var/mob/living/silicon/robot/Robot = M
			if(Robot.mmi)
				qdel(Robot.mmi)
		else
			for(var/obj/item/W in M)
				M.drop_from_inventory(W)
				if(istype(W, /obj/item/implant))
					qdel(W)

		var/mob/living/new_mob = new /mob/living/simple_animal/friendly/corgi(A.loc)
		new_mob.a_intent = I_HURT
		if(M.mind)
			M.mind.transfer_to(new_mob)
		else
			new_mob.key = M.key

		to_chat(new_mob, "<B>Вы превращаетесь в корги.</B>")//Потому что у нас нет клувунов
