/mob/living/MouseDrop(atom/over)
	if(usr == src && usr != over)
		if(istype(over, /mob/living/exosuit))
			var/mob/living/exosuit/exosuit = over
			if(exosuit.body)
				if(usr.mob_size >= exosuit.body.min_pilot_size && usr.mob_size <= exosuit.body.max_pilot_size \
				&& !issilicon(usr)) //INF
					if(exosuit.enter(src))
						return
				else
					to_chat(usr, SPAN_WARNING("You cannot pilot a exosuit of this size."))
					return
	return ..()

/mob/living/exosuit/MouseDrop_T(atom/dropping, mob/user)
	var/obj/machinery/portable_atmospherics/canister/C = dropping
	if(istype(C))
		body.MouseDrop_T(dropping, user)
	else . = ..()

/mob/living/exosuit/MouseDrop(mob/living/carbon/human/over_object) //going from assumption none of previous options are relevant to exosuit
	if(body)
		if(!body.MouseDrop(over_object))
			return ..()

/mob/living/exosuit/RelayMouseDrag(src_object, over_object, src_location, over_location, src_control, over_control, params, var/mob/user)
	if(user && (user in pilots) && user.loc == src)
		return OnMouseDrag(src_object, over_object, src_location, over_location, src_control, over_control, params, user)
	return ..()

/mob/living/exosuit/OnMouseDrag(src_object, over_object, src_location, over_location, src_control, over_control, params, var/mob/user)
	if(!user || incapacitated() || user.incapacitated())
		return FALSE

	if(!(user in pilots) && user != src)
		return FALSE

	//This is handled at active module level really, it is the one who has to know if it's supposed to act
	if(selected_system)
		return selected_system.MouseDragInteraction(src_object, over_object, src_location, over_location, src_control, over_control, params, user)

/datum/click_handler/default/mech/OnClick(var/atom/A, var/params)
	var/mob/living/exosuit/E = user.loc
	if(!istype(E))
		//If this happens something broke tbh
		user.RemoveClickHandler(src)
		return
	if(E.hatch_closed)
		return E.ClickOn(A, params, user)
	else return ..()

/datum/click_handler/default/mech/OnDblClick(var/atom/A, var/params)
	OnClick(A, params)

/mob/living/exosuit/allow_click_through(atom/A, params, mob/user)
	if(LAZYISIN(pilots, user) && !hatch_closed)
		return TRUE
	. = ..()

//UI distance checks
/mob/living/exosuit/contents_nano_distance(src_object, mob/living/user)
	. = ..()
	if(!hatch_closed)
		return max(shared_living_nano_distance(src_object), .) //Either visible to mech(outside) or visible to user (inside)


