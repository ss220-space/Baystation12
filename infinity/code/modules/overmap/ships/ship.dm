//Distress call

/obj/effect/overmap/visitable/ship
	var/distress = 0

/obj/effect/overmap/visitable/ship/Process()
	. = ..()
	if(distress == 1)
		animate(src, transform = matrix() * 1.4, color = "#ff2222", time = 5)

