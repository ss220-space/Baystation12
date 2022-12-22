/obj/item/reagent_containers/food/drinks/cans/kvass
	name = "\improper Kvass"
	desc = "A true Slavic soda, \
	a classic slavic beverage which many Terrans still enjoy to this day. Fun fact, it is actually considered a weak beer by non-russians."
	icon_state = "kvass"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_containers/food/drinks/cans/kvass/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/ethanol/kvass, 30)

/obj/item/reagent_containers/food/drinks/cans/kompot
	name = "\improper Kompot"
	desc ="A taste of russia in the summertime - canned for you consumption, \
	a sweet and fruity beverage that was traditionally used to preserve frutis in harsh Russian winters that is now available for widespread comsumption."
	icon_state = "kompot"
	center_of_mass = "x=16;y=10"

/obj/item/reagent_containers/food/drinks/cans/kompot/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/drink/kompot, 30)


//REAGENTS//

/datum/reagent/drink/kompot
	name = "Kompot"
	description = "A traditional Eastern European beverage once used to preserve fruit in the 1980s."
	taste_description = "refreshuingly sweet and fruity"
	color = "#ed9415"

	glass_name = "Kompot"
	glass_desc = "Traditional Terran drink. Grandma would be proud."

/datum/reagent/ethanol/kvass
	name = "Kvass"
	description = "A traditional fermented Slavic and Baltic beverage commonly made from rye bread"
	taste_description = "a warm summer day at babushka's cabin!"
	color = "#b78315"
	strength = 30

	glass_name = "kvass"
	glass_desc = "A traditional fermented Slavic and Baltic beverage commonly made from rye bread."
