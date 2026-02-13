
local TPZ    = exports.tpz_core:getCoreAPI()
local TPZInv = exports.tpz_inventory:getInventoryAPI()

-----------------------------------------------------------
--[[ Local Functions  ]]--
-----------------------------------------------------------

local function reverseTable(t)
    local reversed = {}
    for i = #t, 1, -1 do
        reversed[#reversed + 1] = t[i]
    end
    return reversed
end

-----------------------------------------------------------
--[[ Callbacks  ]]--
-----------------------------------------------------------

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getOnlinePlayers", function(source, cb, data)

	local _source       = source
	
	local playersList   = TPZ.GetPlayers()
	local newPlayerList = {}

	local finished      = false

	if data.searchInput ~= nil then
					
		if data.searchInput == "" or data.searchInput == " " or #data.searchInput == 0 then 
			data.searchInput = nil 
		end

	end

	for _, player in pairs (playersList.players) do
		
		local target  = tonumber(player.source)

		if target ~= _source or (target == _source and data.requestSelf == true) then

			local xPlayer   = TPZ.GetPlayer(target)
			local username  = xPlayer.getFirstName() .. ' ' .. xPlayer.getLastName()
			local steamname = GetPlayerName(target)
	
			local PlayerList    = GetPlayerList()
			local totalWarnings = 0
	
			if PlayerList[target] then
				totalWarnings = PlayerList[target].warnings
			end
	
			local coords = GetEntityCoords(GetPlayerPed(target))
	
			if data.requestAll then
	
				if (data.searchInput == nil) or string.find(string.lower(steamname), string.lower(data.searchInput), 1, true)
				or string.find(string.lower(username),  string.lower(data.searchInput), 1, true) then

					table.insert(newPlayerList, { 
						source    = target, 
						username  = username, 
						steamname = steamname,
		
						coords    = { x = coords.x, y = coords.y, z = coords.z },
	
						job       = xPlayer.getJob(),
		
						accounts = { 
							money       = xPlayer.getAccount(0), 
							gold        = xPlayer.getAccount(1),
							black_money = xPlayer.getAccount(2),
						},
		
						warnings = totalWarnings,
					})

				end
	
			else
	
				table.insert(newPlayerList, { source = target, username = username, steamname = steamname, coords = { x = coords.x, y = coords.y, z = coords.z } })
			end

			Wait(0.1)
		end

		if next(playersList.players, _) == nil then
			finished = true
		end

	end

	while not finished do
		Wait(50)
	end

	
	table.sort(newPlayerList, function(a, b)
		return tonumber(a.source) < tonumber(b.source)
	end)

	return cb(newPlayerList)
end)

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getBannedPlayers", function(source, cb)

	exports["ghmattimysql"]:execute("SELECT * FROM `banned_users` WHERE `banned` = @banned", { ["@banned"] = 1 }, function(result)
	
		return cb(result)
	end)

end)

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getHistoryRecords", function(source, cb)

	exports["ghmattimysql"]:execute("SELECT * FROM `actions_history_records` ORDER BY `id` DESC", { }, function(result)

		return cb(result)
	end)

end)

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getPlayerInventoryContents", function(source, cb, data)
	local _tsource = tonumber(data.source)

	local tPlayer = TPZ.GetPlayer(_tsource)

	if tPlayer == nil or not tPlayer.loaded() then
		return cb({})
	end

	return cb(TPZInv.getInventoryContents(_tsource))

end)

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:hasPermissionByName", function(source, cb, data)
	local _source = source
	local xPlayer = TPZ.GetPlayer(_source)

	local hasPermission = xPlayer.hasPermissionsByAce("tpzcore.admin." .. data.permission) or xPlayer.hasPermissionsByAce("tpzcore.admin.all")

	if not hasPermission then

		if Config.NUIPermissions[string.upper(data.permission)] then
			data.permission = string.upper(data.permission)
			hasPermission = xPlayer.hasAdministratorPermissions(Config.NUIPermissions[data.permission].PermittedGroups, Config.NUIPermissions[data.permission].PermittedDiscordRoles)

		else

			for _, permission in pairs (Config.Permissions) do 

				if permission.ActionType == string.upper(data.permission) then

					hasPermission = xPlayer.hasAdministratorPermissions(permission.PermittedGroups, permission.PermittedDiscordRoles)
					break
				end

			end

		end

	end
	
	return cb(hasPermission)
end)

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getHistoryActions", function(source, cb, data)

	local wait = true
	local res  = {}
	
	if data.searchInput ~= nil then
					
		if data.searchInput == "" or data.searchInput == " " or #data.searchInput == 0 then 
			data.searchInput = nil 
		end

	end

    exports.ghmattimysql:execute('SELECT * FROM admin_history ORDER BY timestamp DESC', {}, function(result)
        
		for _, cb in pairs (result) do 

			if (data.searchInput == nil) or string.find(string.lower(cb.steamname), string.lower(data.searchInput), 1, true)
			or string.find(string.lower(cb.identifier),  string.lower(data.searchInput), 1, true) then
				table.insert(res, cb)
			end

		end

		wait = false
    end)

	while wait do
		Wait(10)
	end

	return cb(reverseTable(res))

end)

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getBannedUsers", function(source, cb, data)

	local wait = true
	local res  = {}
	
	if data.searchInput ~= nil then
					
		if data.searchInput == "" or data.searchInput == " " or #data.searchInput == 0 then 
			data.searchInput = nil 
		end

	end

    exports.ghmattimysql:execute('SELECT * FROM users WHERE `banned_until` != 0', {}, function(result)
        
		for _, cb in pairs (result) do 

			if (data.searchInput == nil) or string.find(string.lower(cb.steamname), string.lower(data.searchInput), 1, true)
			or string.find(string.lower(cb.identifier),  string.lower(data.searchInput), 1, true) then

				cb.remaining_time = (cb.banned_until ~= -1) and cb.banned_until - os.time() or cb.banned_until
				table.insert(res, cb)
			end

		end

		wait = false
    end)

	while wait do
		Wait(10)
	end

	return cb(res)

end)

exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getTickets", function(source, cb, data)

	local wait = true
	local res  = {}
	
	if data.searchInput ~= nil then
					
		if data.searchInput == "" or data.searchInput == " " or #data.searchInput == 0 then 
			data.searchInput = nil 
		end

	end

    exports.ghmattimysql:execute('SELECT * FROM admin_tickets ORDER BY id DESC', {}, function(result)
        
		for _, cb in pairs (result) do 

			if (data.searchInput == nil) or string.find(string.lower(cb.steamname), string.lower(data.searchInput), 1, true)
			or string.find(string.lower(cb.fullname),  string.lower(data.searchInput), 1, true) then

				table.insert(res, cb)
			end

		end

		wait = false
    end)

	while wait do
		Wait(10)
	end

	return cb(res)

end)