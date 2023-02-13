
/* CARDS
 * ========
 */

/obj/item/card/id/farfleet/droptroops
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn, access_away_iccgn_droptroops)

/obj/item/card/id/farfleet/droptroops/sergeant
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn, access_away_iccgn_droptroops, access_away_iccgn_sergeant)

/obj/item/card/id/farfleet/fleet
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn)

/obj/item/card/id/farfleet/fleet/captain
	desc = "An identification card issued to ICCG crewmembers aboard the Farfleet Recon Craft."
	icon_state = "base"
	access = list(access_away_iccgn, access_away_iccgn_captain)

/* RADIOHEADS
 * ========
 */

/obj/item/device/radio/headset/rescue
	name = "rescue team radio headset"
	desc = "The headset of the rescue team member."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/rescue

/obj/item/device/radio/headset/rescue/leader
	name = "rescue team leader radio headset"
	desc = "The headset of the rescue team member."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/rescue/leader

/obj/item/device/encryptionkey/rescue //for events
	name = "\improper rescue radio encryption key"
	icon_state = "cargo_cypherkey"
	channels = list("Response Team" = 1)

/obj/item/device/encryptionkey/rescue/leader
	name = "\improper rescue leader radio encryption key"
	channels = list("Response Team" = 1, "Command" = 1, )

/* CLOTHING
 * ========
 */


/obj/item/clothing/under/iccgn/service_command
	starting_accessories = list(
		/obj/item/clothing/accessory/iccgn_patch/ordnance
	)

/obj/item/clothing/under/iccgn/utility
	starting_accessories = list(
		/obj/item/clothing/accessory/iccgn_patch/ordnance
	)

/obj/item/clothing/under/iccgn/pt
	starting_accessories = list(
		/obj/item/clothing/accessory/iccgn_patch/pioneer
	)

/obj/item/storage/belt/holster/security/tactical/farfleet/New()
	..()
	new /obj/item/gun/projectile/pistol/military/alt(src)
	new /obj/item/ammo_magazine/pistol/double(src)
	new /obj/item/ammo_magazine/pistol/double(src)

/* MISC
 * ========
 */

/obj/item/folder/envelope/farfleet
	desc = "A thick envelope. The ICCG crest is stamped in the corner, along with 'Tolko dlya sluzhebnogo polzovaina'."

/obj/item/folder/envelope/farfleet/Initialize()
	. = ..()
	var/memo = {"
	<tt><center><b><font color='red'>ДЛЯ СЛУЖЕБНОГО ПОЛЬЗОВАНИЯ<br>КОДОВОЕ СЛОВО: МАГНУС</font></b>
	<h3>КОМАНДОВАНИЕ ФЛОТА ДАЛЬНЕГО ПЛАВАНИЯ</h3>
	<img src = terralogo.png>
	</center>
	<b>ОТ:</b>Адмирал Igor Romani<br>
	<b>КОМУ:</b> Капитану судна (код 39-289-1)<br>
	<b>ТЕМА:</b> Общий Приказ<br>
	<hr>
	Капитан,<br>
	В текущий вылет ваше судно должно посетить данные звёздные системы, находящиеся в нейтральном космосе.
	<li>[generate_system_name()]</li>
	<li>[GLOB.using_map.system_name]</li>
	<li>[generate_system_name()]</li>
	<li>[generate_system_name()]</li>
	<br>
	Вашей приоритетной целью является сбор информации об истинных причинах уничтожения ГЭК "Магнус", а также о возросшей активности Пятого флота ЦПСС в этом регионе.<br>
	Напоминаю, что официальная версия, которую ЦПСС называет как в ограниченных открытых источника, так и в закрытых, является уничтожение ГЭК "Магнус" неким "Восхождением".<br>
	На данный момент командование не располагает полным подтверждением или опровержением данной информации. Помимо этого нам также известно, что в данный регион отправляется корвет класса "Мако" с обозначением ИКН "Сьерра", принадлежащий корпорации НаноТразен.<br>
	Вы можете взаимодействовать с корпоративными судами на ваше усмотрение. Однако целенаправленное нанесение ущерба корпорациям, аффилированным с правительством ЦПСС сейчас не в наших интересах. Те же указания остаются и в отношении судов Торгового Союза.<br>
	Помимо этого, наши радары засекли исходящие из данного региона сигналы бедствия, которые опознаются как кодировка Флота Сил Обороны Магнитки. Вам также предписывается провести разведку в местах, откуда данный сигнал мог происходить.<br>
	Любая информация, которую вы сможете собрать в вашем полёте будет представлять крайне высокую ценность для Конфедерации. Переоценка уровня угрозы этого "Восхождения" может повлиять на всю расстановку сил флотов Сестриса и Гильгамеша.<br>
	Конфедерация рассчитывает на вас.<br>

	<font face="Verdana" color=black><font face="Times New Roman"><i>Igor Romani</i></font></font></tt><br>
	<i>This paper has been stamped with the stamp of ICCGN Farfleet operations command.</i>
	"}
	new/obj/item/paper/important(src, memo, "Farfleet Orders")

/obj/item/paper/turrets
	name = "paper- 'About Turrets.'"
	info = "<h1>По поводу турелей.</h1><p>Вася, я не знаю, как ты настраивал эти чёртовы турели, но у них слетает проверка доступа каждый раз как мы используем БСД. Да, я знаю, что они не подключены к БСД и вообще на шаттле. Наше счастье, что они просто начинают оглушающим лучом бить,а не летальным режимом.</p><h1>ПЕРЕЗАГРУЗИ КОНТРОЛЛЕР ТУРЕЛЕЙ, КАК ПОЙДЁШЬ В АНГАР.</h1>"
