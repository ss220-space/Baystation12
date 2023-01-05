/datum/gear/accessory/talisman
	display_name = "bone talisman"
	path = /obj/item/clothing/accessory/necklace/talisman

/datum/gear/accessory/collar
	display_name = "collar selection"
	path = /obj/item/clothing/accessory/necklace/collar

/datum/gear/accessory/collar/New()
	..()
	var/collar = list()
	collar["gold collar"] = /obj/item/clothing/accessory/necklace/collar/gold
	collar["bell collar"] = /obj/item/clothing/accessory/necklace/collar/bell
	collar["spike collar"] = /obj/item/clothing/accessory/necklace/collar/spike
	collar["pink collar"] = /obj/item/clothing/accessory/necklace/collar/pink
	collar["holo collar"] = /obj/item/clothing/accessory/necklace/collar/holo
	gear_tweaks += new/datum/gear_tweak/path(collar)
/*
/datum/gear/music
	display_name = "instruments selection"
	description = "Musical instruments. Be ready for tomatoes and a spoiled eggs!"
	path = /obj/item/device

/datum/gear/music/New()
	..()
	var/instruments = list()
	instruments["violin"] = /obj/item/device/violin
	instruments["guitar"] = /obj/item/device/guitar
	gear_tweaks += new /datum/gear_tweak/path(instruments)
*/
/datum/gear/head/kittyears
	display_name = "fake kitty ears"
	path = /obj/item/clothing/head/kitty/fake
	sort_category = "Earwear"

/datum/gear/eyes/security/goggles
	display_name = "Security HUD goggles"
	path = /obj/item/clothing/glasses/sunglasses/sechud/goggles

/datum/gear/zippo_decorated
	display_name = "zippo (decorated)"
	path = /obj/item/flame/lighter/zippo/infinity
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/accessory/tags
	display_name = "dog tags"
	path = /obj/item/clothing/accessory/badge/dog_tags

/datum/gear/uniform/pmc //Please don't dublicate it in maps anymore, ok?
	display_name = "PMC uniform selection"
	allowed_roles = list(/datum/job/detective, /datum/job/officer, /datum/job/hos)
	path = /obj/item/clothing/under

/datum/gear/uniform/pmc/New()
	..()
	var/pmc = list()
	pmc["SAARE utility uniform"]= /obj/item/clothing/under/saare
	pmc["SAARE combat uniform"]= /obj/item/clothing/under/rank/security/saarecombat
	pmc["PCRC utility uniform"]	= /obj/item/clothing/under/pcrc
	pmc["PCRC formal uniform"]	= /obj/item/clothing/under/pcrcsuit
//	pmc["SCP utility uniform"]	= /obj/item/clothing/under/scp_uniform
	pmc["ZPCI utility uniform"]	= /obj/item/clothing/under/zpci_uniform
	gear_tweaks += new/datum/gear_tweak/path(pmc)
/*
/datum/gear/head/scp_cap
	display_name = "SCP cap"
	path = /obj/item/clothing/head/soft/scp_cap
	allowed_roles = list(/datum/job/detective, /datum/job/officer, /datum/job/hos)
*/
/datum/gear/uniform/corpsi
	display_name = "corporate uniform selection"
	path = /obj/item/clothing/under

/datum/gear/uniform/corpsi/New()
	..()
	var/corpsi = list()
	corpsi["Major Bill's uniform"]		= /obj/item/clothing/under/mbill
	corpsi["Aether uniform"]			= /obj/item/clothing/under/aether
	corpsi["Hephaestus science uniform"]= /obj/item/clothing/under/rank/scientist/corporate/heph
	corpsi["Hephaestus uniform"]		= /obj/item/clothing/under/hephaestus
	corpsi["Ward-Takahashi uniform"]	= /obj/item/clothing/under/wardt
	corpsi["Grayson uniform"]			= /obj/item/clothing/under/grayson
	corpsi["Focal Point uniform"]		= /obj/item/clothing/under/focal
	corpsi["Morpheus uniform"]			= /obj/item/clothing/under/morpheus
	corpsi["Skinner uniform"]			= /obj/item/clothing/under/skinner
	corpsi["DAIS uniform"]				= /obj/item/clothing/under/dais
	gear_tweaks += new/datum/gear_tweak/path(corpsi)


/datum/gear/gloves/insulated
	display_name = "insulated gloves selection"
	path = /obj/item/clothing/gloves/insulated
//	allowed_roles = write_engineers_here
	cost = 3

