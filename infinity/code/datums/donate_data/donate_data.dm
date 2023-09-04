/client
	var/datum/donator_data/DonateData
/client/New()
	. = ..()
	SyncWithDonatorData()
	update_ooc_color()

/client/proc/SyncWithDonatorData()
	DonateData = new()
	DonateData.ckey = ckey
	donator_check()

/client/proc/donator_check()
	set waitfor = FALSE // This needs to run async because any sleep() inside /client/New() breaks stuff badly
	if(IsGuestKey(key))
		return

	if(!SSdbcore.IsConnected())
		return

	if(check_rights(R_ADMIN, 0, mob)) // Yes, the mob is required, regardless of other examples in this file, it won't work otherwise
		DonateData.level = 4
		DonateData.rank = "Tier IV"
		DonateData.points = 100
		return

	//Donator stuff.
	var/datum/db_query/query_donor_select = SSdbcore.NewQuery({"
		SELECT CAST(SUM(amount) as UNSIGNED INTEGER) FROM [sqlfdbkdbutil].budget
		WHERE ckey=:ckey
			AND is_valid=true
			AND date_start <= NOW()
			AND (NOW() < date_end OR date_end IS NULL)
		GROUP BY ckey
	"}, list("ckey" = ckey))

	if(!query_donor_select.warn_execute())
		qdel(query_donor_select)
		return

	if(query_donor_select.NextRow())
		var/total = query_donor_select.item[1]
		if(total >= 100)
			DonateData.level = 1
			DonateData.rank = "Tier I"
		if(total >= 300)
			DonateData.level = 2
			DonateData.rank = "Tier II"
		if(total >= 500)
			DonateData.level = 3
			DonateData.rank = "Tier III"
		if(total >= 1000)
			DonateData.level = 4
			DonateData.rank = "Tier IV"
		DonateData.points = total / 10
		var/list/rank_color = SSexdata.GetDataByKey(DATASTORE_RANKS_OOC_COLORS, DonateData.rank)
		if(length(rank_color))
			DonateData.ooc_color = rank_color
			update_ooc_color()
	qdel(query_donor_select)

/datum/donator_data
	var/ckey
	var/rank
	var/level
	var/ooc_color
	var/points = 0
	var/list/donate_loadout = list()

/datum/donator_data/proc/GetAvailablePoints()
	. = points
	for(var/datum/gear/g in donate_loadout)
		. -= g.price

/datum/donator_data/proc/CheckGear(datum/gear/gear2check)
	if(gear2check)
		if((GetAvailablePoints() >= gear2check.price) && (level >= gear2check.required_donate_level))
			return TRUE
