/obj/structure/closet/secure_closet/bar
	name = "booze closet"
	req_access = list(access_bar)
	icon_state = "secure"

/obj/structure/closet/secure_closet/bar/WillContain()
	return list(/obj/item/reagent_containers/food/drinks/bottle/small/beer = 10)
