
local TPZ = exports.tpz_core:getCoreAPI()

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

GetPlayerWarningsBySource = function(source)
	local _source     = source
	local xPlayer     = TPZ.GetPlayer(_source)
	local identifier  = xPlayer.getIdentifier()

	local wait, warnings = true, 0

	exports["ghmattimysql"]:execute("SELECT * FROM `banned_users` WHERE `identifier` = @identifier", { ["@identifier"] = identifier }, function(result)

		if result[1] then
			warnings = result[1].warnings
		end

		wait = false
		
	end)

	while wait do
		Wait(100)
	end

	return warnings

end

BanPlayerBySource = function(targetSource, returnedValue)
	local _source = source
	local tPlayer = TPZ.GetPlayer(targetSource)

	local Parameters = {
		['identifier']     = tPlayer.getIdentifier(),
		['banned']         = 1,
		['bannedReason']   = returnedValue,
	}

	exports.ghmattimysql:execute("UPDATE `banned_users` SET `banned` = @banned, `bannedReason` = @bannedReason WHERE `identifier` = @identifier", Parameters )
	DropPlayer(targetSource, string.format(Locales['BAN_REASON_DESCRIPTION'], returnedValue))
end

BanPlayerBySteamIdentifier = function(steamIdentifier, returnedValue)

	local Parameters = {
		['identifier']     = steamIdentifier,
		['banned']         = 1,
		['bannedReason']   = returnedValue,
	}

	exports.ghmattimysql:execute("UPDATE `banned_users` SET `banned` = @banned, `bannedReason` = @bannedReason WHERE `identifier` = @identifier", Parameters )
end

ResetBanBySteamIdentifier = function(steamIdentifier)
	local _source = source

	local Parameters = {
		['identifier']     = steamIdentifier,
		['banned']         = 0,
		['bannedReason']   = 'N/A',
		['warnings']       = 0,
	}

	exports.ghmattimysql:execute("UPDATE `banned_users` SET `banned` = @banned, `bannedReason` = @bannedReason, `warnings` = @warnings WHERE `identifier` = @identifier", Parameters )
end

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

AddEventHandler("playerConnecting", function (name, kick, deferrals)
    local player          = source
    local steamIdentifier

    local identifiers     = GetPlayerIdentifiers(player)

    deferrals.defer()

    -- mandatory wait!
    Wait(0)
    for _, v in pairs(identifiers) do
		if string.find(v, "steam") then 
			steamIdentifier = v 
			break 
		end 
	end
    -- mandatory wait!
    Wait(0)

    if steamIdentifier then

		exports["ghmattimysql"]:execute("SELECT * FROM `banned_users` WHERE `identifier` = @identifier", { ["@identifier"] = steamIdentifier }, function(result)
	
			if (not result) or (result and not result[1]) then
				local Parameters = { ['identifier'] = steamIdentifier, ['steamname']  = GetPlayerName(player) }
				exports.ghmattimysql:execute("INSERT INTO `banned_users` (`identifier`, `steamname`) VALUES (@identifier, @steamname)", Parameters)
			end

			if result[1] and result[1].banned == 1 then
				deferrals.done(string.format(Locales['BAN_REASON_DESCRIPTION'], result[1].bannedReason))
			else
				deferrals.done()
			end

		end)

    end

end)