/obj/item/reagent_containers/food/drinks/cans/eznutrient
	volume = 60 //just over one and a half cups
	amount_per_transfer_from_this = 5
	matter = list(MATERIAL_PLASTIC = 40)
	name = "\improper EZ NUtrient plastic bottle"
	desc = "Plastic bottle with some smelly liquid."
	icon_state = "eznutrien_bottle"
	center_of_mass = "x=15;y=8"

/obj/item/reagent_containers/food/drinks/cans/eznutrient/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/toxin/fertilizer/eznutrient, 60)

/obj/item/reagent_containers/food/drinks/cans/robustharvest
	volume = 60 //just over one and a half cups
	amount_per_transfer_from_this = 5
	matter = list(MATERIAL_PLASTIC = 40)
	name = "\improper Robust Harvest plastic bottle"
	desc = "Plastic bottle with some smelly liquid."
	icon_state = "robust_harvest_bottle"
	center_of_mass = "x=15;y=8"

/obj/item/reagent_containers/food/drinks/cans/robustharvest/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/toxin/fertilizer/robustharvest, 60)

/obj/machinery/vending/hydronutrients/prison
	name = "\improper NutriMax"
	desc = "A plant nutrients vendor."
	products = list(
					/obj/item/reagent_containers/food/drinks/cans/eznutrient = 6,
					/obj/item/reagent_containers/food/drinks/cans/robustharvest = 3,
					/obj/item/plantspray/pests = 20,
					/obj/item/storage/plants = 5
					)
