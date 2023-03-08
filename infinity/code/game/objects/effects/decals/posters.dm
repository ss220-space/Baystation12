//spice kittenz posters
/*
/decl/poster/tjpost/New()
	..()
	. = pick(subtypesof(/decl/poster/tjpost))
*/
/obj/structure/sign/poster/tjpost
//	desc = "A large piece of space-resistant printed paper with an emblem of CCA."
	icon = 'infinity/icons/obj/posters.dmi'
	icon_state = "tposter"

/obj/structure/sign/poster/tjpost/New()
	if(!poster_type)
		poster_type = pick(subtypesof(/decl/poster/tjpost))
	..()
/*
/obj/structure/sign/poster/tjpost/tj_1
	icon_state = "tposter_1"
	poster_type = /decl/poster/tjpost/tj_1
*/
/obj/structure/sign/poster/tjpost/tj_2
	icon_state = "tposter_2"
	poster_type = /decl/poster/tjpost/tj_2

/obj/structure/sign/poster/tjpost/tj_3
	icon_state = "tposter_3"
	poster_type = /decl/poster/tjpost/tj_3

/obj/structure/sign/poster/tjpost/tj_4
	icon_state = "tposter_4"
	poster_type = /decl/poster/tjpost/tj_4

/obj/structure/sign/poster/tjpost/tj_5
	icon_state = "tposter_5"
	poster_type = /decl/poster/tjpost/tj_5

/obj/structure/sign/poster/tjpost/tj_6
	icon_state = "tposter_6"
	poster_type = /decl/poster/tjpost/tj_6

/obj/structure/sign/poster/tjpost/tj_7
	icon_state = "tposter_7"
	poster_type = /decl/poster/tjpost/tj_7

/obj/structure/sign/poster/tjpost/tj_8
	icon_state = "tposter_8"
	poster_type = /decl/poster/tjpost/tj_8

/obj/structure/sign/poster/tjpost/tj_9
	icon_state = "tposter_9"
	poster_type = /decl/poster/tjpost/tj_9

/obj/structure/sign/poster/tjpost/tj_10
	icon_state = "tposter_10"
	poster_type = /decl/poster/tjpost/tj_10

/obj/structure/sign/poster/tjpost/tj_11
	icon_state = "tposter_11"
	poster_type = /decl/poster/tjpost/tj_11

/obj/structure/sign/poster/tjpost/tj_12
	icon_state = "tposter_12"
	poster_type = /decl/poster/tjpost/tj_12

/obj/structure/sign/poster/tjpost/tj_13
	icon_state = "tposter_13"
	poster_type = /decl/poster/tjpost/tj_13

/obj/structure/sign/poster/tjpost/tj_14
	icon_state = "tposter_14"
	poster_type = /decl/poster/tjpost/tj_14

/obj/structure/sign/poster/tjpost/tj_15
	icon_state = "tposter_15"
	poster_type = /decl/poster/tjpost/tj_15

/obj/structure/sign/poster/tjpost/tj_16
	icon_state = "tposter_16"
	poster_type = /decl/poster/tjpost/tj_16

/obj/structure/sign/poster/tjpost/tj_17
	icon_state = "tposter_17"
	poster_type = /decl/poster/tjpost/tj_17

/obj/structure/sign/poster/tjpost/tj_18
	icon_state = "tposter_18"
	poster_type = /decl/poster/tjpost/tj_18

/obj/structure/sign/poster/tjpost/tj_19
	icon_state = "tposter_19"
	poster_type = /decl/poster/tjpost/tj_19

/obj/structure/sign/poster/tjpost/tj_20
	icon_state = "tposter_20"
	poster_type = /decl/poster/tjpost/tj_20

/obj/structure/sign/poster/tjpost/tj_21
	icon_state = "tposter_21"
	poster_type = /decl/poster/tjpost/tj_21

/obj/structure/sign/poster/tjpost/tj_22
	icon_state = "tposter_22"
	poster_type = /decl/poster/tjpost/tj_22
/decl/poster/tjpost
	icon_state = "tposter"
	name = "Liberation day"
	desc = "A memorable photo, which depicted how the soldiers of the Kaytam clan raise their flag \
	over the overseer citadel in Naliar. Looks like one of CCA posters..."
/* let's try to not use posters of specific groups, like governments or corporations
/decl/poster/tjpost/tj_1
	icon_state = "tposter_1"
	name = "CCA emblem"
	desc = "A poster with an emblem of CCA."
*/
/decl/poster/tjpost/tj_2
	icon_state = "tposter_2"
	name = "Patriotic poster"
	desc = "It reminds you that the galaxy around is not very friendly, and you should watch your safety yourself."

/decl/poster/tjpost/tj_3
	icon_state = "tposter_3"
	name = "Technical poster"
	desc = "It is a guide on how to use the carabiner TV-3C, there is detailed \
	information about assembly, disassembly, and maintenance, but one of the written dialects of Ahdomai. \
	An another one of CCA posters."

/decl/poster/tjpost/tj_4
	icon_state = "tposter_4"
	name = "Jet poster"
	desc = "It shows one of the most common fighter-interceptor FLA. An image at port shows CCA insignia."