/mob/living/exosuit/ClickOn(var/atom/A, var/params, var/mob/user)
	if(!user || incapacitated() || user.incapacitated())
		return
	var/arms_chosen = FALSE
	var/body_chosen = FALSE
	if(selected_hardpoint == HARDPOINT_LEFT_HAND || selected_hardpoint == HARDPOINT_RIGHT_HAND)
		arms_chosen = TRUE
		body_chosen = FALSE
	else if(selected_hardpoint == HARDPOINT_BACK || selected_hardpoint == HARDPOINT_HEAD || selected_hardpoint == HARDPOINT_LEFT_SHOULDER || selected_hardpoint == HARDPOINT_RIGHT_SHOULDER)
		arms_chosen = FALSE
		body_chosen = TRUE

	if(!loc) return
	var/adj = A.Adjacent(src) // Why in the fuck isn't Adjacent() commutative.

	var/modifiers = params2list(params)
	if(modifiers["shift"])
		user.examinate(A)
		return

	if(modifiers["ctrl"])
		if(selected_system)
			if(selected_system == A)
				selected_system.CtrlClick(user)
				setClickCooldown(3)
			return

	if(!(user in pilots) && user != src)
		return

	if(!canClick())
		return

	// Are we facing the target?
	if(A.loc != src && !(get_dir(src, A) & dir))
		return

	if(!arms && arms_chosen)
		to_chat(user, SPAN_WARNING("\The [src] has no manipulators!"))
		setClickCooldown(3)
		return

	if(!arms.motivator && arms_chosen)
		to_chat(user, SPAN_WARNING("Your motivators are damaged! You can't use your manipulators!"))
		setClickCooldown(15)
		return
	if((!body || body.total_damage >= body.max_damage) && body_chosen)
		to_chat(user, SPAN_WARNING("Your cockpit too damaged, additional hardpoints control system damaged, you cant this module!"))
		setClickCooldown(15)
		return

	if(!get_cell()?.checked_use(arms.power_use * CELLRATE))
		to_chat(user, power == MECH_POWER_ON ? SPAN_WARNING("Error: Power levels insufficient.") :  SPAN_WARNING("\The [src] is powered off."))
		return

	// User is not necessarily the exosuit, or the same person, so update intent.
	if(user != src)
		a_intent = user.a_intent
		if(user.zone_sel)
			zone_sel.set_selected_zone(user.zone_sel.selecting)
		else
			zone_sel.set_selected_zone(BP_CHEST)
	// You may attack the target with your exosuit FIST if you're malfunctioning.
	var/atom/movable/AM = A
	var/fail_prob = (user != src && istype(AM) && AM.loc != src) ? (user.skill_check(SKILL_MECH, HAS_PERK) ? 0: 15 ) : 0
	var/failed = FALSE
	if(prob(fail_prob))
		to_chat(user, SPAN_DANGER("Your incompetence leads you to target the wrong thing with the exosuit!"))
		failed = TRUE
	else if(emp_damage > EMP_ATTACK_DISRUPT && prob(emp_damage*2))
		to_chat(user, SPAN_DANGER("The wiring sparks as you attempt to control the exosuit!"))
		failed = TRUE

	if(!failed)
		if(selected_system)
			if(selected_system == A)
				selected_system.attack_self(user)
				setClickCooldown(5)
				return

			// Mounted non-exosuit systems have some hacky loc juggling
			// to make sure that they work.
			var/system_moved = FALSE
			var/obj/item/temp_system
			var/obj/item/mech_equipment/ME
			if(istype(selected_system, /obj/item/mech_equipment))
				ME = selected_system
				temp_system = ME.get_effective_obj()
				if(temp_system in ME)
					system_moved = 1
					temp_system.forceMove(src)
			else
				temp_system = selected_system

			// Slip up and attack yourself maybe.
			failed = FALSE
			if(prob(fail_prob))
				to_chat(user, SPAN_DANGER("You artlessly shove the exosuit controls the wrong way!"))
				failed = TRUE
			else if(emp_damage>EMP_MOVE_DISRUPT && prob(10))
				failed = TRUE

			if(failed)
				var/list/other_atoms = orange(1, A)
				A = null
				while(LAZYLEN(other_atoms))
					var/atom/picked = pick_n_take(other_atoms)
					if(istype(picked) && picked.simulated)
						A = picked
						break
				if(!A)
					A = src
				adj = A.Adjacent(src)

			var/resolved

			if(adj) resolved = temp_system.resolve_attackby(A, src, params)
			if(!resolved && A && temp_system)
				var/mob/ruser = src
				if(!system_moved) //It's more useful to pass along clicker pilot when logic is fully mechside
					ruser = user
				temp_system.afterattack(A,ruser,adj,params)
			if(system_moved) //We are using a proxy system that may not have logging like mech equipment does
				admin_attack_log(user, A, "Attacked using \a [temp_system] (MECH)", "Was attacked with \a [temp_system] (MECH)", "used \a [temp_system] (MECH) to attack")
			//Mech equipment subtypes can add further click delays
			var/extra_delay = 0
			if(!isnull(selected_system))
				ME = selected_system
				extra_delay = ME.equipment_delay
			setClickCooldown(arms ? arms.action_delay + extra_delay : 15 + extra_delay)
			if(system_moved)
				temp_system.forceMove(selected_system)
			return
