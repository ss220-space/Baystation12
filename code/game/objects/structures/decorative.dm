/**
 * These are generally sprites ported from other servers, which don't have any unique code.
 * They can be used by mappers for decorating their maps. They're mostly here so people who aren't
 * rummaging around in the sprites can be aware of some neat sprites they can use.
 *
 * Obviously you can swipe the sprites for real structures and add code, but please don't add any code
 * (beyond decorative things like maybe light) directly to these types or this file!
 * Take the icon and state and make your own type under /obj/structure.
 *
 * Some of these do have a SMIDGE of code to allow a mapper to twirl them through states/animations without
 * much effort, but beyond 'visuals logic', I'd rather keep all the logic out of here.
 */

/obj/structure/decor
	name = "mysterious structure"
	desc = "A mysterious structure!"
	anchored = TRUE
	density = TRUE
	icon = 'icons/obj/structures/decor.dmi'
	var/state
	var/interaction_message = null


/// Used to tell the player that this isn't useful for anything.
/obj/structure/decor/attack_hand(mob/living/user)
	if(!istype(user))
		return FALSE
	if(!interaction_message)
		return ..()
	else
		to_chat(user, interaction_message)

/obj/structure/decor/proc/change_state(state)
	SHOULD_CALL_PARENT(TRUE)
	src.state = state
	return


// bluespace beacon from Eris
/obj/structure/decor/bsb_off
	icon_state = "bsb_off"
/obj/structure/decor/bsb_on
	icon_state = "bsb_on"

// bluespace crystal from Eris
/obj/structure/decor/bsc
	icon_state = "bsc"
/obj/structure/decor/bsc_dust
	icon_state = "bsc_dust"

// same as state names, from faction items on Eris
/obj/structure/decor/biosyphon
	icon_state = "biosyphon"
/obj/structure/decor/von_krabin
	icon_state = "von_krabin"
/obj/structure/decor/last_shelter
	icon_state = "last_shelter"
/obj/structure/decor/complicator
	icon_state = "complicator"
/obj/structure/decor/random_radio
	icon_state = "random_radio"
/obj/structure/decor/nt_pedestal0_old
	icon_state = "nt_pedestal0_old"
/obj/structure/decor/nt_pedestal1_old
	icon_state = "nt_pedestal1_old"

// statues from Eris
/obj/structure/decor/statue1
	icon_state = "artwork_statue_1"
/obj/structure/decor/statue2
	icon_state = "artwork_statue_2"
/obj/structure/decor/statue3
	icon_state = "artwork_statue_3"
/obj/structure/decor/statue4
	icon_state = "artwork_statue_4"
/obj/structure/decor/statue5
	icon_state = "artwork_statue_5"
/obj/structure/decor/statue6
	icon_state = "artwork_statue_6"

// ship mast from TGMC
/obj/structure/decor/stump_plaque
	icon_state = "stump"

// vatgrowing thing from /tg/
/obj/structure/decor/green_egg
	icon_state = "gel_cocoon"

// eye of the protector from Eris
/obj/structure/decor/eotp
	icon = 'icons/obj/structures/decor32x64.dmi'
	icon_state = "eotp"

// dna vault from /tg/
/obj/structure/decor/dna_vault
	icon = 'icons/obj/structures/decor96x96.dmi'
	icon_state = "vault"

// fences from TGMC
// You'll need to 'create instances from icon_states' in an editor to use these well
/obj/structure/decor/fence
	name = "fence"
	desc = "It's a fence! Not much else to say about it."
	icon = 'icons/obj/structures/decor_fences.dmi'

/**
 *
 * tl;dr "You can varedit 'state' on these to the things in the comments below to get cool animations"
 *
 * These items have some logic to handle some fun animations on them. Mappers can call the 'change_state(state)' proc
 * while referring to the comments here for what states they can use. You'll notice some crazy overlay handling,
 * and that's because I don't want to add any vars to these mappers think they can fiddle with, which requires
 * more logic than I'm willing to do at the moment. So we get crazy cut/add operations instead.
 *
 * There's also a VV helper so if you varedit 'state' to these during the game, you can get that to work.
 *
 * Like, I don't want to add a state machine to decorative objects. You can if you want.
 *
 */

/**
 * Possible 'state' options for change_state(state) are:
 * off: Looks boring and off
 * on: candles lit and stuff
 * no_cruciform: No cruciform (the little triangle thing) inserted
 * red_cruciform: Red light cruciform inserted
 * green_cruciform: Green light cruciform inserted
 * panel_open: The panel is open (wiring)
 * panel_closed: The panel is closed
 */
