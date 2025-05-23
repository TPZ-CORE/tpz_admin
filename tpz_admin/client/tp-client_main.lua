
local PlayerData = { 
    UserRoles = nil,
    UserGroup = nil,
    Loaded    = false
}

-----------------------------------------------------------
--[[ Public Functions ]]--
-----------------------------------------------------------

-- @HasAllowlistedDiscordRole returns if the player is allowlisted / not.
HasPermittedRole = function(userRoles, listedRoles)
    local userRolesLength = GetTableLength(userRoles)
  
    if userRolesLength <= 0 then
        return false
    end
  
    for _, role in pairs (listedRoles) do
  
      for _, userRole in pairs (userRoles) do
        
        if tonumber(userRole) == tonumber(role) then
          return true
        end
  
      end
    end
  
    return false
end

GetActionByName = function (actionName)

    for _, action in pairs (Config.Permissions) do
        if action.ActionType == actionName then
            return action
        end
    end

    return nil
    
end

HasPermission = function (permittedDiscordRoles)

    while not PlayerData.Loaded do
		Wait(500)
	end

	-- Invalid Player User Roles.
	if not PlayerData.UserRoles or PlayerData.UserRoles == nil then
		print(Locales['CODE_200'])
		return false
	end
	
	local hasRequiredRole = HasPermittedRole(PlayerData.UserRoles, permittedDiscordRoles)
	
	if not hasRequiredRole then
		return false
	end

    return true
end


GetPlayerData = function()
    return PlayerData
end

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

-- Requests the player data when the player is loaded.
AddEventHandler("tpz_core:isPlayerReady", function()
    TriggerServerEvent('tpz_admin:requestUserRoles')
end)

if Config.DevMode then

    Citizen.CreateThread(function ()
        TriggerServerEvent('tpz_admin:requestUserRoles')
    end)

end

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

-- Updates the player data when the player is loaded.
RegisterNetEvent("tpz_core:updateUserRoles")
AddEventHandler("tpz_core:updateUserRoles", function(data)
    PlayerData.UserRoles  = data[1]
    PlayerData.UserGroup  = data[2]
    
    PlayerData.Loaded     = true

    TriggerServerEvent("tpz_admin:server:addChatSuggestions") -- requests chat command suggestion (/admin)
end)