/obj/item/missile_equipment/payload/void
	name = "void warhead"
	desc = "An incredibly dangerous warhead. Detonates when the missile is triggered."
	icon_state = "diffuse"

/obj/item/missile_equipment/payload/void/on_trigger(var/atom/triggerer)
	if(istype(triggerer, /obj/effect/shield))
		explosion(get_turf(src), 4, 8, 12, 16)
		empulse(get_turf(src), rand(10,20), rand(25,50))
		var/obj/effect/shield/S = triggerer
		S.take_damage(100000)
	else
		explosion(get_turf(src), 4, 8, 12, 16)//Same for both. Pen only adjusts EMP severity.
		empulse(get_turf(src), rand(25,50), rand(50,100))

	for(var/mob/living/carbon/human/M in GLOB.player_list)
		if(M.eyecheck() < FLASH_PROTECTION_MAJOR)
			M.flash_eyes()
			M.updatehealth()

	to_world("<font size='5' color='red'><b>The world distorts around you momentarily!</b></font>")
	sound_to(world, sound('sound/effects/heavy_cannon_blast.ogg'))


	..()
