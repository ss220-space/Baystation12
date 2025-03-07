// /mob/var/stat things.
#define CONSCIOUS   0
#define UNCONSCIOUS 1
#define DEAD        2

// Bitflags defining which status effects could be or are inflicted on a mob.
#define CANSTUN     0x1
#define CANWEAKEN   0x2
#define CANPARALYSE 0x4
#define CANPUSH     0x8
#define PASSEMOTES  0x10    // Mob has a cortical borer or holders inside of it that need to see emotes.
#define LEAPING     0x16
#define GODMODE     0x1000
#define FAKEDEATH   0x2000  // Replaces stuff like changeling.changeling_fakedeath.
#define NO_ANTAG    0x4000  // Players are restricted from gaining antag roles when occupying this mob
#define NOTARGET    0x8000  // Player is invisible to all simple mobs

// Grab Types
#define GRAB_NORMAL			"normal"
#define GRAB_NAB			"nab"
#define GRAB_NAB_SPECIAL	"special nab"

// Grab levels.
#define NORM_PASSIVE    "normal passive"
#define NORM_STRUGGLE   "normal struggle"
#define NORM_AGGRESSIVE "normal aggressive"
#define NORM_NECK       "normal neck"
#define NORM_KILL       "normal kill"

#define NAB_PASSIVE		"nab passive"
#define NAB_AGGRESSIVE	"nab aggressive"
#define NAB_KILL		"nab kill"

#define BORGMESON 0x1
#define BORGTHERM 0x2
#define BORGXRAY  0x4
#define BORGMATERIAL  8


#define STANCE_SLEEP        0	// Doing (almost) nothing, to save on CPU because nobody is around to notice or the mob died.
#define STANCE_IDLE         1	// The more or less default state. Wanders around, looks for baddies, and spouts one-liners.
#define STANCE_ALERT        2	// A baddie is visible but not too close, and essentially we tell them to go away or die.
#define STANCE_APPROACH     3	// Attempting to get into range to attack them.
#define STANCE_FIGHT	    4	// Actually fighting, with melee or ranged.
#define STANCE_BLINDFIGHT   5	// Fighting something that cannot be seen by the mob, from invisibility or out of sight.
#define STANCE_REPOSITION   6	// Relocating to a better position while in combat. Also used when moving away from a danger like grenades.
#define STANCE_MOVE         7	// Similar to above but for out of combat. If a baddie is seen, they'll cancel and fight them.
#define STANCE_FOLLOW       8	// Following somone, without trying to murder them.
#define STANCE_FLEE         9	// Run away from the target because they're too spooky/we're dying/some other reason.
#define STANCE_DISABLED     10	// Used when the holder is afflicted with certain status effects, such as stuns or confusion.

#define STANCE_ATTACK       11 // Backwards compatability
#define STANCE_ATTACKING    12 // Ditto

#define STANCES_COMBAT      list(STANCE_ALERT, STANCE_APPROACH, STANCE_FIGHT, STANCE_BLINDFIGHT, STANCE_REPOSITION)

#define LEFT  0x1
#define RIGHT 0x2
#define UNDER 0x4

// Pulse levels, very simplified.
#define PULSE_NONE    0   // So !M.pulse checks would be possible.
#define PULSE_SLOW    1   // <60     bpm
#define PULSE_NORM    2   //  60-90  bpm
#define PULSE_FAST    3   //  90-120 bpm
#define PULSE_2FAST   4   // >120    bpm
#define PULSE_THREADY 5   // Occurs during hypovolemic shock
#define GETPULSE_HAND 0   // Less accurate. (hand)
#define GETPULSE_TOOL 1   // More accurate. (med scanner, sleeper, etc.)
#define PULSE_MAX_BPM 250 // Highest, readable BPM by machines and humans.

//intent flags
#define I_HELP		"help"
#define I_DISARM	"disarm"
#define I_GRAB		"grab"
#define I_HURT		"harm"

