
local TPZ    = exports.tpz_core:getCoreAPI()
local TPZInv = exports.tpz_inventory:getInventoryAPI()

local PlayersList = {}

-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

GetPlayerList = function ()
	return PlayersList
end

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
        return
    end

	PlayersList = nil

end)

-- When player quits the game, we unload - reset online player data.
AddEventHandler('playerDropped', function (reason)
	local _source = source
	PlayersList[_source] = nil
end)

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

	local userRoles = xPlayer.getDiscordRoles()

	TriggerClientEvent("tpz_core:updateUserRoles", _source, { userRoles })

	-- When player is loaded, we load the player to the online players list with data.
	PlayersList[_source]          = {}
	
	PlayersList[_source].source   = _source
	PlayersList[_source].isFrozen = false
end)