/decl/poster/tjpost/tj_5
	icon_state = "tposter_5"
	name = "Heli-poster"
	desc = "It shows transport helicopters flying over the ruins of the suburbs of Naliar. \
	The photo was taken shortly before the final assault, and saw him every tajaran. \
	An another one historian posters of CCA."

/decl/poster/tjpost/tj_6
	icon_state = "tposter_6"
	name = "FLA MBT-86"
	desc = "It shows one of the FLA MBT used by the eastern forces at the end of the Conflict. \
	An another one historian posters of CCA."

/decl/poster/tjpost/tj_7
	icon_state = "tposter_7"
	name = "Sa'a poster"
	desc = "It offers views of the mountains of Sa'a, Ahdomai."

/decl/poster/tjpost/tj_8
	icon_state = "tposter_8"
	name = "First mech poster"
	desc = "It shows the first combat mech created by the Kaytam clan used in urban combat in Naliar. \
	No CCA symbol, hm..."

/decl/poster/tjpost/tj_9
	icon_state = "tposter_9"
	name = "CCA Army"
	desc = "It shows one of the tanks of Zhan-Hazan, and behind him you can see the attack helicopter."

/decl/poster/tjpost/tj_10
	icon_state = "tposter_10"
	name = "Assault Drones"
	desc = "This poster depicts the flying combat drones times of Ahdomai Conflict."

/decl/poster/tjpost/tj_11
	icon_state = "tposter_11"
	name = "Sunrise on S'Randjiir"
	desc = "The picture was taken from the dome of one of the gas producing factories on it."

/decl/poster/tjpost/tj_12
	icon_state = "tposter_12"
	name = "Ir-Shira class station"
	desc = "One of the mobile station class of Ir-Shira, descended from the shipyards over \
	Adamem to gateway in the neighboring system. CCA insignia at hull."

/decl/poster/tjpost/tj_13
	icon_state = "tposter_13"
	name = "109 year"
	desc = "Each tajaran knows what happened in the 109 year. The first satellite was launched into Ahdomai orbit."

/decl/poster/tjpost/tj_14
	icon_state = "tposter_14"
	name = "298 year"
	desc = "First crew change in orbit of the first space station of Ahdomai."

/decl/poster/tjpost/tj_15
	icon_state = "tposter_15"
	name = "Winter night"
	desc = "You see one of the quiet winter nights of Ahdomai, \
	it becomes easier from the memories of the beauty of your home. Even if you aren't tajara."

/decl/poster/tjpost/tj_16
	icon_state = "tposter_16"
	name = "Ta'Apa Charka"
	desc = "One of the icebergs on the holy land for tajaran."

/decl/poster/tjpost/tj_17
	icon_state = "tposter_17"
	name = "Maya'Thcha mountaints"
	desc = "Mountains Maya'Thcha in its beauty, Ahdomai."

/decl/poster/tjpost/tj_18
	icon_state = "tposter_18"
	name = "Sunrise in the forest"
	desc = "Sunrise in one of the forests. Nice and simple. Naturally. Corporative woodchoppers will be there soon..."

/decl/poster/tjpost/tj_19
	icon_state = "tposter_19"
	name = "Bayan"
	desc = "The Bayan village in the winter. Looks like some old wooden town at hill..."

/decl/poster/tjpost/tj_20
	icon_state = "tposter_20"
	name = "Mirr-Shorrkra"
	desc = "View of Mirr-Shorrkra from the Naff'Yark, Ahdomai."

/decl/poster/tjpost/tj_21
	icon_state = "tposter_21"
	name = "Unknown liberator"
	desc = "You can see the beautiful spokeswoman of tajara that fought for the liberation of Ahdomai \
	during a long war."

/decl/poster/tjpost/tj_22
	icon_state = "tposter_22"
	name = "Mryarov Mraporting"
	desc = "There is a drone blimp-bomber of the Kaytam clan."

//spess humen posterz (humpost-kompost hddd)
/*
/decl/poster/humpost/New()
	..()
	if(!poster_type)
		poster_type = pick(subtypesof(/decl/poster/humpost))
*/

/obj/structure/sign/poster/humpost
	name = "poster"
	icon = 'infinity/icons/obj/posters.dmi'
	icon_state= "humposter"

/obj/structure/sign/poster/humpost/New()
	if(!poster_type)
		poster_type = pick(subtypesof(/decl/poster/humpost))
	..()
/* animated paper?...
/obj/structure/sign/poster/humpost/hum_1
	icon_state = "humposter_1"
	poster_type = /decl/poster/humpost/hum_1
*/
/*let's try to not use posters of specific groups, like governments or corporations
/obj/structure/sign/poster/humpost/hum_2
	icon_state = "humposter_2"
	poster_type = /decl/poster/humpost/hum_2
*/
/obj/structure/sign/poster/humpost/hum_3
	icon_state = "humposter_3"
	poster_type = /decl/poster/humpost/hum_3
/* unused due someone's report
/obj/structure/sign/poster/humpost/hum_4
	icon_state = "humposter_4"
	poster_type = /decl/poster/humpost/hum_4
*/
/obj/structure/sign/poster/humpost/hum_5
	icon_state = "humposter_5"
	poster_type = /decl/poster/humpost/hum_5