//These are used Bump() code for living mobs, in the mob_bump_flag, mob_swap_flags, and mob_push_flags vars to determine whom can bump/swap with whom.
#define HUMAN 1
#define MONKEY 2
#define ALIEN 4
#define ROBOT 8
#define SLIME 16
#define SIMPLE_ANIMAL 32
#define HEAVY 64
#define ALLMOBS (HUMAN|MONKEY|ALIEN|ROBOT|SLIME|SIMPLE_ANIMAL|HEAVY)

// Robot AI notifications
#define ROBOT_NOTIFICATION_NEW_UNIT 1
#define ROBOT_NOTIFICATION_NEW_NAME 2
#define ROBOT_NOTIFICATION_NEW_MODULE 3
#define ROBOT_NOTIFICATION_MODULE_RESET 4

// Appearance change flags
#define APPEARANCE_ALL 0xffffff
#define APPEARANCE_DNA2 (1 << 0)
#define APPEARANCE_RACE (1 << 1)
#define APPEARANCE_GENDER (1 << 2)
#define APPEARANCE_SKIN (1 << 3)
#define APPEARANCE_HEAD (1 << 4)
#define APPEARANCE_HEAD_COLOR (1 << 5)
#define APPEARANCE_FACE (1 << 6)
#define APPEARANCE_FACE_COLOR (1 << 7)
#define APPEARANCE_ALL_HAIR (APPEARANCE_HEAD | APPEARANCE_HEAD_COLOR | APPEARANCE_FACE | APPEARANCE_FACE_COLOR)
#define APPEARANCE_EYES (1 << 8)
#define APPEARANCE_LANG (1 << 9)
#define APPEARANCE_LANG_ANY_NUMBER (1 << 10)
#define APPEARANCE_LANG_ANY_ORIGIN (1 << 11)

#define APPEARANCE_COMMON (APPEARANCE_DNA2|APPEARANCE_RACE|APPEARANCE_GENDER|APPEARANCE_SKIN|APPEARANCE_ALL_HAIR|APPEARANCE_EYES|APPEARANCE_LANG)

// Click cooldown
#define DEFAULT_ATTACK_COOLDOWN 8 //Default timeout for aggressive actions
#define DEFAULT_QUICK_COOLDOWN  4

#define FAST_WEAPON_COOLDOWN 3
#define DEFAULT_WEAPON_COOLDOWN 5
#define SLOW_WEAPON_COOLDOWN 7

#define MIN_SUPPLIED_LAW_NUMBER 15
#define MAX_SUPPLIED_LAW_NUMBER 50

// NT's alignment towards the character
#define COMPANY_LOYAL 			"Loyal"
#define COMPANY_SUPPORTATIVE	"Supportive"
#define COMPANY_NEUTRAL 		"Neutral"
#define COMPANY_SKEPTICAL		"Skeptical"
#define COMPANY_OPPOSED			"Opposed"

#define COMPANY_ALIGNMENTS		list(COMPANY_LOYAL,COMPANY_SUPPORTATIVE,COMPANY_NEUTRAL,COMPANY_SKEPTICAL,COMPANY_OPPOSED)

// Defines mob sizes, used by lockers and to determine what is considered a small sized mob, etc.
#define MOB_LARGE  		40
#define MOB_MEDIUM 		20
#define MOB_SMALL 		10
#define MOB_TINY 		5
#define MOB_MINISCULE	1

// Defines how strong the species is compared to humans. Think like strength in D&D
#define STR_VHIGH       2
#define STR_HIGH        1
#define STR_MEDIUM      0
#define STR_LOW        -1
#define STR_VLOW       -2

// Gluttony levels.
#define GLUT_TINY 1       // Eat anything tiny and smaller
#define GLUT_SMALLER 2    // Eat anything smaller than we are
#define GLUT_ANYTHING 4   // Eat anything, ever

