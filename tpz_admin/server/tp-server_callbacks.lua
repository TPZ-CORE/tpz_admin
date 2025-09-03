
local TPZ    = exports.tpz_core:getCoreAPI()
local TPZInv = exports.tpz_inventory:getInventoryAPI()

-----------------------------------------------------------
--[[ Callbacks  ]]--
-----------------------------------------------------------


exports.tpz_core:getCoreAPI().addNewCallBack("tpz_admin:getOnlinePlayers", function(source, cb, data)

	local playersList   = TPZ.GetPlayers()
	local newPlayerList = {}

	local finished      = false

	for _, player in pairs (playersList.players) do
		
		local target  = tonumber(player.source)

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

			table.insert(newPlayerList, { 
				source    = target, 
				username  = username, 
				steamname = steamname,

				coords    = { x = coords.x, y = coords.y, z = coords.z },

				accounts = { 
					money       = xPlayer.getAccount(0), 
					gold        = xPlayer.getAccount(1),
					black_money = xPlayer.getAccount(2),
				},

				warnings = totalWarnings,
			})

		else

			table.insert(newPlayerList, { source = target, username = username, steamname = steamname, coords = { x = coords.x, y = coords.y, z = coords.z } })
		end

		Wait(0.1)

		if next(playersList.players, _) == nil then
			finished = true
		end

	end

	while not finished do
		Wait(50)
	end

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
	local _tsource = tonumber(data[1])

	local tPlayer = TPZ.GetPlayer(_tsource)

	if tPlayer == nil or not tPlayer.loaded() then
		return cb({})
	end

	return cb(TPZInv.getInventoryContents(_tsource))

end)