/*let's try to not use posters of specific groups, like governments or corporations
/obj/structure/sign/poster/humpost/hum_6
	icon_state = "humposter_6"
	poster_type = /decl/poster/humpost/hum_6
*/
/obj/structure/sign/poster/humpost/hum_7
	icon_state = "humposter_7"
	poster_type = /decl/poster/humpost/hum_7

/obj/structure/sign/poster/humpost/hum_8
	icon_state = "humposter_8"
	poster_type = /decl/poster/humpost/hum_8

/obj/structure/sign/poster/humpost/hum_9
	icon_state = "humposter_9"
	poster_type = /decl/poster/humpost/hum_9

/obj/structure/sign/poster/humpost/hum_10
	icon_state = "humposter_10"
	poster_type = /decl/poster/humpost/hum_10

/obj/structure/sign/poster/humpost/hum_11
	icon_state = "humposter_11"
	poster_type = /decl/poster/humpost/hum_11

/obj/structure/sign/poster/humpost/hum_12
	icon_state = "humposter_12"
	poster_type = /decl/poster/humpost/hum_12

/obj/structure/sign/poster/humpost/hum_13
	icon_state = "humposter_13"
	poster_type = /decl/poster/humpost/hum_13

/obj/structure/sign/poster/humpost/hum_14
	icon_state = "humposter_14"
	poster_type = /decl/poster/humpost/hum_14
/* we need something like 'contraband = 1' for this sort of posters, cause too political
/obj/structure/sign/poster/humpost/hum_15
	icon_state = "humposter_15"
	poster_type = /decl/poster/humpost/hum_15
*/
/obj/structure/sign/poster/humpost/hum_16
	icon_state = "humposter_16"
	poster_type = /decl/poster/humpost/hum_16

/obj/structure/sign/poster/humpost/hum_17
	icon_state = "humposter_17"
	poster_type = /decl/poster/humpost/hum_17

/obj/structure/sign/poster/humpost/hum_18
	icon_state = "humposter_18"
	poster_type = /decl/poster/humpost/hum_18

/obj/structure/sign/poster/humpost/hum_19
	icon_state = "humposter_19"
	poster_type = /decl/poster/humpost/hum_19
/*
/obj/structure/sign/poster/humpost/hum_20
	icon_state = "humposter_20"
	poster_type = /decl/poster/humpost/hum_20
*/
/obj/structure/sign/poster/humpost/hum_21
	icon_state = "humposter_21"
	poster_type = /decl/poster/humpost/hum_21

/decl/poster/humpost
	icon_state = "humposter"
	name = "Moon City"
	desc = "A photo of the oldest city at the Moon, Sol System - Selena. Looks like it was taken from one of observation towers."

/* animated paper?...
/decl/poster/humpost/hum_1
	icon_state = "humposter_1"
	name = "SCG Peacemakers"
	desc = "Poster calling to join the ranks of the peacemaking forces of the SCG... Wow, it's animated!"
*/
/* let's try to not use posters of specific groups, like governments or corporations
/decl/poster/humpost/hum_2
	icon_state = "humposter_2"
	name = "NanoTrasen"
	desc = "Boring poster of a boring corporation with boring text from a boring person. Smells like profit."
*/
/decl/poster/humpost/hum_3
	icon_state = "humposter_3"
	name = "Bodka"
	desc = "Advertising poster of vodka, drink from real men for real men. Feel like a space bear."
/* unused due someone's report
/decl/poster/humpost/hum_4
	icon_state = "humposter_4"
	name = "S.A.L.O."
	desc = "This poster has a beautiful view of a golden field under azure skies. \
	In the corner - a package of fat, which looks at you seductive boar. Salo - zakuson for real men!"
*/
/decl/poster/humpost/hum_5
	icon_state = "humposter_5"
	name = "Mars Terraforming"
	desc = "What it was before and what it is now. Our future is in our hands."
/* let's try to not use posters of specific groups, like governments or corporations
/decl/poster/humpost/hum_6
	icon_state = "humposter_6"
	name = "SCG emblem"
	desc = "Patriotic poster with an emblem of SCG and some dull text for marine recruiters on it."
*/
/decl/poster/humpost/hum_7
	icon_state = "humposter_7"
	name = "Jeneva"
	desc = "Uhh, Geneva!"

/decl/poster/humpost/hum_8
	icon_state = "humposter_8"
	name = "Alpha Centauri"
	desc = "This poster is dedicated to the colonization of Alpha Centauri, one of the oldest human colonies."

/decl/poster/humpost/hum_9
	icon_state = "humposter_9"
	name = "Gateway"
	desc = "In 2171 first gateway is built in the solar system, connecting it with the Tau Ceti system."

/decl/poster/humpost/hum_10
	icon_state = "humposter_10"
	name = "Bluespace Illuminator"
	desc = "In 2145, humanity accidentally opened the blue space, and on the poster one of the pictures taken from \
	inside the first ship that got there."

/decl/poster/humpost/hum_11
	icon_state = "humposter_11"
	name = "Sea"
	desc = "On the poster view from one of the Islands of Bermuda. A great place, a ticket to which can buy the \
	best workers for only 999.9 thallers."

/decl/poster/humpost/hum_12
	icon_state = "humposter_12"
	name = "First Martian"
	desc = "Jimmy Gideon is the first man to set foot on Mars, the first Martian, the first father of the Governor of \
	Mars."

