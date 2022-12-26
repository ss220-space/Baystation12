/area/ship/farfleet
	name = "\improper ICCGN Farfleet"
	icon_state = "shuttle2"
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

/area/ship/farfleet/crew
	name = "\improper Barracks"
	icon_state = "iccgn-Dormintory"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/fleet
	name = "\improper Fleet Cabins"
	icon_state = "iccgn-fleetdorms"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/captain
	name = "\improper Captain Cabin"
	icon_state = "iccgn-captain"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/hallway/lower
	name = "\improper Hallway - Ordnance Deck"
	icon_state = "iccgn-corridor"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/hallway/upper
	name = "\improper Hallway - Warehouse Deck"
	icon_state = "iccgn-corridor"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/kitchen
	name = "\improper Galley"
	icon_state = "iccgn-canteen"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/freezer
	name = "\improper Freezer"
	icon_state = "iccgn-canteen"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/cryo
	name = "Cryo Storage"
	icon_state = "iccgn-cryo"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/comms
	name = "Communication Relay"
	icon_state = "iccgn-tcoms"
	req_access = list(access_away_iccgn, access_away_iccgn_captain)

/area/ship/farfleet/crew/toilet
	name = "\improper Toilet"
	icon_state = "locker"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/warehouse/starboard
	name = "\improper Missile Warehouse - Starboard"
	icon_state = "iccgn-warehouseN"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/warehouse
	name = "\improper Missile Warehouse - Port"
	icon_state = "iccgn-warehouseS"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/brig
	name = "\improper Ship Brig"
	icon_state = "iccgn-brig"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/crew/brig/emergency_armory
	name = "\improper Emergency Armory"
	icon_state = "iccgn-armory"
	req_access = list(access_away_iccgn, access_away_iccgn_captain)

/area/ship/farfleet/engineering/hallway
	name = "\improper Engineering Hallway"
	icon_state = "green"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/equipment
	name = "\improper Engineering Equipment"
	icon_state = "green"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/atmos_equipment
	name = "\improper Atmospherics Equipment"
	icon_state = "green"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/storage
	name = "\improper Engineering Storage"
	icon_state = "green"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/shield
	name = "\improper Shield Generator"
	icon_state = "green"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/fussion
	name = "\improper Fussion Zone"
	icon_state = "iccgn-engine"
	ambience = list('sound/ambience/ambigen3.ogg','sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg','sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg','sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg','sound/ambience/ambieng1.ogg')
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/fussion/control
	name = "\improper Fussion Control"
	icon_state = "green"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/atmospherics
	name = "\improper Atmospherics"
	icon_state = "iccgn-Atmos"
	ambience = list('sound/ambience/ambigen3.ogg','sound/ambience/ambigen4.ogg','sound/ambience/ambigen5.ogg','sound/ambience/ambigen6.ogg','sound/ambience/ambigen7.ogg','sound/ambience/ambigen8.ogg','sound/ambience/ambigen9.ogg','sound/ambience/ambigen10.ogg','sound/ambience/ambigen11.ogg','sound/ambience/ambiatm1.ogg')
	req_access = list(access_away_iccgn)

/area/ship/farfleet/engineering/reactor
	name = "\improper Nuclear Reactor"
	icon_state = "iccgn-NReactor"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/barracks
	name = "\improper Droptroops Section"
	icon_state = "locker"
	req_access = list(access_away_iccgn, access_away_iccgn_droptroops)

/area/ship/farfleet/barracks/armory
	name = "\improper Droptroops Armory"
	icon_state = "iccgn-armory-droptroops"
	req_access = list(access_away_iccgn, access_away_iccgn_droptroops, access_away_iccgn_sergeant)




/area/ship/farfleet/medbay
	name = "\improper Medical Bay"
	icon_state = "iccgn-medbay"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/medbay/surgery
	name = "\improper Surgery"
	icon_state = "iccgn-medbay"
	req_access = list(access_away_iccgn)





/area/ship/farfleet/maintenance/lower
	name = "\improper Maintenance Lower Fore"
	icon_state = "amaint"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/lower/starboard
	name = "\improper Maintenance Lower Starboard"
	icon_state = "amaint"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/lower/port
	name = "\improper Maintenance Lower Port"
	icon_state = "amaint"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/upper
	name = "\improper Maintenance Upper Fore"
	icon_state = "amaint"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/upper/aft
	name = "\improper Maintenance Upper Aft"
	icon_state = "amaint"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/upper/port
	name = "\improper Maintenance Upper Port"
	icon_state = "amaint"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/upper/starboard
	name = "\improper Maintenance Upper Starboard"
	icon_state = "amaint"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/upper/anomaly
	name = "\improper Anomaly Materials "
	icon_state = "iccgn-anomaly"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/upper/canisters
	name = "\improper Auxiliary Storage"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/upper/waste
	name = "\improper Waste Disposal"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/engine/port
	name = "\improper Port Thruster"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/maintenance/engine/starboard
	name = "\improper Starboard Thruster"
	req_access = list(access_away_iccgn)



/area/ship/farfleet/command/bridge
	name = "\improper Bridge"
	icon_state = "iccgn-Bridge"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/command/eva
	name = "\improper Fleet EVA"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/command/equipment
	name = "\improper Fleet Equipment"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/command/bsd
	name = "\improper Bluespace Drive"
	icon_state = "iccgn-bsd"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/command/snz_exterior_dock
	name = "\improper Roof Dock"
	icon_state = "purple"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/command/launcher/north
	name = "\improper Starboard Missile Launcher"
	icon_state = "iccgn-Ordnance-North"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/command/launcher
	name = "\improper Port Missile Launcher"
	icon_state = "iccgn-Ordnance-South"
	req_access = list(access_away_iccgn)

/area/ship/farfleet/command/lasers
	name = "\improper MRSP platform"
	icon_state = "yellow"
	req_access = list(access_away_iccgn)




/area/ship/farfleet/dock
	name = "\improper Docking Bay"
	icon_state = "entry_1"
	req_access = list(access_away_iccgn)
