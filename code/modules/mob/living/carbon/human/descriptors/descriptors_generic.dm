/datum/mob_descriptor/height
	name = "height"
	standalone_value_descriptors = list(
		"very short",
		"short",
		"of average height",
		"tall",
		"very tall"
		)
	comparative_value_descriptor_equivalent = "around the same height as you"
	comparative_value_descriptors_smaller = list(
		"slightly shorter than you",
		"shorter than you",
		"much shorter than you",
		"tiny and insignificant next to you"
		)
	comparative_value_descriptors_larger = list(
		"slightly taller than you",
		"taller than you",
		"much taller than you",
		"towering over you"
		)
	var/list/scale_effect = list(
		SPECIES_HUMAN = list(-7, -4, 0, 4, 7),
		SPECIES_DIONA = list(-7, -4, 0, 4, 7),
		SPECIES_IPC = list(-7, -4, 0, 4, 7),
		SPECIES_UNATHI = list(-7, -4, 0, 4, 7),
		SPECIES_YEOSA = list(-7, -4, 0, 4, 7),
		SPECIES_SKRELL = list(-7, -4, 0, 4, 7),
		SPECIES_TRITONIAN = list(-7, -4, 0, 4, 7),
		SPECIES_SPACER = list(-7, -4, 0, 4, 7),
		SPECIES_VATGROWN = list(-7, -4, 0, 4, 7),
		SPECIES_GRAVWORLDER = list(-7, -4, 0, 4, 7),
		SPECIES_MULE = list(-7, -4, 0, 4, 7),
		SPECIES_RESOMI = list(-7, -4, 0, 4, 7),
		SPECIES_TAJARA = list(-7, -4, 0, 4, 7),
		SPECIES_VOX = list(-7, -4, 0, 4, 7),
		SPECIES_ALIEN = list(-7, -4, 0, 4, 7),
		SPECIES_GOLEM = list(-7, -4, 0, 4, 7),
		SPECIES_NABBER = list(-7, -4, 0, 4, 7),
		SPECIES_MANTID_GYNE = list(-7, -4, 0, 4, 7),
		SPECIES_MANTID_ALATE = list(-7, -4, 0, 4, 7),
		SPECIES_MONARCH_WORKER = list(-7, -4, 0, 4, 7),
		SPECIES_MONARCH_QUEEN = list(-7, -4, 0, 4, 7),
		SPECIES_XENO = list(-7, -4, 0, 4, 7),
		SPECIES_EROSAN = list(-7, -4, 0, 4, 7),
		SPECIES_ADHERENT = list(-7, -4, 0, 4, 7),
	)

/datum/mob_descriptor/build
	name = "build"
	comparative_value_descriptor_equivalent = "around the same build as you"
	standalone_value_descriptors = list(
		"rail thin",
		"thin",
		"of average build",
		"well-built",
		"heavily built"
		)
	comparative_value_descriptors_smaller = list(
		"a bit smaller in build than you",
		"smaller in build than you",
		"much smaller in build than you",
		"dwarfed by your bulk"
		)
	comparative_value_descriptors_larger = list(
		"slightly larger than you in build",
		"built larger than you",
		"built much larger than you",
		"dwarfing you"
		)
	var/list/scale_effect = list(
		SPECIES_HUMAN = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_DIONA = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_IPC = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_UNATHI = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_YEOSA = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_SKRELL = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_TRITONIAN = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_SPACER = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_VATGROWN = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_GRAVWORLDER = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_MULE = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_RESOMI = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_TAJARA = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_VOX = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_ALIEN = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_GOLEM = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_NABBER = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_MANTID_GYNE = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_MANTID_ALATE = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_MONARCH_WORKER = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_MONARCH_QUEEN = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_XENO = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_EROSAN = list(-7.5, -4, 0, 4, 7.5),
		SPECIES_ADHERENT = list(-7.5, -4, 0, 4, 7.5),
	)