#define GLUT_ITEM_TINY 8         // Eat items with a w_class of small or smaller
#define GLUT_ITEM_NORMAL 16      // Eat items with a w_class of normal or smaller
#define GLUT_ITEM_ANYTHING 32    // Eat any item
#define GLUT_PROJECTILE_VOMIT 64 // When vomitting, does it fly out?

// Devour speeds, returned by can_devour()
#define DEVOUR_SLOW 1
#define DEVOUR_FAST 2
/*INF, WAS. SEE MOBS_INF.DM
#define TINT_NONE 0
#define TINT_MODERATE 1
#define TINT_HEAVY 2
#define TINT_BLIND 3
*/
#define FLASH_PROTECTION_VULNERABLE -2
#define FLASH_PROTECTION_REDUCED -1
#define FLASH_PROTECTION_NONE 0
#define FLASH_PROTECTION_MINOR 1
#define FLASH_PROTECTION_MODERATE 2
#define FLASH_PROTECTION_MAJOR 3

#define ANIMAL_SPAWN_DELAY round(config.respawn_delay / 6)
#define DRONE_SPAWN_DELAY  round(config.respawn_delay / 3)

// Incapacitation flags, used by the mob/proc/incapacitated() proc
#define INCAPACITATION_NONE 0
#define INCAPACITATION_RESTRAINED 1
#define INCAPACITATION_BUCKLED_PARTIALLY 2
#define INCAPACITATION_BUCKLED_FULLY 4
#define INCAPACITATION_STUNNED 8
#define INCAPACITATION_FORCELYING 16 //needs a better name - represents being knocked down BUT still conscious.
#define INCAPACITATION_KNOCKOUT 32
#define INCAPACITATION_WEAKENED 64

#define INCAPACITATION_UNRESISTING (INCAPACITATION_KNOCKOUT|INCAPACITATION_STUNNED)
#define INCAPACITATION_DISRUPTED (INCAPACITATION_UNRESISTING|INCAPACITATION_WEAKENED)
#define INCAPACITATION_KNOCKDOWN (INCAPACITATION_KNOCKOUT|INCAPACITATION_FORCELYING)
#define INCAPACITATION_DISABLED (INCAPACITATION_KNOCKDOWN|INCAPACITATION_STUNNED)
#define INCAPACITATION_DEFAULT (INCAPACITATION_RESTRAINED|INCAPACITATION_BUCKLED_FULLY|INCAPACITATION_DISABLED)
#define INCAPACITATION_ALL (~INCAPACITATION_NONE)

// Organs.
#define BP_MOUTH    "mouth"
#define BP_EYES     "eyes"
#define BP_HEART    "heart"
#define BP_LUNGS    "lungs"
#define BP_TRACH	"tracheae"
#define BP_BRAIN    "brain"
#define BP_LIVER    "liver"
#define BP_KIDNEYS  "kidneys"
#define BP_STOMACH  "stomach"
#define BP_PLASMA   "plasma vessel"
#define BP_APPENDIX "appendix"
#define BP_CELL     "cell"
#define BP_COOLING  "cooling system"
#define BP_EXONET   "exonet connection slot"
#define BP_HIVE     "hive node"
#define BP_LARVA    "alien larva" //INF
#define BP_MIMIC    "mimic sac" //INF
#define BP_NUTRIENT "nutrient vessel"
#define BP_ACID     "acid gland"
#define BP_EGG      "egg sac"
#define BP_RESIN    "resin spinner"
#define BP_STRATA   "neural strata"
#define BP_RESPONSE "response node"
#define BP_GBLADDER "gas bladder"
#define BP_POLYP    "polyp segment"
#define BP_ANCHOR   "anchoring ligament"
#define BP_PHORON   "phoron filter"
#define BP_ACETONE  "acetone reactor"
#define BP_GLAND    "alien gland" //INF

// Vox bits.
#define BP_HINDTONGUE "hindtongue"

