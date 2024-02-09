//datajack by Sad Ninja Sid, modified from multimeter
/obj/item/device/multitool/datajack
	name = "data jack"
	desc = "Кабель для мультизадачного подключения к различным устройствам посредством электронных устройств и продвинутой диагностики."
	icon = 'infinity/icons/obj/items.dmi'
	icon_state = "datajack"
	var/mode = METER_MESURING // Mode

/obj/item/device/multitool/datajack/attack_self(mob/user)
	switch(mode)
		if(METER_MESURING)
			mode = METER_CHECKING
		if(METER_CHECKING)
			mode = METER_MESURING
	to_chat(user, "Режим сигнала сменён на: [mode].")