//Attack by mech fist system
	if(A == src)
		setClickCooldown(5)
		return attack_self(user)
	else if(adj && user.a_intent == I_HURT && arms.motivator)
		setClickCooldown(arms ? arms.action_delay : 7)
		src.visible_message(SPAN_DANGER(" [src] steps back, preparing for a punch!"), blind_message = SPAN_DANGER("You hear the loud hissing of hydraulics!"))
		playsound(src.loc, mech_step_sound, 60, 1)
		var/target_prev_loc = A.loc
		if(do_after(src, 1.2 SECONDS, get_turf(src), DO_DEFAULT|DO_USER_UNIQUE_ACT|DO_PUBLIC_PROGRESS) && user)
			if(target_prev_loc != A.loc)
				src.visible_message(SPAN_DANGER(" [src] misses with his attack!"))
				do_attack_effect(target_prev_loc, "smash")
				setClickCooldown(arms ? arms.action_delay : 7)
				playsound(src.loc, arms_punch_sound, 50, 1)
				return
			if(istype(A, /obj/machinery/door/firedoor) )
				var/obj/machinery/door/firedoor/FD = A
				if(!FD.blocked)
					setClickCooldown(arms ? arms.action_delay : 7)
					addtimer(CALLBACK(FD, /obj/machinery/door/firedoor.proc/toggle, TRUE), 0)
					return
				return
			else if((istype(A, (/turf/simulated/wall/r_wall))) || (istype(A,/turf/simulated/wall/r_titanium)))
				setClickCooldown(arms ? arms.action_delay : 7)
				to_chat(user, SPAN_NOTICE("This structure too reinforced for being damaged by [src]!"))
				return
			else if((istype(A, /obj/machinery/door/blast)))
				var/obj/machinery/door/blast/FD = A
				if(((FD.stat & NOPOWER) || (FD.stat & BROKEN)) && !( FD.operating ))
					setClickCooldown(arms ? arms.action_delay : 7)
					addtimer(CALLBACK(FD, /obj/machinery/door/blast.proc/force_toggle, TRUE), 0)
					return
				if(istype(A,/obj/machinery/door/blast/regular))
					to_chat(user, SPAN_NOTICE("This structure too reinforced for being damaged by [src]!"))
					return
				do_attack_effect(A, "smash")
				setClickCooldown(arms ? arms.action_delay : 7)
				playsound(src.loc, arms_punch_sound, 50, 1)
				return A.attack_generic(src,(arms.melee_damage*2),"forcefully strikes")
			else if((istype(A, /obj/machinery/door)))
				var/obj/machinery/door/airlock/FD = A
				if(FD.anchored && !FD.arePowerSystemsOn() && !FD.locked && (istype(A, /obj/machinery/door) || istype(A,/obj/machinery/door/blast)))
					setClickCooldown(arms ? arms.action_delay : 7)
					addtimer(CALLBACK(FD, /obj/machinery/door/.proc/toggle, TRUE), 0)
					return
				do_attack_effect(A, "smash")
				setClickCooldown(arms ? arms.action_delay : 7)
				playsound(loc, 'sound/weapons/tablehit1.ogg', 40, 1)
				playsound(src.loc, arms_punch_sound, 50, 1)
				return A.attack_generic(src, arms.melee_damage, "trying to force the airlock with its arms, damages motors ")
			else if( istype(A, (/obj/structure)) || (istype(A, /obj/machinery)))
				do_attack_effect(A, "smash")
				setClickCooldown(arms ? arms.action_delay : 7)
				playsound(loc, 'sound/weapons/tablehit1.ogg', 40, 1)
				playsound(src.loc, arms_punch_sound, 50, 1)
				return A.attack_generic(src, arms.melee_damage, "after striking the [A], the combat exosuit forcefully pulls out a section of ")
			else if(istype(A, /turf/simulated/wall)  )
				do_attack_effect(A, "smash")
				setClickCooldown(arms ? arms.action_delay : 7)
				playsound(src.loc, arms_punch_sound, 50, 1)
				return A.attack_generic(src, arms.melee_damage, "after striking the [A], the combat exosuit forcefully pulls out a section of ",BRUTE)
			else if(adj && user.a_intent == I_HURT)
				do_attack_effect(A, "smash")
				setClickCooldown(arms ? arms.action_delay : 7)
				playsound(src.loc, arms_punch_sound, 50, 1)
				return A.attack_generic(src, arms.melee_damage, "punch",BRUTE)
	else if(istype(A, /obj/structure/ladder))
		var/obj/structure/ladder/L = A
		L.climb(src) //Those are some real sturdy ladders.
	return

/mob/living/exosuit/proc/set_hardpoint(var/hardpoint_tag)
	clear_selected_hardpoint()
	if(hardpoints[hardpoint_tag])
		// Set the new system.
		selected_system = hardpoints[hardpoint_tag]
		selected_hardpoint = hardpoint_tag
		return 1 // The element calling this proc will set its own icon.
	return 0

/mob/living/exosuit/proc/clear_selected_hardpoint()

	if(selected_hardpoint)
		for(var/hardpoint in hardpoints)
			if(hardpoint != selected_hardpoint)
				continue
			var/obj/screen/movable/exosuit/hardpoint/H = hardpoint_hud_elements[hardpoint]
			if(istype(H))
				H.icon_state = "hardpoint"
				break
		selected_system = null
	selected_hardpoint = null

