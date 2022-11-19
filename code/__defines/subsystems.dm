#define INITIALIZATION_INSSATOMS      0	//New should not call Initialize
#define INITIALIZATION_INSSATOMS_LATE 1	//New should not call Initialize; after the first pass is complete (handled differently)
#define INITIALIZATION_INNEW_MAPLOAD  2	//New should call Initialize(TRUE)
#define INITIALIZATION_INNEW_REGULAR  3	//New should call Initialize(FALSE)

#define INITIALIZE_HINT_NORMAL   0  //Nothing happens
#define INITIALIZE_HINT_LATELOAD 1  //Call LateInitialize
#define INITIALIZE_HINT_QDEL     2  //Call qdel on the atom

//type and all subtypes should always call Initialize in New()
#define INITIALIZE_IMMEDIATE(X) ##X/New(loc, ...){\
	..();\
	if(!(atom_flags & ATOM_FLAG_INITIALIZED)) {\
		args[1] = TRUE;\
		SSatoms.InitAtom(src, args);\
	}\
}

#define INIT_SKIP_QDELETED if (. == INITIALIZE_HINT_QDEL) {\
return;\
}

#define INIT_DISALLOW_TYPE(path) if (type == path) {\
. = INITIALIZE_HINT_QDEL;\
crash_with("disallowed type [type] created");\
return;\
}


// Subsystem init_order, from highest priority to lowest priority
// Subsystems shutdown in the reverse of the order they initialize in
// The numbers just define the ordering, they are meaningless otherwise.
#define SS_INIT_DBCORE 			 21
#define SS_INIT_INPUT			 20
#define SS_INIT_EARLY            19
#define SS_INIT_GARBAGE          18
#define SS_INIT_CHEMISTRY        17
#define SS_INIT_MATERIALS        16
#define SS_INIT_PLANTS           15
#define SS_INIT_ANTAGS           14
#define SS_INIT_CULTURE          13
#define SS_INIT_MISC             12
#define SS_INIT_SKYBOX           11
#define SS_INIT_STATION          10
#define SS_INIT_MAPPING          9
#define SS_INIT_JOBS             8
#define SS_INIT_ASSETS           7
#define SS_INIT_CHAR_SETUP       6
#define SS_INIT_CIRCUIT          5
#define SS_INIT_GRAPH            4
#define SS_INIT_OPEN_SPACE       3
#define SS_INIT_ATOMS            2
#define SS_INIT_MACHINES         1
#define SS_INIT_ICON_UPDATE      0
#define SS_INIT_DEFAULT         -1
#define SS_INIT_AIR             -2
#define SS_INIT_MISC_LATE       -3
#define SS_INIT_MISC_CODEX      -4
#define SS_INIT_ALARM           -5
#define SS_INIT_SHUTTLE         -6
#define SS_INIT_GOALS           -7
#define SS_INIT_LIGHTING        -8
#define SS_INIT_ZCOPY           -9
#define SS_INIT_STICKY_BAN      -10
#define SS_INIT_XENOARCH        -11
#define SS_INIT_BAY_LEGACY      -12
#define SS_INIT_TICKER          -20
#define SS_INIT_AI              -21
#define SS_INIT_AIFAST          -22
#define SS_INIT_CHAT            -90 // Should be lower to ensure chat remains smooth during init.
#define SS_INIT_UNIT_TESTS      -100

// SS runlevels

#define RUNLEVEL_INIT 0
#define RUNLEVEL_LOBBY 1
#define RUNLEVEL_SETUP 2
#define RUNLEVEL_GAME 4
#define RUNLEVEL_POSTGAME 8

#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)


// -- SSoverlays --
//#define CUT_OVERLAY_IN(ovr, time) addtimer(CALLBACK(src, /atom/.proc/cut_overlay, ovr), time, TIMER_STOPPABLE | TIMER_CLIENT_TIME)
