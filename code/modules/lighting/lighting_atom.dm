/atom
	var/light_power = 1 // intensity of the light
	var/light_range = 0 // range in tiles of the light
	var/light_color		// Hexadecimal RGB string representing the colour of the light

	var/datum/light_source/light
	var/list/light_sources
	var/light_wedge		// The angle that the light's emission should be restricted to. null for omnidirectional.
	var/light_self = TRUE	// If the light should also affect our tile. Requires light_wedge to be set.

// Nonsensical value for l_color default, so we can detect if it gets set to null.
#define NONSENSICAL_VALUE -99999
/atom/proc/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE)
	. = 0 //make it less costly if nothing's changed

	if(l_power != null && l_power != light_power)
		light_power = l_power
		. = 1
	if(l_range != null && l_range != light_range)
		light_range = l_range
		. = 1
	if(l_color != NONSENSICAL_VALUE && l_color != light_color)
		light_color = l_color
		. = 1

	if(.) update_light()

#undef NONSENSICAL_VALUE

/atom/proc/update_light()
	set waitfor = FALSE

	if(!light_power || !light_range)
		if(light)
			light.destroy()
			light = null
	else
		if(!istype(loc, /atom/movable))
			. = src
		else
			. = loc

		if(light)
			light.update(.)
		else
			light = new /datum/light_source(src, .)

/atom/Destroy()
	if(light)
		light.destroy()
		light = null
	return ..()

/atom/set_opacity()
	. = ..()
	if(.)
		var/turf/T = loc
		if(istype(T))
			T.RecalculateOpacity()

/atom/set_dir(new_dir)
	. = ..()

	for (var/datum/light_source/L in src.light_sources)
		if (L.light_angle)
			L.source_atom.update_light()