/mob/living/exosuit/proc/check_enter(var/mob/user)
	if(!user || user.incapacitated())
		return FALSE
	if(!user.Adjacent(src))
		return FALSE
	if(hatch_locked)
		check_passenger(user) // <- Если кабина закрыта - игрок пытается занять пассажирку
		return FALSE
	if(hatch_closed)
		check_passenger(user) // <- Если кабина закрыта - игрок пытается занять пассажирку
		return FALSE
	if(LAZYLEN(pilots) >= LAZYLEN(body.pilot_positions))
		to_chat(user, SPAN_WARNING("\The [src] is occupied to capacity."))
		return FALSE
	var/local_dir = get_dir(src, user) // <- Узнаём направление от меха до пули
	if(local_dir == turn(dir, 0) || local_dir == turn(dir, 45) || local_dir == turn(dir, -45) || local_dir == turn(dir, 90) || local_dir == turn(dir, -90))
	// B B B
	// G M G  ↓ (Mech dir, look on SOUTH)
	// G G G
	// M - mech, B - cant climb IN mech from this side, G - can climb in mech from this side
		return TRUE
	else
		to_chat(user, SPAN_WARNING("You cant climb in [src ] from this side."))
		return FALSE

/mob/living/exosuit/proc/enter(var/mob/user)
	if(!check_enter(user))
		return
	to_chat(user, SPAN_NOTICE("You start climbing into \the [src]..."))
	if(!body || !do_after(user, body.climb_time))
		return
	if(!body)
		return
	if(!check_enter(user))
		return
	to_chat(user, SPAN_NOTICE("You climb into \the [src]."))
	user.forceMove(src)
	LAZYDISTINCTADD(pilots, user)
	sync_access()
	playsound(src, 'sound/machines/windowdoor.ogg', 50, 1)
	if(user.client) user.client.screen |= hud_elements
	LAZYDISTINCTADD(user.additional_vision_handlers, src)
	update_pilots()
	user.PushClickHandler(/datum/click_handler/default/mech)
	return 1

/mob/living/exosuit/proc/check_passenger(var/mob/user) // Выбираем желаемое место, проверяем можно ли его занять, стартуем прок занятия
	var/local_dir = get_dir(src, user)
	if(local_dir != turn(dir, 90) && local_dir != turn(dir, -90) && local_dir != turn(dir, -135) && local_dir != turn(dir, 135) && local_dir != turn(dir, 180))
	// G G G
	// G M G  ↓ (Mech dir, look on SOUTH)
	// B B B
	// M - mech, B - cant climb ON mech from this side, G - can climb ON mech from this side
		to_chat(user, SPAN_WARNING("You cant climb in passenger place of [src ] from this side."))
		return FALSE
	var/choose
	var/choosed_place = input(usr, "Choose passenger place which you want to take.", name, choose) as null|anything in passenger_places
	if(user.r_hand != null || user.l_hand != null)
		to_chat(user,SPAN_NOTICE("You need two free hands to take [choosed_place]."))
		return
	if(user.mob_size > MOB_MEDIUM)
		to_chat(user,SPAN_NOTICE("Looks like you too big to take [choosed_place]."))
		return
	if(choosed_place == "Back")
		if(LAZYLEN(passenger_compartment.back_passengers) > 0)
			to_chat(user,SPAN_NOTICE("[choosed_place] is busy"))
			return 0
		else if(body.allow_passengers == FALSE)
			to_chat(user,SPAN_NOTICE("[choosed_place] not able with [body.name]"))
			return 0
	else if(choosed_place == "Left back")
		if(LAZYLEN(passenger_compartment.left_back_passengers) > 0)
			to_chat(user,SPAN_NOTICE("[choosed_place] is busy"))
			return 0
		else if(arms.allow_passengers == FALSE)
			to_chat(user,SPAN_NOTICE("[choosed_place] not able with [arms.name]"))
			return 0
	else if(choosed_place == "Right back")
		if(LAZYLEN(passenger_compartment.right_back_passengers) > 0)
			to_chat(user,SPAN_NOTICE("[choosed_place] is busy"))
			return 0
		else if(arms.allow_passengers == FALSE)
			to_chat(user,SPAN_NOTICE("[choosed_place] not able with [arms.name]"))
			return 0
	else if(choosed_place == null)
		return 0
	if(check_hardpoint_passengers(choosed_place,user) == TRUE)
		enter_passenger(user,choosed_place)

