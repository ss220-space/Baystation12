/obj/machinery/mineral/unloading_machine
	name = "unloading machine"
	icon_state = "unloader"
	input_turf =  WEST
	output_turf = EAST
	machine_name = "unloading machine"
	machine_desc = "Unloads raw ore stored within an ore box and places it onto an adjacent tile. By default, it draws from a box to the west and places ore to the east."
	var/slow_factor = 20

/obj/machinery/mineral/unloading_machine/Process()

	var/obj/structure/ore_box/box = locate() in input_turf
	var/obj/item/ore = locate() in input_turf
	if((box || ore) && !speed_process)
	{
		makeSpeedProcess()
	}
	else if(!(box || ore) && speed_process)
	{
		makeNormalProcess()
	}
	if(box || ore)
		addtimer(CALLBACK(src, .proc/post_process), slow_factor)
		CHECK_TICK

/obj/machinery/mineral/unloading_machine/proc/post_process()
	if(input_turf && output_turf)
		if(length(output_turf.contents) < 10)
			var/ore_this_tick = 12
			for(var/obj/structure/ore_box/unloading in input_turf)
				for(var/obj/item/ore/_ore in unloading)
					_ore.dropInto(output_turf)
					if(--ore_this_tick<=0) return
			for(var/obj/item/_ore in input_turf)
				if(_ore.simulated && !_ore.anchored)
					_ore.dropInto(output_turf)
					if(--ore_this_tick<=0) return
