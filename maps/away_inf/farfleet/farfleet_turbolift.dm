/obj/turbolift_map_holder/farfleet
	name = "Farfleet turbolift map placeholder"
	icon = 'icons/obj/turbolift_preview_2x2.dmi'
	depth = 2
	lift_size_x = 3
	lift_size_y = 3

	areas_to_use = list(
		/area/turbolift/farfleet_first,
		/area/turbolift/farfleet_second
		)

/area/turbolift/startsent
	name = "\improper Turbolift Start"

/area/turbolift/firstdecksent
	name = "\improper first deck"
	base_turf = /turf/simulated/floor

/area/turbolift/seconddecksenst
	name = "\improper second deck"
	base_turf = /turf/simulated/floor

/area/turbolift/farfleet_second
	name = "lift (upper deck)"
	lift_floor_label = "Deck 1"
	lift_floor_name = "Upper Deck"
	lift_announce_str = "Arriving at Upper Deck: Секция гаупвахты. Секция экипажа. Склад боеприпасов. Стыковочный док шаттла. Оружейная десанта. Хранилище аномальных материалов."
	base_turf = /turf/simulated/floor

/area/turbolift/farfleet_first
	name = "lift (lower deck)"
	lift_floor_label = "Deck 2"
	lift_floor_name = "Launch Deck"
	lift_announce_str = "Arriving at Launch Deck: Мостик. Казарма. Малая оружейная. Инженерный отсек. Атмосферный отсек. Столовая. Ракетные установки правого и левого борта."
	base_turf = /turf/simulated/floor