/datum/gear/gloves/insulated/New()
	..()
	var/glovtype = list()
	glovtype["yellow insulated"] = /obj/item/clothing/gloves/insulated
	glovtype["black insulated"] = /obj/item/clothing/gloves/insulated/black
	glovtype["white insulated"] = /obj/item/clothing/gloves/insulated/white
	gear_tweaks += new/datum/gear_tweak/path(glovtype)

/datum/gear/utility/general_belt
	display_name = "equipment belt"
	path = /obj/item/storage/belt/general

/datum/gear/storage/color_drop_pouches
	display_name = "drop pouches, color selection"
	path = /obj/item/clothing/accessory/storage/white_drop
	cost = 3
	flags = GEAR_HAS_COLOR_SELECTION

/datum/gear/accessory/scarf_inf
	display_name = "special scarfs selection"
	path = /obj/item/clothing/accessory/scarf/inf
	flags = GEAR_HAS_TYPE_SELECTION

/datum/gear/cards_compact
	display_name = "deck of cards (compact)"
	path = /obj/item/deck/compact

/*
/datum/gear/gloves/wristwatch
	display_name = "watch"
	path = /obj/item/clothing/gloves/wristwatch
	cost = 1

/datum/gear/gloves/wristwatch/gold
	display_name = "watch, gold"
	path = /obj/item/clothing/gloves/wristwatch/gold
	cost = 3
*/

/datum/gear/uniform/antiquated_skirt
	display_name = "antiquated skirt"
	path = /obj/item/clothing/under/inf/

/datum/gear/uniform/vice
	display_name = "vice uniform"
	path = /obj/item/clothing/under/inf/vice

/datum/gear/uniform/detective
	display_name = "red 'n black suit"
	path = /obj/item/clothing/under/inf/detective

/datum/gear/uniform/chain_with_shirt
	display_name = "chain jeans"
	path = /obj/item/clothing/under/inf/chain_with_shirt

/datum/gear/uniform/chain_with_shirt
	display_name = "black and white with style"
	path = /obj/item/clothing/under/inf/chain_with_shirt

/datum/gear/uniform/cuttop
	display_name = "grey cuttop"
	path = /obj/item/clothing/under/inf/cuttop

/datum/gear/uniform/cuttop_red
	display_name = "red cuttop"
	path = /obj/item/clothing/under/inf/cuttop_red

/datum/gear/uniform/pinstripe
	display_name = "pinstripe"
	path = /obj/item/clothing/under/inf/pinstripe

/datum/gear/uniform/gotsis_dress_1
	display_name = "red gotsis dress"
	path = /obj/item/clothing/under/inf/gotsis_dress_1

/datum/gear/uniform/gotsis_dress_2
	display_name = "orange gotsis dress"
	path = /obj/item/clothing/under/inf/gotsis_dress_2

/datum/gear/uniform/classic_suit
	display_name = "classic suit"
	path = /obj/item/clothing/under/inf/classic_suit

/datum/gear/uniform/jacket
	display_name = "old style jacket"
	path = /obj/item/clothing/under/inf/jacket


/datum/gear/uniform/blackservice
	display_name = "service uniform selection"
	path = /obj/item/clothing/under/inf/blackservice

/datum/gear/uniform/blackservice/New()
	..()
	var/service = list()
	service["dark service uniform"] = /obj/item/clothing/under/inf/blackservice
	service["brown service uniform"] = /obj/item/clothing/under/inf/blackserviceof
	service["white service uniform"] = /obj/item/clothing/under/inf/whiteservice
	service["white female service uniform"] = /obj/item/clothing/under/inf/whiteservicefem
	gear_tweaks += new/datum/gear_tweak/path(service)

/datum/gear/uniform/harper_uniform
	display_name = "harper uniform"
	path = /obj/item/clothing/under/inf/harper_uniform

/datum/gear/uniform/stripped_shirt
	display_name = "red checkered shirt"
	path = /obj/item/clothing/under/inf/stripped_shirt

/datum/gear/uniform/lify
	display_name = "lify"
	path = /obj/item/clothing/under/inf/lify

/datum/gear/uniform/white_black
	display_name = "white black"
	path = /obj/item/clothing/under/inf/white_black

/datum/gear/uniform/black_white
	display_name = "black white"
	path = /obj/item/clothing/under/inf/black_white

/datum/gear/uniform/biker
	display_name = "biker"
	path = /obj/item/clothing/under/inf/biker

/datum/gear/uniform/formalvest
	display_name = "formal vest"
	path = /obj/item/clothing/under/inf/formalvest

/datum/gear/uniform/callum
	display_name = "callum vest"
	path = /obj/item/clothing/under/inf/callum

/datum/gear/uniform/denimvest
	display_name = "denim vest"
	path = /obj/item/clothing/under/inf/denimvest

