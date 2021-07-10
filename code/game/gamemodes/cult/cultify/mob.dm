/mob
	//thou shall always be able to see the Geometer of Blood
	var/image/narsimage = null
	var/image/narglow = null

/mob/proc/cultify()
	return

/mob/observer/ghost/cultify()
	if(icon_state != "ghost-narsie")
		icon = 'icons/mob/mob.dmi'
		icon_state = "ghost-narsie"
		overlays.Cut()
		set_invisibility(0)
		to_chat(src, "<span class='sinister'>Даже будучи не телесным существом Вы чувствуете как частица Нар Си воздействует на Вас. Теперь все могут вас видеть.</span>")

/mob/living/cultify()
	if(iscultist(src) && client)
		var/mob/living/simple_animal/construct/harvester/C = new(get_turf(src))
		mind.transfer_to(C)
		to_chat(C, "<span class='sinister'>Кровавая Обитель рада воссоединиться сосвоим последователем и принимает жертвенное тело. В благодарность Вы были одарены панцирем Жнеца.<br>Ваши щупальца могуть использовать и рисовать руны без фолианта, Ваши глаза могут видеть существ сквозь стены, и Ваш разум может открыть любую дверь. Используйте эти дары, чтобы служить Нар-Си и привести к нему всех оставшихся в живых людей в мире.<br>Вы можете телепортироваться обратно к Нар-Си вместе с любым взятым существом в любое время, используя заклинание \"Harvest\".</span>")
		dust()
	else if(client)
		var/mob/observer/ghost/G = (ghostize())
		G.icon = 'icons/mob/mob.dmi'
		G.icon_state = "ghost-narsie"
		G.overlays.Cut()
		G.set_invisibility(0)
		to_chat(G, "<span class='sinister'>Вы чувствуете облегчение, когда то, что осталось от вашей души, наконец то сбегает из тюрьмы плоти.</span>")
	else
		dust()

/mob/proc/see_narsie(var/obj/singularity/narsie/large/N, var/dir)
	if(N.chained)
		if(narsimage)
			qdel(narsimage)
			qdel(narglow)
		return
	if((N.z == src.z)&&(get_dist(N,src) <= (N.consume_range+10)) && !(N in view(src)))
		if(!narsimage) //Create narsimage
			narsimage = image('icons/obj/narsie.dmi',src.loc,"narsie",9,1)
			narsimage.mouse_opacity = 0
		if(!narglow) //Create narglow
			narglow = image('icons/obj/narsie.dmi',narsimage.loc,"glow-narsie",12,1)
			narglow.mouse_opacity = 0
		//Else if no dir is given, simply send them the image of narsie
		var/new_x = 32 * (N.x - src.x) + N.pixel_x
		var/new_y = 32 * (N.y - src.y) + N.pixel_y
		narsimage.pixel_x = new_x
		narsimage.pixel_y = new_y
		narglow.pixel_x = new_x
		narglow.pixel_y = new_y
		narsimage.loc = src.loc
		narglow.loc = src.loc
		//Display the new narsimage to the player
		image_to(src, narsimage)
		image_to(src, narglow)

	else
		if(narsimage)
			QDEL_NULL(narsimage)
			QDEL_NULL(narglow)
