#include "spy_station_areas.dm"

/obj/effect/overmap/visitable/sector/spy_station
	name = "Small space station"
	scanner_name = "Small space station"
	scanner_desc = @{"<i>Registration</i>: SCGDF military facility
<i>Class</i>: Installation
<i>Transponder</i>: (MIL), SCG
<b>Notice</b>: Sensors detect a small station. No further scanning is possible. Interference: camouflage radio network"}
	icon_state = "object"
	known = 0

	initial_generic_waypoints = list(
		"nav_spy_station_1",
		"nav_spy_station_2",
		"nav_spy_station_3",
		"nav_spy_station_antag"
	)

/datum/map_template/ruin/away_site/spy_station
	name = "Spy Station"
	id = "awaysite_spy_station"
	description = "Delta Station"
	prefix = "maps/away_inf/"
	suffixes = list("spy_station/spy_station.dmm")
	spawn_cost = 0.5
	template_flags = TEMPLATE_FLAG_SPAWN_GUARANTEED
	area_usage_test_exempted_root_areas = list(/area/spy_station)

/obj/effect/shuttle_landmark/spy_station/nav1
	name = "Spy Station #1"
	landmark_tag = "nav_spy_station_1"

/obj/effect/shuttle_landmark/spy_station/nav2
	name = "Spy Station #2"
	landmark_tag = "nav_spy_station_2"

/obj/effect/shuttle_landmark/spy_station/nav3
	name = "Spy Station #3"
	landmark_tag = "nav_spy_station_3"

/obj/effect/shuttle_landmark/spy_station/navantag
	name = "Spy Station #4"
	landmark_tag = "nav_spy_station_antag"

// Obj

/obj/item/scgstation_disk
	name = "disk"
	desc = "A dusty disk. Its label says: \"Deliver to SCG Fleet Command!\". Its content is encrypted with quantum crypthography methods."
	icon = 'icons/obj/items.dmi'
	icon_state = "nucleardisk"
	item_state = "card-id"
	w_class = ITEM_SIZE_TINY


/obj/item/scgstation_disk
	name = "disk"
	desc = "A dusty disk. Its label says: \"List of classified military radio frequencies.\". Its content is encrypted with quantum crypthography methods."
	icon = 'icons/obj/items.dmi'
	icon_state = "nucleardisk"
	item_state = "card-id"
	w_class = ITEM_SIZE_TINY

/obj/item/paper/signal1
	name = "Signal Detected 1"
	info = {"
			<center><b>Станция РФР "Эверест" №23</b></center>
			<center><b><font color='red'><small>CONFIDENTIAL USE ONLY</small></font></b></center>
			<i> Контакт.... Обнаружен сигнал.... запись на носитель невозмо@$%...... Замечена сигнатура среднего размера, отклик издает внеземное происхождение металов.... Системы передают повтрорный пелинг..... 123*.... О%#$%нар....  неко?№:%--о "Вос*;?":6Х*3"!ния№"%%:4000001000.....  </i>
 <i> Замечен огромный всплеск Электро Магнитной Энергии........ Резервное Отключение сис----0010001010......</i>
			"}


/obj/item/paper/signal2
	name = "Signal 234"
	info = {"
			<center><solcrest> <fleetlogo></center>
 <large><u> Отчёт по контакту "Пеленг 234"</u> </large>
 <hr>
<center> Данные которые удалось получить со сканирования: </center>
Большого объёма судно, с большим отсеком скорее всего заточенным под перевозки различных грузов.
 Жизненные формы <b>не обнаружены</b>.
 Был перехвачен сигнал <b>транспондера</b>, однако его исходный образец пострадал от искажения. Отправили повреждённый файл Айти мастеру.
 Тепловой след от двигателей отсутствует, однако судно находится в движении.<hr> Отправить Дронов на проверку?
<i> Это нас не интересует, транспондер был расшифрован как судно Вольных Торговцев. </i>
			"}


/obj/item/paper/signal3
	name = "Signal 47"
	info = {"
			<center><solcrest> <fleetlogo></center>
 <large><u> Отчёт по контакту "Пеленг 47"</u> </large>
 <hr>
<center> Данные которые удалось получить со сканирования: </center>
Замечен сектор помех, спешу сообщить, что это включенное устройство подавления сигналов, мы пытаемся настроить сигнал.<hr>
<i> Сообщите в связующий узел. </i>
			"}