#define ATOMS_FLAG_1 0x0001
#define ATOMS_FLAG_2 0x0002
#define ATOMS_FLAG_3 0x0004
#define ATOMS_FLAG_4 0x0008
SUBSYSTEM_DEF(atoms)
	name = "Atoms"
	init_order = SS_INIT_ATOMS
	flags = SS_NO_FIRE | SS_NEEDS_SHUTDOWN

	var/const/BAD_INIT_QDEL_BEFORE = ATOMS_FLAG_1
	var/const/BAD_INIT_DIDNT_INIT = ATOMS_FLAG_2
	var/const/BAD_INIT_SLEPT = ATOMS_FLAG_3
	var/const/BAD_INIT_NO_HINT = ATOMS_FLAG_4


	var/static/tmp/atom_init_stage = INITIALIZATION_INSSATOMS
	var/static/tmp/old_init_stage
	var/static/list/bad_inits = list()
	var/static/list/init_queue = list()
	var/static/list/late_init_queue = list()


/datum/controller/subsystem/atoms/stat_entry(msg)
	..("[msg] [length(bad_inits)] bad inits")


/datum/controller/subsystem/atoms/Shutdown()
	var/initlog = InitLog()
	if (initlog)
		text2file(initlog, "[GLOB.log_directory]/initialize.log")

/datum/controller/subsystem/atoms/Initialize(timeofday)
	atom_init_stage = INITIALIZATION_INNEW_MAPLOAD
	InitializeAtoms()

/datum/controller/subsystem/atoms/Recover()
	LIST_RESIZE(init_queue, 0)
	LIST_RESIZE(late_init_queue, 0)
	if (atom_init_stage == INITIALIZATION_INNEW_MAPLOAD)
		InitializeAtoms()

/datum/controller/subsystem/atoms/proc/InitializeAtoms()
	if (atom_init_stage <= INITIALIZATION_INSSATOMS_LATE)
		return
	atom_init_stage = INITIALIZATION_INNEW_MAPLOAD
	var/list/mapload_arg = list(TRUE)
	var/atom/atom
	var/list/params
	var/count = 0
	var/time = Uptime()
	if (!initialized)
		for (atom in world)
			if (!atom || atom.atom_flags & ATOM_FLAG_INITIALIZED)
				continue
			InitAtom(atom, mapload_arg)
			if (++count % 1000)
				continue
			CHECK_TICK
	for (var/i = 1 to length(init_queue))
		atom = init_queue[i]
		if (!atom || atom.atom_flags & ATOM_FLAG_INITIALIZED)
			continue
		params = init_queue[atom]
		if (params)
			InitAtom(atom, mapload_arg + params)
		else
			InitAtom(atom, mapload_arg)
		if (++count % 50)
			continue
		CHECK_TICK
	LIST_RESIZE(init_queue, 0)
	time = max((Uptime() - time) * 0.1, 0.1)
	report_progress("Initialized [count] atom\s in [time]s ([Floor(count/time)]/s)")
	atom_init_stage = INITIALIZATION_INNEW_REGULAR
	if (!length(late_init_queue))
		return
	count = 0
	time = Uptime()
	for (var/i = 1 to length(late_init_queue))
		atom = late_init_queue[i]
		if (!atom)
			continue
		atom.LateInitialize(arglist(late_init_queue[atom]))
		if (++count % 50)
			continue
		CHECK_TICK
	LIST_RESIZE(late_init_queue, 0)
	time = max((Uptime() - time) * 0.1, 0.1)
	report_progress("Late initialized [count] atom\s in [time]s ([Floor(count/time)]/s)")

/datum/controller/subsystem/atoms/proc/InitAtom(atom/atom, list/arguments)
	var/atom_type = atom.type
	if (QDELING(atom))
		bad_inits[atom_type] |= BAD_INIT_QDEL_BEFORE
		return TRUE
	var/start_tick = world.time
	var/hint = atom.Initialize(arglist(arguments))
	if (start_tick != world.time)
		bad_inits[atom_type] |= BAD_INIT_SLEPT
	var/deleted = FALSE
	switch (hint)
		if (INITIALIZE_HINT_NORMAL) //noop
		if (INITIALIZE_HINT_LATELOAD)
			if (arguments[1])	//mapload
				late_init_queue[atom] = arguments
			else
				atom.LateInitialize(arglist(arguments))
		if (INITIALIZE_HINT_QDEL)
			qdel(atom)
			deleted = TRUE
		else
			bad_inits[atom_type] |= BAD_INIT_NO_HINT
	if (!atom)
		deleted = TRUE
	else if (!(atom.atom_flags & ATOM_FLAG_INITIALIZED))
		bad_inits[atom_type] |= BAD_INIT_DIDNT_INIT
	return deleted || QDELING(atom)


/datum/controller/subsystem/atoms/proc/map_loader_begin()
	old_init_stage = atom_init_stage
	atom_init_stage = INITIALIZATION_INSSATOMS_LATE


/datum/controller/subsystem/atoms/proc/map_loader_stop()
	atom_init_stage = old_init_stage


/datum/controller/subsystem/atoms/proc/InitLog()
	. = ""
	for (var/path in bad_inits)
		. += "Path : [path] \n"
		var/fails = bad_inits[path]
		if (fails & BAD_INIT_DIDNT_INIT)
			. += "- Didn't call atom/Initialize()\n"
		if (fails & BAD_INIT_NO_HINT)
			. += "- Didn't return an Initialize hint\n"
		if (fails & BAD_INIT_QDEL_BEFORE)
			. += "- Qdel'd in New()\n"
		if (fails & BAD_INIT_SLEPT)
			. += "- Slept during Initialize()\n"