/mob/living/exosuit/proc/check_hardpoint_passengers(var/place,var/mob/user)// Данный прок проверяет, доступна ли часть тела для занятия её пассажиром в данный момент
	var/obj/item/mech_equipment/checker
	if(place == "Back" && hardpoints["back"] != null)
		checker = hardpoints["back"]
		if(checker.disturb_passengers == TRUE)
			to_chat(user,SPAN_NOTICE("[place] covered by [checker] and cant be taked."))
			return FALSE
	else if(place == "Left back" && hardpoints["left shoulder"] != null)
		checker = hardpoints["left shoulder"]
		if(checker.disturb_passengers == TRUE)
			to_chat(user,SPAN_NOTICE("[place] covered by [checker] and cant be taked."))
			return FALSE
	else if(place == "Right back" && hardpoints["right shoulder"] != null)
		checker = hardpoints["right shoulder"]
		if(checker.disturb_passengers == TRUE)
			to_chat(user,SPAN_NOTICE("[place] covered by [checker] and cant be taked."))
			return FALSE
	return TRUE

/mob/living/exosuit/proc/enter_passenger(var/mob/user,var/place)// Пытается пихнуть на пассажирское место пассажира, перед этим ещё раз проверяя их
	//Проверка спины
	src.visible_message(SPAN_NOTICE(" [user] Starts climb on the [place] of mech!"))
	if(do_after(user, 2 SECONDS, get_turf(src),DO_SHOW_PROGRESS|DO_FAIL_FEEDBACK|DO_USER_CAN_TURN| DO_USER_UNIQUE_ACT | DO_PUBLIC_PROGRESS))
		if(user.r_hand != null || user.l_hand != null)
			to_chat(user,SPAN_NOTICE("You need two free hands to clim on[place] of mech."))
			return
		if(place == "Back" && LAZYLEN(passenger_compartment.back_passengers) == 0)
			user.forceMove(passenger_compartment)
			LAZYDISTINCTADD(passenger_compartment.back_passengers,user)
			user.pinned += src
		else if(place == "Left back" && LAZYLEN(passenger_compartment.left_back_passengers) == 0)
			user.forceMove(passenger_compartment)
			LAZYDISTINCTADD(passenger_compartment.left_back_passengers,user)
			user.pinned += src
		else if(place == "Right back" && LAZYLEN(passenger_compartment.right_back_passengers) == 0)
			user.forceMove(passenger_compartment)
			LAZYDISTINCTADD(passenger_compartment.right_back_passengers,user)
			user.pinned += src
		else
			to_chat(user,SPAN_NOTICE("Looks like [place] is busy!"))
			return 0
		src.visible_message(SPAN_NOTICE(" [user] climbed on [place] of mech!"))
		passengers_ammount += 1
		update_passengers()

// будет использоваться Life() дабы исключить моменты, когда по какой-то причине пассажир слез с меха, лежа на полу. Life вызовется, обработается pinned, всем в кайф.
/mob/living/exosuit/proc/leave_passenger(var/mob/user)// Пассажир сам покидает меха
	src.visible_message(SPAN_NOTICE("[user] jump off from mech!"))
	user.dropInto(loc)
	user.pinned -= src
	user.Life()
	if(user in passenger_compartment.back_passengers)
		LAZYREMOVE(passenger_compartment.back_passengers,user)
	else if(user in passenger_compartment.left_back_passengers)
		LAZYREMOVE(passenger_compartment.left_back_passengers,user)
	else if(user in passenger_compartment.right_back_passengers)
		LAZYREMOVE(passenger_compartment.right_back_passengers,user)
	passengers_ammount -= 1
	update_passengers()

