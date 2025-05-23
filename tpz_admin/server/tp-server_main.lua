
local TPZ = exports.tpz_core:getCoreAPI()

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

GetPlayerList = function ()
	return PlayersList
end

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterServerEvent('tpz_admin:requestUserRoles')
AddEventHandler('tpz_admin:requestUserRoles', function()
	local _source = source
	local xPlayer = TPZ.GetPlayer(_source)

	if not xPlayer.loaded() then
		return
	end

	local group     = xPlayer.getGroup()
	local userRoles = xPlayer.getDiscordRoles()

	TriggerClientEvent("tpz_core:updateUserRoles", _source, { userRoles, group })
end)