/decl/poster/humpost/hum_13
	icon_state = "humposter_13"
	name = "Expedition"
	desc = "2301: the Twenty-third Moges expedition started EC."

/decl/poster/humpost/hum_14
	icon_state = "humposter_14"
	name = "Olympus"
	desc = "Spires of Olympus - the capital of Mars and Sol Central Government."
/* we need something like 'contraband = 1' for this sort of posters, cause too political
/decl/poster/humpost/hum_15
	icon_state = "humposter_15"
	name = "Gaya"
	desc = "Join the SCG fleet! Liberate Gaia! Avenge your comrades! Kill Gilgamesh agressors!.. \
	Some old poster from old days."
*/
/decl/poster/humpost/hum_16
	icon_state = "humposter_16"
	name = "Venus"
	desc = "View of one of the best resorts in the galaxy - Verena resorts. Venus - the most expensive, \
	popular and pleasant place to stay!"

/decl/poster/humpost/hum_17
	icon_state = "humposter_17"
	name = "First Spacecraft"
	desc = "2284: the First spacecraft of mankind, equipped with bluespace engine makes its first successful jump."

/decl/poster/humpost/hum_18
	icon_state = "humposter_18"
	name = "WetSkrell"
	desc = "You can see a pretty skrell in red dress and with long headtails, which have decorative bands. \
	It is advertising a site with \"adult recreation procedures\", the wetskrell.nt."

/decl/poster/humpost/hum_19
	icon_state = "humposter_19"
	name = "Explorer"
	desc = "You see a very pumped-up guy with a huge machete. He has good muscle and a face of a real man. \
	You can also read a text at bottom: \"Join the ranks of the Expeditionary Corps - see the start, \
	explore the university!\"... And die far away from home at god-forgotten planet for low payment, yeah."
/*
/decl/poster/humpost/hum_20
	icon_state = "humposter_20"
	name = "Free poster slot"
	desc = "Your desc here"
*/
/decl/poster/humpost/hum_21
	icon_state = "humposter_21"
	name = "Lusty Xeno Specie"
	desc = "An another one poster about some pornsite with potential new sexual xeno species... \
	Who the fuck forget it at the space vessel? May be we haven't enought time with families, but we aren't so mad... \
	Or we are?"


//  ---------------------------  //
//  SS220 2023 New Year contest  //
//  ---------------------------  //

/decl/poster/nyc_adme_midala
	// by KandJX
	icon_state = "adme_midala"
	name = "Adme Midala"
	desc = "Постер известной актрисы-политика времен позднего Терранского содружества на фоне Луны. \
	Девушка держит в руках старый пистолет модели Colt1911 и смотрит прямо вам в глаза. \
	От неё веет одновременно и изящностью, и решительностью. \
	Текст на постере гласит \"Stop the Martians\"."

/decl/poster/nowallspawn/nyc_evening_before_12
	// by Den10901
	icon_state = "evening_before_12"
	name = "Evening before 12"
	desc = "Some old poster, colours faded a long time ago, only a few shades of green \
	and red can be seen. Is it tajaran? Old man? Santa? \"Died Moroz\"? There's \
	no answer on poster."

/decl/poster/nyc_know_the_enemy
	// by NAKAII
	icon_state = "know_the_enemy"
	name = "Beware the pirates!"
	desc = "A foreboding poster depicting the mask of a blood-red hardsuit. The caption \
	reads \"Know the enemy!\". There is also a tiny marking at the bottom of the poster, \
	it reads: \"Beware the frontier pirates!\""

/decl/poster/nyc_mine
	// by Скавен-крыс
	icon_state = "mine"
	name = "Mine"
	desc = "Even in space, the profession of miners is in demand. And this poster \
	from Grayson Manufactories Ltd. encourages you to pick up a pickaxe and start \
	mining! \"We mining all, even space!\""

/decl/poster/nyc_forge
	// by Скавен-крыс
	icon_state = "forge"
	name = "Forge"
	desc = "In the poster you see many shuttles and ships flying into the unknown of space. \"Many ships and shuttles \
	go to different corners of the galaxy in search of resources, and the miners on them \
	forge their own destiny, for it is in their hands!\" \
	A small tag at the bottom indicates that this poster is sponsored by Grayson Manufactories - HRM"

/decl/poster/nyc_space_dwarf
	// by Скавен-крыс
	icon_state = "spacedwarf"
	name = "Space Dwarf"
	desc = "This poster shows a bearded man with a mug of beer. \"After your shift at the mine, \
	it's always a good idea to go to the bar and refresh yourself with a cold mug of beer. After all, no one will  \
	judge you for wiping your pants and dancing drunk.\" The tag at the bottom \
	of the poster indicates that the poster is sponsored by Grayson Manufactories - HRM"

/decl/poster/nyc_good_old_times
	// by Скавен-крыс
	icon_state = "goodoldtimes"
	name = "Good Old Times"
	desc = "A poster with a character from the old days, no one remembers his name, but they usually talk about him in a good way"

/decl/poster/nyc_tersten_ranger
	// by Wastelander41
	icon_state = "tersten_ranger"
	name = "Tersten Ranger"
	desc = "Alsar Treiss is the first unathi on Tersten to become a Ranger. \
	Huge as a mountain, so is his gun. There is a small note in the corner: \
	Patrolling Tersten almost makes you wish for a nuclear winter."

