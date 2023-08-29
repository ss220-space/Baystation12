#define RUNLEVEL_INIT EMPTY_BITFIELD
#define RUNLEVEL_LOBBY 0x0001
#define RUNLEVEL_SETUP 0x0002
#define RUNLEVEL_GAME 0x0004
#define RUNLEVEL_POSTGAME 0x0008

#define RUNLEVELS_ALL (~EMPTY_BITFIELD)
#define RUNLEVELS_DEFAULT (RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME)

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


// -- SSoverlays --
//#define CUT_OVERLAY_IN(ovr, time) addtimer(CALLBACK(src, /atom/.proc/cut_overlay, ovr), time, TIMER_STOPPABLE | TIMER_CLIENT_TIME)