/mob/living/exosuit/proc/forced_leave_passenger(var/place,var/mode,var/author)// Нечто внешнее насильно опустошает Одно/все места пассажиров
// mode 1 - полный выгруз, mode 2 - рандомного одного, mode 0(Отсутствие мода) - ручной скид пассажира мехводом
	if(mode == MECH_DROP_ALL_PASSENGER) // Полная разгрузка
		if(LAZYLEN(passenger_compartment.back_passengers)>0)
			for(var/mob/i in passenger_compartment.back_passengers)
				LAZYREMOVE(passenger_compartment.back_passengers,i)
				i.dropInto(loc)
				i.pinned -= src
				i.Life()
				passengers_ammount -= 1
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]"))
		if(LAZYLEN(passenger_compartment.left_back_passengers)>0)
			for(var/mob/i in passenger_compartment.left_back_passengers)
				LAZYREMOVE(passenger_compartment.left_back_passengers,i)
				i.dropInto(loc)
				i.pinned -= src
				i.Life()
				passengers_ammount -= 1
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]"))
		if(LAZYLEN(passenger_compartment.right_back_passengers) > 0)
			for(var/mob/i in passenger_compartment.right_back_passengers)
				LAZYREMOVE(passenger_compartment.right_back_passengers,i)
				i.dropInto(loc)
				i.pinned -= src
				i.Life()
				passengers_ammount -= 1
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]"))
		update_passengers()

	else if(mode == MECH_DROP_ANY_PASSENGER) // Сброс по приоритету спина - левый бок - правый бок.
		if(LAZYLEN(passenger_compartment.back_passengers) > 0)
			for(var/mob/i in passenger_compartment.back_passengers)
				LAZYREMOVE(passenger_compartment.back_passengers,i)
				i.dropInto(loc)
				i.pinned -= src
				i.Life()
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]"))
				passengers_ammount -= 1
				update_passengers()
				return
		else if(LAZYLEN(passenger_compartment.left_back_passengers)>0)
			for(var/mob/i in passenger_compartment.left_back_passengers)
				LAZYREMOVE(passenger_compartment.left_back_passengers,i)
				i.dropInto(loc)
				i.pinned -= src
				i.Life()
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]"))
				passengers_ammount -= 1
				update_passengers()
				return
		else if(LAZYLEN(passenger_compartment.right_back_passengers)>0)
			for(var/mob/i in passenger_compartment.right_back_passengers)
				LAZYREMOVE(passenger_compartment.right_back_passengers,i)
				i.dropInto(loc)
				i.pinned -= src
				i.Life()
				i.Life()
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]"))
				passengers_ammount -= 1
				update_passengers()
				return

	else // <- Опустошается определённое место
		if(place == "Back")
			for(var/mob/i in passenger_compartment.back_passengers)
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]"))
				i.dropInto(loc)
				i.pinned -= src
				LAZYREMOVE(passenger_compartment.back_passengers,i)
		else if(place == "Left back")
			for(var/mob/i in passenger_compartment.left_back_passengers)
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]!"))
				i.dropInto(loc)
				i.pinned -= src
				LAZYREMOVE(passenger_compartment.left_back_passengers,i)
		else if(place == "Right back")
			for(var/mob/i in passenger_compartment.right_back_passengers)
				src.visible_message(SPAN_WARNING("[i] was forcelly removed from mech by [author]!"))
				i.dropInto(loc)
				i.pinned -= src
				LAZYREMOVE(passenger_compartment.right_back_passengers,i)
		passengers_ammount -= 1
		update_passengers()

/mob/living/exosuit/proc/sync_access()
	access_card.access = saved_access.Copy()
	if(sync_access)
		for(var/mob/pilot in pilots)
			access_card.access |= pilot.GetAccess()
			to_chat(pilot, SPAN_NOTICE("Security access permissions synchronized."))

/mob/living/exosuit/proc/eject(var/mob/user, var/silent)
	if(!user || !(user in src.contents))
		return
	if(hatch_closed)
		if(hatch_locked)
			if(!silent)
				to_chat(user, SPAN_WARNING("The [body.hatch_descriptor] is locked."))
			return
		hud_open.toggled()
		if(!silent)
			to_chat(user, SPAN_NOTICE("You open the hatch and climb out of \the [src]."))
	else
		if(!silent)
			to_chat(user, SPAN_NOTICE("You climb out of \the [src]."))

	user.RemoveClickHandler(/datum/click_handler/default/mech)
	user.dropInto(loc)
	LAZYREMOVE(user.additional_vision_handlers, src)
	if(user.client)
		user.client.screen -= hud_elements
		user.client.eye = user
	if(user in pilots)
		a_intent = I_HURT
		LAZYREMOVE(pilots, user)
		UNSETEMPTY(pilots)
		update_pilots()
	return 1