/decl/poster/nyc_blood_donation
	// by Kysovich
	icon_state = "blood_donation"
	name = "Стань донором крови!"
	desc = "Плакат на недорогой бумаге, агитирующий сдать кровь или аналогичную \
	биологическую жидкость в ближайшем медицинском учреждении NanoTrasen. \
	Надпись на плакате гласит: \"Даже один стакан крови может спасти жизнь \
	ценного сотрудника!\"."

/decl/poster/nowallspawn/nyc_krotovuha
	// by Andrei
	icon_state = "krotovuha"
	name = "Krotovuha"
	desc = "Krotovuha is a tincture of a space mole, could be found in the ICCG territory. \
	Usually made in a very small amounts by some moonshiners. It has a very unique flavor \
	many people would compare to spirit with stale earth after rain in a deciduous forest. \
	(ICCG Ministry of Health advises against consumption due to possible helminths or \
	other infection)."

/decl/poster/nyc_gas_advertisement
	// by God Damn Turkey
	icon_state = "gas_advertisement"
	name = "Giant Armoured Serpentid"
	desc = "Buy them today - they'll work whole their life without salary because they LOVE working!"

/decl/poster/nowallspawn/nyc_the_goushque
	// by tomatik
	icon_state = "the_goushque"
	name = "The Goushque"
	desc = "Derived from Old French, A Goushque, or how they say it, Le Goushque is a tailless \
	amphibian with a short squat body, moist smooth skin, and very long hind legs for leaping."

/decl/poster/nowallspawn/nyc_grinch
	// by Mata
	icon_state = "grinch"
	name = "Grinch"
	desc = "Find this bastard and don't let him ruin our holiday! Remuneration is attached.	"

/decl/poster/nyc_work_for_profit
	// by Kysovich
	icon_state = "work_for_profit"
	name = "Work for profit"
	desc = "Always remember why you are here. Do your job, make more money for corp, \
	waste less money of corp. This is how things work in NanoTrasen."

/decl/poster/nowallspawn/nyc_toolbox
	// by PyotrTheTchaikowsky
	icon_state = "toolbox"
	name = "Toolbox"
	desc = "You see a slightly battered poster, which shows a RED toolbox and the \
	inscription \"Danger, very robust!\", some people say that this red paint on \
	the poster is made of real blood."

/decl/poster/nyc_obey
	// by PyotrTheTchaikowsky
	icon_state = "obey"
	name = "Obey"
	desc = "There is something more powerful than your weapon here, bureaucracy, \
	just accept it and obey."

/decl/poster/nowallspawn/nyc_imperium_we_see
	// by Derp
	icon_state = "imperium_we_see"
	name = "Imperium"
	desc = "A hastily made poster on cheap paper. Someone really dislikes Resomi, \
	since he decided to make this poster. Everyone knows that the Imperials won't \
	come here. Isn't that right?"

/decl/poster/nowallspawn/nyc_xeno_inferiority
	// by Iceberg
	icon_state = "xeno_inferiority"
	name = "XENO INFERIORITY"
	desc = "Propaganda poster sponsored by Rage of Humanity. Aimed at reminding a \
	REAL HUMAN about the importance of preserving jobs and living space for \
	new generations."


/decl/poster/nyc_multipassport
	// by Derp
	icon_state = "multipassport"
	name = "Multipassport"
	desc = "An old border service poster, below you can see the text: \"Regardless \
	of what system you are from and what planet you were born on, carry your passports \
	with you. A passport is a thing that everyone must have.\""

/decl/poster/nyc_space_escort
	// by dj-34
	icon_state = "space_escort"
	name = "Space Escort"
	desc = "A poster advertising a space escort service on high-speed shuttles. It says \
	\"We will will bring our client to any location - quickly, safely and comfortably!\""

/decl/poster/nyc_annoyed_gas
	// by SuhEugene
	icon_state = "annoyed_gas"
	name = "Annoyed GAS"
	desc = "The poster shows a chittering Giant Armored Serpentid with its scythe arms \
	raised and ready to attack. \"Run!\" is written in big red letters, and at the very \
	bottom there is a small text: \"If during the communication process the GAS began to \
	actively chitter, buzz, raised sickles or strikes in the air with them - you must turn \
	around and leave him alone.\""

/decl/poster/nyc_healthy_hugs
	// by SuhEugene
	icon_state = "healthy_hugs"
	name = "Healthy hugs"
	desc = "The poster shows a Giant Armored Serpentid holding a girl with a yellow flower \
	in her hair with sickles. On the left - a large inscription \"HUGS\" in green letters, \
	under which it is written in small letters: \"Hugs are useful both morally and physically: \
	for example, the human race lowers blood pressure and produces oxytocin. Almost any crew \
	will increase confidence and feel good. The main thing is - be sure to ask permission.\""

/decl/poster/nowallspawn/nyc_pizza_for_captain
	// by SuhEugene
	icon_state = "pizza_for_captain"
	name = "Pizza for Captain"
	desc = "On fairly cheap thick paper, the red inscription reads: \"Pizza for Captain\". \
	The slice of pizza itself is also drawn... with pineapples? Wouldn't eat this for anything! \
	Someone apparently doesn't like the captain very much..."

