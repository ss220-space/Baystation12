/obj/effect/overlay
	name = "overlay"
	unacidable = TRUE
	var/i_attached//Added for possible image attachments to objects. For hallucinations and the like.

/obj/effect/overlay/beam//Not actually a projectile, just an effect.
	name="beam"
	icon='icons/effects/beam.dmi'
	icon_state= "b_beam"
	var/tmp/atom/BeamSource
	New()
		..()
		spawn(10) qdel(src)

/obj/effect/overlay/palmtree_r
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm1"
	density = TRUE
	layer = ABOVE_HUMAN_LAYER
	anchored = TRUE

/obj/effect/overlay/palmtree_l
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm2"
	density = TRUE
	layer = ABOVE_HUMAN_LAYER
	anchored = TRUE

/obj/effect/overlay/coconut
	name = "Coconuts"
	icon = 'icons/misc/beach.dmi'
	icon_state = "coconuts"

/obj/effect/overlay/bluespacify
	name = "Bluespace"
	icon = 'icons/turf/space.dmi'
	icon_state = "bluespacify"
	layer = SUPERMATTER_WALL_LAYER

/obj/effect/overlay/wallrot
	name = "wallrot"
	desc = "Ick..."
	icon = 'icons/effects/wallrot.dmi'
	anchored = TRUE
	density = TRUE
	layer = ABOVE_TILE_LAYER
	mouse_opacity = 0

/obj/effect/overlay/wallrot/New()
	..()
	pixel_x += rand(-10, 10)
	pixel_y += rand(-10, 10)

/obj/effect/overlay/closet_door
	anchored = TRUE
	plane = FLOAT_PLANE
	layer = FLOAT_LAYER
	vis_flags = VIS_INHERIT_ID
	appearance_flags = KEEP_TOGETHER | LONG_GLIDE | PIXEL_SCALE

/atom/proc/compile_overlays()
	var/list/oo = our_overlays
	var/list/po = priority_overlays
	if(LAZYLEN(po) && LAZYLEN(oo))
		overlays = oo + po
	else if(LAZYLEN(oo))
		overlays = oo
	else if(LAZYLEN(po))
		overlays = po
	else
		overlays.Cut()

	overlay_queued = FALSE

/atom/movable/compile_overlays()
	..()
	UPDATE_OO_IF_PRESENT

/turf/compile_overlays()
	..()
	if (istype(above))
		update_above()
/atom
	var/tmp/list/our_overlays	//our local copy of (non-priority) overlays without byond magic. Use procs in SSoverlays to manipulate
	var/tmp/list/priority_overlays	//overlays that should remain on top and not normally removed when using cut_overlay functions, like c4.
	var/tmp/overlay_queued