/mob/living/exosuit/attackby(var/obj/item/thing, var/mob/user)

	if(user.a_intent != I_HURT && istype(thing, /obj/item/mech_equipment))
		if(hardpoints_locked)
			to_chat(user, SPAN_WARNING("Hardpoint system access is disabled."))
			return

		var/obj/item/mech_equipment/realThing = thing
		if(realThing.owner)
			return

		var/free_hardpoints = list()
		for(var/hardpoint in hardpoints)
			if(hardpoints[hardpoint] == null)
				free_hardpoints += hardpoint
		var/to_place = input("Where would you like to install it?") as null|anything in (realThing.restricted_hardpoints & free_hardpoints)
		if(!to_place)
			to_chat(user, SPAN_WARNING("There is no room to install \the [thing]."))
		// check passengers subsystem before
		if(realThing.disturb_passengers == TRUE)// Module cant be equiped with passengers? (jets, sleeper etc)
			if(to_place == "back")
				if(LAZYLEN(passenger_compartment.back_passengers) > 0)
					to_chat(user, SPAN_WARNING("[to_place] covered by passenger, you cant install \the [thing]."))
					return
			else if(to_place == "left shoulder")
				if(LAZYLEN(passenger_compartment.left_back_passengers) > 0)
					to_chat(user, SPAN_WARNING("[to_place] covered by passenger, you cant install \the [thing]."))
					return
			else if(to_place == "right shoulder")
				if(LAZYLEN(passenger_compartment.right_back_passengers) > 0)
					to_chat(user, SPAN_WARNING("[to_place] covered by passenger, you cant install \the [thing]."))
					return
		//
			return
		if(install_system(thing, to_place, user))
			return
		to_chat(user, SPAN_WARNING("\The [thing] could not be installed in that hardpoint."))
		return

	else if(istype(thing, /obj/item/device/kit/mech))
		user.visible_message(SPAN_NOTICE("\The [user] opens \the [thing] and spends some quality time customising \the [src]."))
		var/obj/item/device/kit/mech/P = thing
		for(var/obj/item/mech_component/comp in list(arms, legs, head, body))
			comp.decal = P.current_decal
		if(P.new_icon_file)
			icon = P.new_icon_file
		queue_icon_update()
		return 1

	else
		if(user.a_intent != I_HURT)
			if(isMultitool(thing))
				if(hardpoints_locked)
					to_chat(user, SPAN_WARNING("Hardpoint system access is disabled."))
					return

				var/list/parts = list()
				for(var/hardpoint in hardpoints)
					if(hardpoints[hardpoint])
						parts += hardpoint

				var/to_remove = input("Which component would you like to remove") as null|anything in parts

				if(remove_system(to_remove, user))
					return
				to_chat(user, SPAN_WARNING("\The [src] has no hardpoint systems to remove."))
				return
			else if(isWrench(thing))
				if(!maintenance_protocols)
					to_chat(user, SPAN_WARNING("The securing bolts are not visible while maintenance protocols are disabled."))
					return

				visible_message(SPAN_WARNING("\The [user] begins unwrenching the securing bolts holding \the [src] together."))
				var/delay = 60 * user.skill_delay_mult(SKILL_DEVICES)
				if(!do_after(user, delay) || !maintenance_protocols)
					return
				visible_message(SPAN_NOTICE("\The [user] loosens and removes the securing bolts, dismantling \the [src]."))
				dismantle()
				return
			else if(isWelder(thing))
				if(!getBruteLoss())
					return
				var/list/damaged_parts = list()
				for(var/obj/item/mech_component/MC in list(arms, legs, body, head))
					if(MC && MC.brute_damage)
						damaged_parts += MC
				var/obj/item/mech_component/to_fix = input(user,"Which component would you like to fix") as null|anything in damaged_parts
				if(CanPhysicallyInteract(user) && !QDELETED(to_fix) && (to_fix in src) && to_fix.brute_damage)
					to_fix.repair_brute_generic(thing, user)
				return
			else if(isCoil(thing))
				if(!getFireLoss())
					return
				var/list/damaged_parts = list()
				for(var/obj/item/mech_component/MC in list(arms, legs, body, head))
					if(MC && MC.burn_damage)
						damaged_parts += MC
				var/obj/item/mech_component/to_fix = input(user,"Which component would you like to fix") as null|anything in damaged_parts
				if(CanPhysicallyInteract(user) && !QDELETED(to_fix) && (to_fix in src) && to_fix.burn_damage)
					to_fix.repair_burn_generic(thing, user)
				return
			else if(isScrewdriver(thing))
				if(!maintenance_protocols)
					to_chat(user, SPAN_WARNING("The cell compartment remains locked while maintenance protocols are disabled."))
					return
				if(!body || !body.cell)
					to_chat(user, SPAN_WARNING("There is no cell here for you to remove!"))
					return
				var/delay = 20 * user.skill_delay_mult(SKILL_DEVICES)
				if(!do_after(user, delay) || !maintenance_protocols || !body || !body.cell)
					return

				user.put_in_hands(body.cell)
				to_chat(user, SPAN_NOTICE("You remove \the [body.cell] from \the [src]."))
				playsound(user.loc, 'sound/items/Crowbar.ogg', 50, 1)
				visible_message(SPAN_NOTICE("\The [user] pries out \the [body.cell] using \the [thing]."))
				power = MECH_POWER_OFF
				hud_power_control.queue_icon_update()
				body.cell = null
				return
			else if(isCrowbar(thing))
				if(!hatch_locked)
					to_chat(user, SPAN_NOTICE("The cockpit isn't locked. There is no need for this."))
					return
				if(!body) //Error
					return
				var/delay = min(50 * user.skill_delay_mult(SKILL_DEVICES), 50 * user.skill_delay_mult(SKILL_EVA))
				visible_message(SPAN_NOTICE("\The [user] starts forcing the \the [src]'s emergency [body.hatch_descriptor] release using \the [thing]."))
				if(!do_after(user, delay, src, DO_DEFAULT | DO_PUBLIC_PROGRESS))
					return
				visible_message(SPAN_NOTICE("\The [user] forces \the [src]'s [body.hatch_descriptor] open using the \the [thing]."))
				playsound(user.loc, 'sound/machines/bolts_up.ogg', 25, 1)
				hatch_locked = FALSE
				hatch_closed = FALSE
				for(var/mob/pilot in pilots)
					eject(pilot, silent = 1)
				hud_open.queue_icon_update()
				queue_icon_update()
				return
			else if(istype(thing, /obj/item/cell))
				if(!maintenance_protocols)
					to_chat(user, SPAN_WARNING("The cell compartment remains locked while maintenance protocols are disabled."))
					return
				if(!body || body.cell)
					to_chat(user, SPAN_WARNING("There is already a cell in there!"))
					return

				if(user.unEquip(thing))
					thing.forceMove(body)
					body.cell = thing
					to_chat(user, SPAN_NOTICE("You install \the [body.cell] into \the [src]."))
					playsound(user.loc, 'sound/items/Screwdriver.ogg', 50, 1)
					visible_message(SPAN_NOTICE("\The [user] installs \the [body.cell] into \the [src]."))
				return
			else if(istype(thing, /obj/item/device/robotanalyzer))
				to_chat(user, SPAN_NOTICE("Diagnostic Report for \the [src]:"))
				for(var/obj/item/mech_component/MC in list(arms, legs, body, head))
					if(MC)
						MC.return_diagnostics(user)
				return
	return ..()