/decl/poster/nyc_unusual_gas
	// by SuhEugene
	icon_state = "unusual_gas"
	name = "Unusual GAS"
	desc = "The poster shows a Giant Armored Serpentid. On his tail is what appears to be a large \
	black gaiter with purple stripes. GAS sickles are dressed in cute little mitts of the same \
	color. The entire lower right corner of the poster is occupied by a large inscription \"uwu\", \
	and in the lower left it says: \"More on our site - WetSkrell.nt\"."

/decl/poster/nyc_unathi_mercenaries
	// by Wastelander41
	icon_state = "unathi_mercenaries"
	name = "Unathi mercenaries"
	desc = "A poster depicting an unathi mercenary band named \"Black Bones\". You can see three \
	figures wearing custom heavy armor with lots of pouches, you can probably tell half of those \
	stuffed with protein bricks and not magazines. This particular band wearing all-black and dyes \
	their scales with dark paint, they are famous for bringing heaviest firearms on the battlefield, \
	which look like toys on them."

/decl/poster/nyc_wanted
	// by PyotrTheTchaikowsky
	icon_state = "wanted"
	name = "Wanted!"
	desc = "On the poster you can see: a bald, black-eyed woman, age 30, and she is wanted in \
	the vastness of the entire SCG space. What did she do to be so wanted..."

/decl/poster/nyc_big_brother
	// by Semonic_
	icon_state = "big_brother"
	name = "BIG BROTHER"
	desc = "Never forget that you can be followed at any moment. Even when you enjoy privacy and tranquility."

/decl/poster/nyc_wild_cargo
	// by PyotrTheTchaikowsky
	icon_state = "wild_cargo"
	name = "Wild Cargo"
	desc = "The beautiful wild place with their own sheriff."


/decl/poster/nyc_mad_nymph
	// by den4ik
	icon_state = "mad_nymph"
	name = "Mad Nymph"
	desc = "На постере изображена небольшая нимфа. Нимфы каждый раз злятся, когда ты им не можешь \
	дать крови, отводите таких в медицинский отдел и они предоставят вам немного."

/decl/poster/nyc_doctor_griefsey
	// by God Damn Turkey
	icon_state = "doctor_griefsey"
	name = "Dr. Griefsey"
	desc = "Doctor Griefsey states: \"Drinking is redundant expenses of your corporate salary for treating your liver!\""

/decl/poster/nowallspawn/nyc_equality
	// by God Damn Turkey
	icon_state = "equality"
	name = "EQUALITY"
	desc = "A ripped of poster, that was showing a tajaran in HoS uniform. Nothing besides the title can be read."

/decl/poster/nyc_report
	// by PyotrTheTchaikowsky
	icon_state = "report"
	name = "Report"
	desc = "Always remember to report your superiors"

/decl/poster/nyc_do_not_disturb
	// by Derp
	icon_state = "do_not_disturb"
	name = "Do not disturb"
	desc = "A medical department poster that says \"do not disturb\" at the bottom. On the \
	poster, you can see a surgeon in the middle of an operation covering a body on the \
	table from someone with his hand. You can also see an empty drip, drops of blood on \
	the floor, a flat pulse line... Hell, there is a body bag on the table. Glory to the \
	free medicine of NanoTrasen!"

/decl/poster/nyc_cabbage_tray
	// by SuhEugene
	icon_state = "cabbage_tray"
	name = "Cabbage tray"
	desc = "The poster shows a Giant Armored Serpentid with a hydroponic tray of ripe cabbage \
	in front of it, indicated by a green indicator on it. On the left side of the poster it \
	says: \"Most GAS don't know how to cut existing plantings. Please don't plant all the \
	trays and leave a few free ones. In order for the serpentid to eat, it only needs literally \
	a couple of empty trays.\""

/decl/poster/nyc_no_alcohol
	// by SuhEugene
	icon_state = "no_alcohol"
	name = "СП * РТ"
	desc = "At the very top of the poster is a word, where one of the letters is replaced by an \
	asterisk: \"СП * РТ\", and below - two signatures. The first: \"o - сила\", the second \
	\"и - могила\". The poster is clean and without small text, which makes it clear the \
	seriousness of the statement."

/decl/poster/nyc_attention
	// by Derp
	icon_state = "attention"
	name = "Attention!"
	desc = "\"Attention! Thank you for attention!\" - written on the poster. This appears to be \
	an old poster from the Human Resources Department, aimed at making employees more attentive \
	and willing to read every instruction they see."

/decl/poster/nyc_shirisai
	// by Derp
	icon_state = "shirisai"
	name = "Shirisai"
	desc = "Shirisai - the home planet of Resomi. A cold and snowy world, mostly covered in tundra. \
	And why do many resomi flee from there?"

/decl/poster/nyc_would_you_plant
	// by SuhEugene
	icon_state = "would_you_plant"
	name = "Засадил бы?"
	desc = "Большой зелёный постер, на котором изображён совершенно новый гидропонический лоток. \
	Сверху - большой текст с вызывающим вопросом: \"Засадил бы?\", маленьким текстом пояснённый: \
	\"Гидропонические лотки позволяют быстро и эффективно выращивать абсолютно любые культуры, а \
	индикаторы подскажут, когда за растением нужен уход! И как в такой не засадить?\""