// Robo Organs.
#define BP_POSIBRAIN         "posibrain"
#define BP_VOICE             "vocal synthesiser"
#define BP_STACK             "stack"
#define BP_OPTICS            "optics"
#define BP_FLOAT             "floatation disc"
#define BP_JETS              "maneuvering jets"
#define BP_COOLING_FINS      "cooling fins"
#define BP_SYSTEM_CONTROLLER "system controller"

//Augmetations
#define BP_AUGMENT_R_ARM         "right arm augment"
#define BP_AUGMENT_L_ARM         "left arm augment"
#define BP_AUGMENT_R_HAND        "right hand augment"
#define BP_AUGMENT_L_HAND        "left hand augment"
#define BP_AUGMENT_R_LEG         "right leg augment"
#define BP_AUGMENT_L_LEG         "left leg augment"
#define BP_AUGMENT_CHEST_ARMOUR   "chest armor augment"
#define BP_AUGMENT_CHEST_ACTIVE  "active chest augment"
#define BP_AUGMENT_HEAD           "head augment"

//Augment flags
#define AUGMENTATION_MECHANIC 1
#define AUGMENTATION_ORGANIC  2

// Limbs.
#define BP_L_FOOT "l_foot"
#define BP_R_FOOT "r_foot"
#define BP_L_LEG  "l_leg"
#define BP_R_LEG  "r_leg"
#define BP_L_HAND "l_hand"
#define BP_R_HAND "r_hand"
#define BP_L_ARM  "l_arm"
#define BP_R_ARM  "r_arm"
#define BP_HEAD   "head"
#define BP_CHEST  "chest"
#define BP_GROIN  "groin"
#define BP_ALL_LIMBS list(BP_CHEST, BP_GROIN, BP_HEAD, BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND, BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)
#define BP_BY_DEPTH list(BP_HEAD, BP_L_HAND, BP_R_HAND, BP_L_ARM, BP_R_ARM, BP_L_FOOT, BP_R_FOOT, BP_L_LEG, BP_R_LEG, BP_GROIN, BP_CHEST)

// Prosthetic helpers.
#define BP_IS_ROBOTIC(org)  ((org) && ((org).status & ORGAN_ROBOTIC))
#define BP_IS_ASSISTED(org) ((org) && ((org).status & ORGAN_ASSISTED))
#define BP_IS_BRITTLE(org)  ((org) && ((org).status & ORGAN_BRITTLE))
#define BP_IS_CRYSTAL(org)  ((org) && ((org).status & ORGAN_CRYSTAL))

// Limb flag helpers
#define BP_IS_DEFORMED(org) ((org) && ((org).limb_flags & ORGAN_FLAG_DEFORMED))

#define SYNTH_BLOOD_COLOUR "#030303"
#define SYNTH_FLESH_COLOUR "#575757"

#define MOB_PULL_NONE 0
#define MOB_PULL_SMALLER 1
#define MOB_PULL_SAME 2
#define MOB_PULL_LARGER 3

//carbon taste sensitivity defines, used in mob/living/carbon/proc/ingest
#define TASTE_HYPERSENSITIVE 3 //anything below 5%
#define TASTE_SENSITIVE 2 //anything below 7%
#define TASTE_NORMAL 1 //anything below 15%
#define TASTE_DULL 0.5 //anything below 30%
#define TASTE_NUMB 0.1 //anything below 150%

//Used by show_message() and emotes
#define VISIBLE_MESSAGE 1
#define AUDIBLE_MESSAGE 2

//used for getting species temp values
#define COLD_LEVEL_1 -1
#define COLD_LEVEL_2 -2
#define COLD_LEVEL_3 -3
#define HEAT_LEVEL_1 1
#define HEAT_LEVEL_2 2
#define HEAT_LEVEL_3 3

//Synthetic human temperature vals
#define SYNTH_COLD_LEVEL_1 50
#define SYNTH_COLD_LEVEL_2 -1
#define SYNTH_COLD_LEVEL_3 -1
#define SYNTH_HEAT_LEVEL_1 500
#define SYNTH_HEAT_LEVEL_2 1000
#define SYNTH_HEAT_LEVEL_3 2000