// neotheology cruciform reader from Eris
/obj/structure/decor/nt_reader
	icon_state = "nt_reader_off"

/obj/structure/decor/nt_reader/change_state(state)
	. = ..()
	switch(state)
		if("off")
			icon_state = "nt_reader_off"
		if("on")
			icon_state = "nt_reader_on"
		if("no_cruciform")
			overlays.Cut("nt_reader_c_green")
			overlays.Cut("nt_reader_c_red")
		if("red_cruciform")
			overlays.Cut("nt_reader_c_green")
			overlays.Cut("nt_reader_c_red")
			add_overlay("nt_reader_c_red")
		if("green_cruciform")
			overlays.Cut("nt_reader_c_red")
			overlays.Cut("nt_reader_c_green")
			add_overlay("nt_reader_c_green")
		if("panel_open")
			overlays.Cut("nt_reader_panel")
			add_overlay("nt_reader_panel")
		if("panel_closed")
			overlays.Cut("nt_reader_panel")

/**
 * Possible 'state' options for change_state(state) are:
 * panel_open: The panel is opened
 * panel_closed: The panel is closed
 */
// neotheology cloning biocan from Eris
/obj/structure/decor/nt_biocan
	icon_state = "nt_biocan"

/obj/structure/decor/nt_biocan/change_state(state)
	. = ..()
	switch(state)
		if("panel_open")
			overlays.Cut("nt_biocan_panel")
			add_overlay("nt_biocan_panel")
		if("panel_closed")
			overlays.Cut("nt_biocan_panel")

/**
 * Possible 'state' options for change_state(state) are:
 * blue, red, orange, yellow, green, purple: Set that color
 * damaged: add damage overlay
 * undamaged: remove damage overlay
 * broken: become damaged
 * plain: undamaged white version, otherwise use a color
 */
// dominator console from /tg/
/obj/structure/decor/dominator
	icon_state = "dominator"

/obj/structure/decor/dominator/change_state(state)
	. = ..()
	switch(state)
		if("blue")
			icon_state = "dominator-blue"
		if("red")
			icon_state = "dominator-red"
		if("orange")
			icon_state = "dominator-orange"
		if("yellow")
			icon_state = "dominator-yellow"
		if("green")
			icon_state = "dominator-green"
		if("purple")
			icon_state = "dominator-purple"
		if("damaged")
			add_overlay("dom_damage")
		if("undamaged")
			overlays.Cut("dom_damage")
		if("broken")
			icon_state = "dominator-broken"
		if("plain")
			icon_state = "dominator"

/obj/structure/decor/dominator/blue
	icon_state = "dominator-blue"
/obj/structure/decor/dominator/red
	icon_state = "dominator-red"
/obj/structure/decor/dominator/orange
	icon_state = "dominator-orange"
/obj/structure/decor/dominator/yellow
	icon_state = "dominator-yellow"
/obj/structure/decor/dominator/green
	icon_state = "dominator-green"
/obj/structure/decor/dominator/purple
	icon_state = "dominator-purple"

/**
 * Possible 'state' options for change_state(state) are:
 * off: Default, boring
 * on: Pumping or something
 */
// some neotheology thing from Eris
/obj/structure/decor/nt_solifier
	icon_state = "nt_solidifier"

/obj/structure/decor/nt_solifier/change_state(state)
	. = ..()
	switch(state)
		if("off")
			icon_state = "nt_solidifier"
		if("on")
			icon_state = "nt_solidifier_on"

/obj/structure/decor/nt_solifier/starts_on
	icon_state = "nt_solidifier_on"

/**
 * Possible 'state' options for change_state(state) are:
 * down: In the ground, glowing
 * up: Out of the ground, open
 */
// experimental science destructor from /tg/
/obj/structure/decor/tube
	icon = 'icons/obj/structures/decor32x64.dmi'
	icon_state = "tube_open"

/obj/structure/decor/tube/change_state(state)
	. = ..()
	switch(state)
		if("down")
			icon_state = "tube_on"
			flick("tube_down", src)
		if("up")
			icon_state = "tube_open"
			flick("tube_up", src)

/obj/structure/decor/tube/starts_down
	icon_state = "tube_on"

/**
 * Possible 'state' options for change_state(state) are:
 * off: Boring, static
 * on: Turny and blinky
 */