/decl/poster/nyc_unexplored_species
	// by PyotrTheTchaikowsky
	icon_state = "unexplored_species"
	name = "Unexplored species"
	desc = "Poster made to promote space exploration and depicting fictional alien. You see a \
	wild-looking creature, a little bit similar to Unathi, but clearly not the same. Behind you \
	can see a rocky world with rivers of lava. Small note in the corner reads: \"The galaxy is \
	so big and how much there is to explore!\""

/decl/poster/nyc_imperium_calls
	// by Derp
	icon_state = "imperium_calls"
	name = "Imperium calls"
	desc = "An old shabby propaganda poster. On the poster you can see some kind of cold planet \
	and a calling resomi with a coat of arms. There are no corners at the lower part of the poster, \
	probably someone tried to rip it off, but he did not have enough height."

/decl/poster/nyc_xmas_gas
	// by PyotrTheTchaikowsky
	icon_state = "xmas_gas"
	name = "Xmas GAS"
	desc = "The poster depicts the GAS that is dressed up like a Xmas tree, wish you a Merry Xmas and a happy New Year!"

/decl/poster/nyc_future_is_us
	// by Nevek
	icon_state = "future_is_us"
	name = "Future is Us"
	desc = "Propaganda poster. The poster depicts a human-explorer in a voidsuit, holding a helmet in \
	his hand. The poster says \"Future is us\". There is an outer space on a background. Isn't it \
	worth wearing a helmet in space?"

/decl/poster/nowallspawn/nyc_together
	// by TiranShot
	icon_state = "together"
	name = "Together"
	desc = "A handmade poster. The poster depicts the coat of arms of the new Resomi union in the form \
	of three multi-colored feathers. The poster says \"Unite, feathers\", \"Let's build a new house\"."

/decl/poster/nyc_zeng_hu_pharmaceuticals
	// by KoKoC
	icon_state = "zeng_hu_pharmaceuticals"
	name = "Zeng-Hu Pharmaceuticals"
	desc = "This is a poster advertising Zeng-Hu Pharmaceuticals corporation. It shows a beaker filled \
	with a blue substance and a simple DNA picture. Also there are an unknown scientist in a white \
	labcoat. You can see some text in the bottom. \"The largest pharmaceutical company is ready to \
	provide you with any medical products for an extremely favorable price. All research is LEGAL!\""

/decl/poster/nyc_keep_clean
	// by Фанзиль
	icon_state = "keep_clean"
	name = "Keep clean"
	desc = "On the poster you see a scalpel depicted on a blue background. The scalpel is so clean it's \
	shiny. The poster reminds of the importance of keeping surgical instruments sterile. The NT logo is \
	visible at the bottom left."

/decl/poster/nyc_good_mood_sponsor
	// by Dobre Pachantok / pudge_xxl
	icon_state = "good_mood_sponsor"
	name = "Good Mood Sponsor"
	desc = "A poster featuring different cocktails like Sugar Rush, Manhattan and others. A large \
	inscription is visible: \"The best way to forget insults and cheer up is alcohol!\""

/decl/poster/nowallspawn/nyc_true_hero
	// by Derp
	icon_state = "true_hero"
	name = "True hero"
	desc = "Shabby, hand-painted paper torn from the sides. It looks like it used to be a label either \
	on a barrel or on a container. The poster shows a janitor in a darkened room, it looks like he came \
	there to change lights. Below you can see the postscript: \"True hero\"."


/obj/structure/sign/poster/nyc/adme_midala
	icon_state = "adme_midala"
	poster_type = /decl/poster/nyc_adme_midala

/obj/structure/sign/poster/nyc/evening_before_12
	icon_state = "evening_before_12"
	poster_type = /decl/poster/nowallspawn/nyc_evening_before_12

/obj/structure/sign/poster/nyc/know_the_enemy
	icon_state = "know_the_enemy"
	poster_type = /decl/poster/nyc_know_the_enemy

/obj/structure/sign/poster/nyc/mine
	icon_state = "mine"
	poster_type = /decl/poster/nyc_mine

/obj/structure/sign/poster/nyc/tersten_ranger
	icon_state = "tersten_ranger"
	poster_type = /decl/poster/nyc_tersten_ranger

/obj/structure/sign/poster/nyc/blood_donation
	icon_state = "blood_donation"
	poster_type = /decl/poster/nyc_blood_donation

/obj/structure/sign/poster/nyc/krotovuha
	icon_state = "krotovuha"
	poster_type = /decl/poster/nowallspawn/nyc_krotovuha

/obj/structure/sign/poster/nyc/gas_advertisement
	icon_state = "gas_advertisement"
	poster_type = /decl/poster/nyc_gas_advertisement

/obj/structure/sign/poster/nyc/the_goushque
	icon_state = "the_goushque"
	poster_type = /decl/poster/nowallspawn/nyc_the_goushque

/obj/structure/sign/poster/nyc/grinch
	icon_state = "grinch"
	poster_type = /decl/poster/nowallspawn/nyc_grinch

/obj/structure/sign/poster/nyc/work_for_profit
	icon_state = "work_for_profit"
	poster_type = /decl/poster/nyc_work_for_profit

