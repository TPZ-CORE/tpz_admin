
local TPZ = exports.tpz_core:getCoreAPI()

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterServerEvent('tpz_admin:server:request')
AddEventHandler('tpz_admin:server:request', function()
	local _source = source
	local xPlayer = TPZ.GetPlayer(_source)

	if not xPlayer.loaded() then
		return
	end

	local group     = xPlayer.getGroup()
	local userRoles = xPlayer.getDiscordRoles()

	TriggerClientEvent("tpz_admin:client:receive", _source, { userRoles, group })
end)