// experimental science destructor from /tg/
/obj/structure/decor/comm_tower
	icon = 'icons/obj/structures/decor96x96.dmi'
	icon_state = "comm_tower"

/obj/structure/decor/comm_tower/change_state(state)
	. = ..()
	switch(state)
		if("on")
			icon_state = "comm_tower_on"
		if("off")
			icon_state = "comm_tower"

/obj/structure/decor/comm_tower/starts_on
	icon_state = "comm_tower_on"

/**
 * Possible 'state' options for change_state(state) are:
 * off: Not doing much
 * on: Stamping mysterious substances
 */


/**
 * Possible 'state' options for change_state(state) are:
 * whole: Not doing much
 * broken: Stamping mysterious substances
 */
// alien autopsy thing from TGMC
/obj/structure/decor/alien_tank
	icon_state = "tank_larva"

/obj/structure/decor/alien_tank/change_state(state)
	. = ..()
	switch(state)
		if("whole")
			icon_state = "tank_larva"
		if("broken")
			icon_state = "tank_broken"

/obj/structure/decor/alien_tank/starts_broken
	icon_state = "tank_broken"

/**
 * Possible 'state' options for change_state(state) are:
 * idle: The default look
 * active: Glowy lights underneath
 * panel_open: Opened panel (wiring)
 * panel_closed: Closed panel
 */
// neotheology optable from Eris
/obj/structure/decor/nt_optable
	icon_state = "nt_optable-idle"

/obj/structure/decor/nt_optable/change_state(state)
	. = ..()
	switch(state)
		if("idle")
			icon_state = "nt_optable-idle"
		if("active")
			icon_state = "nt_optable-active"
		if("panel_open")
			overlays.Cut("nt_optable_panel")
			add_overlay("nt_optable_panel")
		if("panel_closed")
			overlays.Cut("nt_optable_panel")

/**
 * Possible 'state' options for change_state(state) are:
 * off: Non-spinny
 * on: Spinny and floaty
 */
// neotheology decorative(?) obelisk from Eris
/obj/structure/decor/nt_obelisk
	icon_state = "nt_obelisk"

/obj/structure/decor/nt_obelisk/change_state(state)
	. = ..()
	switch(state)
		if("off")
			icon_state = "nt_obelisk"
		if("on")
			icon_state = "nt_obelisk_on"

/obj/structure/decor/nt_obelisk/starts_on
	icon_state = "nt_obelisk_on"

/**
 * Possible 'state' options for change_state(state) are:
 * idle: Not doing anything, with yellow template exposed
 * work: busy doing work
 * pause: paused work
 */
// cruciform forge from Eris
/obj/structure/decor/nt_cruciforge
	icon_state = "nt_cruciforge"

/obj/structure/decor/nt_cruciforge/change_state(state)
	. = ..()
	switch(state)
		if("idle")
			icon_state = "nt_cruciforge"
			flick("nt_cruciforge_finish", src) // 8ds
		if("work")
			icon_state = "nt_cruciforge_work"
			flick("nt_cruciforge_start", src) // 8ds
		if("pause")
			icon_state = "nt_cruciforge_pause"

//World Server statues

/obj/structure/decor/statue
	name = "statue"
	desc = "A statue."
	icon = 'icons/obj/structures/decor32x64.dmi'
	icon_state = "venus"

/obj/structure/decor/statue/lion
	icon_state = "lion"

/obj/structure/decor/statue/angel
	icon = 'icons/obj/structures/decor.dmi'
	icon_state = "angel"

/obj/structure/decor/statue/phoron
	name = "phoronic cascade"
	desc = "A sculpture made of pure phoron. It is covered in a lacquer that prevents erosion and renders it fireproof. It's safe. Probably."
	icon_state = "phoronic"
	layer = ABOVE_WINDOW_LAYER
	interaction_message = "<span class = 'notice'>Cool to touch and unbelievable smooth. You can almost see your reflection in it.</span>"

/obj/structure/decor/statue/phoron/New()
	set_light(2, 3, "#cc66ff")

/obj/structure/decor/statue/pillar
	name = "pillar"
	desc = "A pillar."
	icon_state = "pillar"

/obj/structure/decor/statue/pillar/dark
	name = "pillar"
	desc = "A dark pillar."
	icon_state = "dark_pillar"

/obj/structure/decor/memorial
	name = "engraved wall"
	desc = "A finely engraved list on dark stone."
	icon = 'icons/obj/structures/decor64x64.dmi'
	icon_state = "ship_memorial"
	bound_width = 64