/mob/living/exosuit/attack_hand(var/mob/user)
	// Drag the pilot out if possible.
	if(user.a_intent == I_HURT)
		if(passengers_ammount > 0 && hatch_closed)// Стянуть пассажира с меха рукой!
			forced_leave_passenger(null,2,user)
			return
		if(!LAZYLEN(pilots))
			to_chat(user, SPAN_WARNING("There is nobody inside \the [src]."))
		else if(!hatch_closed)
			var/mob/pilot = pick(pilots)
			user.visible_message(SPAN_DANGER("\The [user] is trying to pull \the [pilot] out of \the [src]!"))
			if(do_after(user, 30) && user.Adjacent(src) && (pilot in pilots) && !hatch_closed)
				user.visible_message(SPAN_DANGER("\The [user] drags \the [pilot] out of \the [src]!"))
				eject(pilot, silent=1)
		else if(hatch_closed)
			if(MUTATION_FERAL in user.mutations)
				user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
				attack_generic(user, 5)
		return

	// Otherwise toggle the hatch.
	if(hud_open)
		hud_open.toggled()
	return

/mob/living/exosuit/attack_generic(var/mob/user, var/damage)
	if(..())
		playsound(loc, 'sound/effects/metal_close.ogg', 40, 1)
		playsound(loc, 'sound/weapons/tablehit1.ogg', 40, 1)

/mob/living/exosuit/proc/attack_self(var/mob/user)
	return visible_message("\The [src] pokes itself.")

/mob/living/exosuit/proc/rename(var/mob/user)
	if(user != src && !(user in pilots))
		return
	var/new_name = sanitize(input("Enter a new exosuit designation.", "Exosuit Name") as text|null, max_length = MAX_NAME_LEN)
	if(!new_name || new_name == name || (user != src && !(user in pilots)))
		return
	SetName(new_name)
	to_chat(user, SPAN_NOTICE("You have redesignated this exosuit as \the [name]."))

/mob/living/exosuit/get_inventory_slot(obj/item/I)
	for(var/h in hardpoints)
		if(hardpoints[h] == I)
			return h
	return 0
