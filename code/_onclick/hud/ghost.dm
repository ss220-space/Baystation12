/obj/screen/ghost
	icon = 'icons/hud/screen_ghost.dmi'

/obj/screen/ghost/MouseExited(location, control, params)
	. = ..()
	flick(icon_state + "_anim", src)

/obj/screen/ghost/jumptomob
	name = "Jump to mob"
	icon_state = "jumptomob"
	screen_loc = ui_ghost_jumptomob

/obj/screen/ghost/jumptomob/Click()
	var/mob/observer/ghost/G = usr
	G.jumptomob()

/obj/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"
	screen_loc = ui_ghost_orbit

/obj/screen/ghost/orbit/Click()
	var/mob/observer/ghost/G = usr
	G.follow()

/obj/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"
	screen_loc = ui_ghost_reenter_corpse

/obj/screen/ghost/reenter_corpse/Click()
	var/mob/observer/ghost/G = usr
	G.reenter_corpse()

/obj/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"
	screen_loc = ui_ghost_teleport

/obj/screen/ghost/teleport/Click()
	var/mob/observer/ghost/G = usr
	G.dead_tele()

/obj/screen/ghost/toggle_darkness
	name = "Toggle Darkness"
	icon_state = "toggle_darkness"
	screen_loc = ui_ghost_toggle_darkness

/obj/screen/ghost/toggle_darkness/Click()
	var/mob/observer/ghost/G = usr
	G.toggle_darkness()