/obj/structure/sign/poster/nyc/toolbox
	icon_state = "toolbox"
	poster_type = /decl/poster/nowallspawn/nyc_toolbox

/obj/structure/sign/poster/nyc/obey
	icon_state = "obey"
	poster_type = /decl/poster/nyc_obey

/obj/structure/sign/poster/nyc/imperium_we_see
	icon_state = "imperium_we_see"
	poster_type = /decl/poster/nowallspawn/nyc_imperium_we_see

/obj/structure/sign/poster/nyc/xeno_inferiority
	icon_state = "xeno_inferiority"
	poster_type = /decl/poster/nowallspawn/nyc_xeno_inferiority

/obj/structure/sign/poster/nyc/multipassport
	icon_state = "multipassport"
	poster_type = /decl/poster/nyc_multipassport

/obj/structure/sign/poster/nyc/space_escort
	icon_state = "space_escort"
	poster_type = /decl/poster/nyc_space_escort

/obj/structure/sign/poster/nyc/annoyed_gas
	icon_state = "annoyed_gas"
	poster_type = /decl/poster/nyc_annoyed_gas

/obj/structure/sign/poster/nyc/healthy_hugs
	icon_state = "healthy_hugs"
	poster_type = /decl/poster/nyc_healthy_hugs

/obj/structure/sign/poster/nyc/pizza_for_captain
	icon_state = "pizza_for_captain"
	poster_type = /decl/poster/nowallspawn/nyc_pizza_for_captain

/obj/structure/sign/poster/nyc/unusual_gas
	icon_state = "unusual_gas"
	poster_type = /decl/poster/nyc_unusual_gas

/obj/structure/sign/poster/nyc/unathi_mercenaries
	icon_state = "unathi_mercenaries"
	poster_type = /decl/poster/nyc_unathi_mercenaries

/obj/structure/sign/poster/nyc/wanted
	icon_state = "wanted"
	poster_type = /decl/poster/nyc_wanted

/obj/structure/sign/poster/nyc/big_brother
	icon_state = "big_brother"
	poster_type = /decl/poster/nyc_big_brother

/obj/structure/sign/poster/nyc/wild_cargo
	icon_state = "wild_cargo"
	poster_type = /decl/poster/nyc_wild_cargo

/obj/structure/sign/poster/nyc/mad_nymph
	icon_state = "mad_nymph"
	poster_type = /decl/poster/nyc_mad_nymph

/obj/structure/sign/poster/nyc/doctor_griefsey
	icon_state = "doctor_griefsey"
	poster_type = /decl/poster/nyc_doctor_griefsey

/obj/structure/sign/poster/nyc/equality
	icon_state = "equality"
	poster_type = /decl/poster/nowallspawn/nyc_equality

/obj/structure/sign/poster/nyc/report
	icon_state = "report"
	poster_type = /decl/poster/nyc_report

/obj/structure/sign/poster/nyc/do_not_disturb
	icon_state = "do_not_disturb"
	poster_type = /decl/poster/nyc_do_not_disturb

/obj/structure/sign/poster/nyc/cabbage_tray
	icon_state = "cabbage_tray"
	poster_type = /decl/poster/nyc_cabbage_tray

/obj/structure/sign/poster/nyc/no_alcohol
	icon_state = "no_alcohol"
	poster_type = /decl/poster/nyc_no_alcohol

/obj/structure/sign/poster/nyc/attention
	icon_state = "attention"
	poster_type = /decl/poster/nyc_attention

/obj/structure/sign/poster/nyc/shirisai
	icon_state = "shirisai"
	poster_type = /decl/poster/nyc_shirisai

/obj/structure/sign/poster/nyc/would_you_plant
	icon_state = "would_you_plant"
	poster_type = /decl/poster/nyc_would_you_plant

/obj/structure/sign/poster/nyc/unexplored_species
	icon_state = "unexplored_species"
	poster_type = /decl/poster/nyc_unexplored_species

/obj/structure/sign/poster/nyc/imperium_calls
	icon_state = "imperium_calls"
	poster_type = /decl/poster/nyc_imperium_calls

/obj/structure/sign/poster/nyc/xmas_gas
	icon_state = "xmas_gas"
	poster_type = /decl/poster/nyc_xmas_gas

/obj/structure/sign/poster/nyc/future_is_us
	icon_state = "future_is_us"
	poster_type = /decl/poster/nyc_future_is_us

/obj/structure/sign/poster/nyc/together
	icon_state = "together"
	poster_type = /decl/poster/nowallspawn/nyc_together

/obj/structure/sign/poster/nyc/zeng_hu_pharmaceuticals
	icon_state = "zeng_hu_pharmaceuticals"
	poster_type = /decl/poster/nyc_zeng_hu_pharmaceuticals

/obj/structure/sign/poster/nyc/keep_clean
	icon_state = "keep_clean"
	poster_type = /decl/poster/nyc_keep_clean

/obj/structure/sign/poster/nyc/good_mood_sponsor
	icon_state = "good_mood_sponsor"
	poster_type = /decl/poster/nyc_good_mood_sponsor

/obj/structure/sign/poster/nyc/true_hero
	icon_state = "true_hero"
	poster_type = /decl/poster/nowallspawn/nyc_true_hero