#define CORPSE_CAN_REENTER 1
#define CORPSE_CAN_REENTER_AND_RESPAWN 2

#define SPECIES_HUMAN		"Human"
#define SPECIES_DIONA		"Diona"
#define SPECIES_VOX			"Vox"
#define SPECIES_VOX_ARMALIS	"Vox Armalis"
#define SPECIES_IPC			"Machine"
#define SPECIES_UNATHI		"Unathi"
#define SPECIES_SKRELL		"Skrell"
#define SPECIES_PROMETHEAN	"Promethean"
#define SPECIES_ALIEN		"Humanoid"
#define SPECIES_ADHERENT	"Adherent"
#define SPECIES_GOLEM		"Golem"
#define SPECIES_YEOSA		"Yeosa'Unathi"
#define SPECIES_VATGROWN	"Vat-Grown Human"
#define SPECIES_SPACER		"Space-Adapted Human"
#define SPECIES_TRITONIAN	"Tritonian"
#define SPECIES_GRAVWORLDER	"Grav-Adapted Human"
#define SPECIES_MULE		"Mule"
#define SPECIES_MONKEY      "Monkey"

#define UNRESTRICTED_SPECIES	list(SPECIES_HUMAN, SPECIES_DIONA, SPECIES_IPC, SPECIES_UNATHI, SPECIES_YEOSA, SPECIES_SKRELL, SPECIES_TRITONIAN, SPECIES_SPACER, SPECIES_VATGROWN, SPECIES_GRAVWORLDER, SPECIES_MULE,\
							SPECIES_RESOMI, SPECIES_TAJARA)//inf
#define RESTRICTED_SPECIES		list(SPECIES_VOX, SPECIES_ALIEN, SPECIES_GOLEM, SPECIES_MANTID_GYNE, SPECIES_MANTID_ALATE, SPECIES_MONARCH_WORKER, SPECIES_MONARCH_QUEEN, \
	SPECIES_XENO) //inf

#define SPECIES_NABBER         "giant armoured serpentid"
#define SPECIES_MONARCH_WORKER "Monarch Serpentid Worker"
#define SPECIES_MONARCH_QUEEN  "Monarch Serpentid Queen"
#define SPECIES_MANTID_ALATE   "Kharmaan Alate"
#define SPECIES_MANTID_GYNE    "Kharmaan Gyne"

#define SURGERY_CLOSED 0
#define SURGERY_OPEN 1
#define SURGERY_RETRACTED 2
#define SURGERY_ENCASED 3

#define STASIS_MISC     "misc"
#define STASIS_CRYOBAG  "cryobag"
#define STASIS_COLD     "cold"

#define AURA_CANCEL 1
#define AURA_FALSE  2
#define AURA_TYPE_BULLET "Bullet"
#define AURA_TYPE_WEAPON "Weapon"
#define AURA_TYPE_THROWN "Thrown"
#define AURA_TYPE_LIFE   "Life"

#define SPECIES_BLOOD_DEFAULT 560

#define SLIME_EVOLUTION_THRESHOLD 10

//Used in mob/proc/get_input
#define MOB_INPUT_TEXT "text"
#define MOB_INPUT_MESSAGE "message"
#define MOB_INPUT_NUM "num"

#define MOB_CLIMB_TIME_SMALL 30
#define MOB_CLIMB_TIME_MEDIUM 50

#define MOB_FACTION_NEUTRAL "neutral"

#define ROBOT_MODULE_TYPE_GROUNDED "grounded"
#define ROBOT_MODULE_TYPE_FLYING   "flying"

#define RADIO_INTERRUPT_DEFAULT 30

#define MOB_FLAG_HOLY_BAD                0x001  // If this mob is allergic to holiness