/datum/gear/uniform/olympic
	display_name = "olympic clothes"
	path = /obj/item/clothing/under/inf/olympic

/datum/gear/uniform/hm_suit
	display_name = "charcoal vest"
	path = /obj/item/clothing/under/inf/hm_suit

/datum/gear/uniform/mafia
	display_name = "mafia outfit selection"
	path = /obj/item/clothing/under/inf/mafia

/datum/gear/uniform/mafia/New()
	..()
	var/mafia = list()
	mafia["mafia outfit"] = /obj/item/clothing/under/inf/mafia
	mafia["mafia vest"] = /obj/item/clothing/under/inf/mafia/vest
	mafia["white mafia outfit"] = /obj/item/clothing/under/inf/mafia/white
	gear_tweaks += new/datum/gear_tweak/path(mafia)

/datum/gear/uniform/maid
	display_name = "maid dress"
	path = /obj/item/clothing/under/inf/maid

/datum/gear/uniform/noble
	display_name = "artsy suit"
	path = /obj/item/clothing/under/inf/noble


/datum/gear/uniform/hawaiianshirt
	display_name = "hawaiian shirt selection"
	path = /obj/item/clothing/under/inf/redhawaiianshirt

/datum/gear/uniform/hawaiianshirt/New()
	..()
	var/hawaiian = list()
	hawaiian["red hawaiian shirt"] = /obj/item/clothing/under/inf/redhawaiianshirt
	hawaiian["pink hawaiian shirt"] = /obj/item/clothing/under/inf/pinkhawaiianshirt
	hawaiian["yellow hawaiian shirt"] = /obj/item/clothing/under/inf/yellowhawaiianshirt
	hawaiian["blue hawaiian shirt"] = /obj/item/clothing/under/inf/bluehawaiianshirt
	gear_tweaks += new/datum/gear_tweak/path(hawaiian)

/datum/gear/uniform/cuban_suit
	display_name = "rhumba outfit"
	path = /obj/item/clothing/under/inf/cuban_suit

/datum/gear/uniform/victdress
	display_name = "victorian dress selection"
	path = /obj/item/clothing/under/inf/victdress

/datum/gear/uniform/victdress/New()
	..()
	var/dress = list()
	dress["black victorian dress"] = /obj/item/clothing/under/inf/victdress
	dress["red victorian dresst"] = /obj/item/clothing/under/inf/victdress/red
	gear_tweaks += new/datum/gear_tweak/path(dress)

/datum/gear/uniform/victsuit
	display_name = "victorian suit selection"
	path = /obj/item/clothing/under/inf/victsuit

/datum/gear/uniform/victsuit/New()
	..()
	var/victsuit = list()
	victsuit["victorian suit"] = /obj/item/clothing/under/inf/victsuit
	victsuit["red and black victorian suit"] = /obj/item/clothing/under/inf/victsuit/redblk
	victsuit["red victorian suit"] = /obj/item/clothing/under/inf/victsuit/red
	victsuit["dark victorian suit"] = /obj/item/clothing/under/inf/victsuit/twilight
	gear_tweaks += new/datum/gear_tweak/path(victsuit)

/datum/gear/uniform/retro_security
	display_name = "retro security officer's uniform"
	allowed_roles = list(\
	/datum/job/hos, /datum/job/warden, /datum/job/detective, /datum/job/officer, /datum/job/security_assistant)
	path = /obj/item/clothing/under/inf/retro/security

/datum/gear/uniform/retro_medical
	display_name = "retro medical officer's uniform"
	allowed_roles = list(\
	/datum/job/cmo, /datum/job/senior_doctor, /datum/job/doctor,\
	/datum/job/doctor_trainee, /datum/job/explorer_medic,\
	/datum/job/psychiatrist, /datum/job/chemist, /datum/job/roboticist)
	path = /obj/item/clothing/under/inf/retro/medical

/datum/gear/uniform/retro_engineering
	display_name = "retro engineering uniform"
	path = /obj/item/clothing/under/inf/retro/engineering

/datum/gear/uniform/retro_science
	display_name = "retro science officer's uniform"
	path = /obj/item/clothing/under/inf/retro/science

/datum/gear/uniform/aristo
	display_name = "aristo uniform"
	path = /obj/item/clothing/under/inf/aristo

/datum/gear/uniform/milsim
	display_name = "milsim uniform"
	path = /obj/item/clothing/under/inf/milsim

/datum/gear/uniform/rubywhite
	display_name = "rubywhite"
	path = /obj/item/clothing/under/inf/rubywhite

/datum/gear/uniform/faln_trousers
	display_name = "faln trousers"
	path = /obj/item/clothing/under/inf/faln_trousers
