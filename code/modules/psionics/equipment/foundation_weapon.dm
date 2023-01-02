/obj/item/gun/projectile/revolver/foundation
	name = "\improper Foundation revolver"
	icon = 'icons/obj/guns/foundation.dmi'
	icon_state = "foundation"
	desc = "The CF 'Troubleshooter', a compact plastic-composite weapon designed for concealed carry by Cuchulain Foundation field agents. Smells faintly of copper."
	ammo_type = /obj/item/ammo_casing/pistol/magnum/nullglass

/obj/item/gun/projectile/revolver/foundation/disrupts_psionics()
	return FALSE

/obj/item/storage/briefcase/foundation
	name = "\improper Foundation briefcase"
	desc = "A handsome black leather briefcase embossed with a stylized radio telescope."
	icon_state = "fbriefcase"
	item_state = "fbriefcase"
	force = 8.0
	throw_speed = 1
	throw_range = 4
	w_class = ITEM_SIZE_HUGE
	max_w_class = ITEM_SIZE_NORMAL
	max_storage_space = DEFAULT_BACKPACK_STORAGE
	use_sound = 'sound/effects/storage/briefcase.ogg'

/obj/item/storage/briefcase/foundation/disrupts_psionics()
	return FALSE

/obj/item/storage/briefcase/foundation/New()
    ..()
    new /obj/item/gun/projectile/revolver/foundation(src)
    new /obj/item/ammo_magazine/speedloader/magnum/nullglass(src)
    new /obj/item/ammo_magazine/speedloader/magnum/nullglass(src)
    new /obj/item/storage/firstaid/individual/military(src)
    new /obj/item/implanter/psi(src)
    new /obj/item/implanter/psi(src)
    new /obj/item/implantcase/explosive(src)
    new /obj/item/implantcase/explosive(src)
    new /obj/item/implantcase/tracking(src)
    new /obj/item/implantcase/tracking(src)
    new /obj/item/implanter(src)
    new /obj/item/implantpad(src)
    new /obj/item/device/scanner/reagent/adv(src)