// More refined version of SA_* ""intelligence"" seperators.
// Now includes bitflags, so to target two classes you just do 'MOB_CLASS_ANIMAL|MOB_CLASS_HUMANOID'
#define MOB_CLASS_NONE 			0	// Default value, and used to invert for _ALL.

#define MOB_CLASS_PLANT			1	// Unused at the moment.
#define MOB_CLASS_ANIMAL		2	// Animals and beasts like spiders, saviks, and bears.
#define MOB_CLASS_HUMANOID		4	// Non-robotic humanoids, including /simple_mob and /carbon/humans and their alien variants.
#define MOB_CLASS_SYNTHETIC		8	// Silicons, mechanical simple mobs, FBPs, and anything else that would pass is_synthetic()
#define MOB_CLASS_SLIME			16	// Everyone's favorite xenobiology specimen (and maybe prometheans?).
#define MOB_CLASS_ABERRATION	32	// Weird shit.
#define MOB_CLASS_DEMONIC		64	// Cult stuff.
#define MOB_CLASS_BOSS			128	// Future megafauna hopefully someday.
#define MOB_CLASS_ILLUSION		256	// Fake mobs, e.g. Technomancer illusions.
#define MOB_CLASS_PHOTONIC		512	// Holographic mobs like holocarp, similar to _ILLUSION, but that make no attempt to hide their true nature.

#define MOB_CLASS_ALL (~MOB_CLASS_NONE)

// For slime commanding.  Higher numbers allow for more actions.
#define SLIME_COMMAND_OBEY		1 // When disciplined.
#define SLIME_COMMAND_FACTION	2 // When in the same 'faction'.
#define SLIME_COMMAND_FRIEND	3 // When befriended with a slime friendship agent.

#define MARKING_TARGET_SKIN 0 // Draw a datum/sprite_accessory/marking to the mob's body, eg. tattoos
#define MARKING_TARGET_HAIR 1 // Draw a datum/sprite_accessory/marking to the mob's hair, eg. color fades
#define MARKING_TARGET_HEAD 2 // Draw a datum/sprite_accessory/marking to the mob's head after their hair, eg. ears, horns

// used in /mob/living/carbon/human/can_inject, and by various callers of that proc
#define CAN_INJECT 1
#define INJECTION_PORT 2
#define INJECTION_PORT_DELAY 3 SECONDS // used by injectors to apply delay due to searching for a port on the injectee's suit


//used by /proc/do_after
#define DO_USER_CAN_MOVE     0x1
#define DO_USER_CAN_TURN     0x2
#define DO_USER_UNIQUE_ACT   0x4
#define DO_USER_SAME_HAND    0x8
#define DO_USER_SAME_ZONE    0x10
#define DO_TARGET_CAN_MOVE   0x20
#define DO_TARGET_CAN_TURN   0x40
#define DO_TARGET_UNIQUE_ACT 0x80
#define DO_SHOW_PROGRESS     0x100
#define DO_PUBLIC_PROGRESS   0x200
#define DO_MOVE_CHECKS_TURFS 0x400
#define DO_FAIL_FEEDBACK     0x800

#define DO_BOTH_CAN_MOVE     (DO_USER_CAN_MOVE | DO_TARGET_CAN_MOVE)
#define DO_BOTH_CAN_TURN     (DO_USER_CAN_TURN | DO_TARGET_CAN_TURN)
#define DO_BOTH_UNIQUE_ACT   (DO_USER_UNIQUE_ACT | DO_TARGET_UNIQUE_ACT)
#define DO_DEFAULT           (DO_SHOW_PROGRESS | DO_USER_SAME_HAND | DO_BOTH_CAN_TURN | DO_FAIL_FEEDBACK)

#define DO_MISSING_USER      (-1)
#define DO_MISSING_TARGET    (-2)
#define DO_INCAPACITATED     (-3)

#define FAKE_INVIS_ALPHA_THRESHOLD 127 // If something's alpha var is at or below this number, certain things will pretend it is invisible.
