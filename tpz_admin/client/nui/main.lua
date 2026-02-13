local TPZ = exports.tpz_core:getCoreAPI()
local CURRENT_WINDOW = nil
local ACTION_PERMISSIONS_LIST = nil

-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

local function CloseNUI()
    if GetPlayerData().HasNUIActive then SendNUIMessage({action = 'close'}) end
end

local function SendNUINotification(message, messageType, duration)

    SendNUIMessage({ 
        action = 'sendNotification',
        notification_data = { 
            message = message, 
            type = messageType, 
            color = Config.NotificationColors[messageType], 
            duration = duration 
        },
    })

end

-----------------------------------------------------------
--[[ Public Functions ]]--
-----------------------------------------------------------

function HasNUIPermissionByName(str)
    local cb = exports.tpz_core:ClientRpcCall().Callback.TriggerAwait("tpz_admin:hasPermissionByName", { permission = str } )
    return cb
end

function GetActionPermissionsList()
    return ACTION_PERMISSIONS_LIST
end


function ToggleUI (display, window)
    local PlayerData = GetPlayerData()

    PlayerData.HasNUIActive = display

    SetNuiFocus(display, display)

    SendNUIMessage({ type = "enable", enable = display, window = window })
end

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

-- Opens the admin menu.
RegisterNetEvent("tpz_admin:client:open")
AddEventHandler("tpz_admin:client:open", function()

    if GetPlayerData().HasNUIActive or IsNuiFocused() then 
        return
    end

    local time = 0

    while not GetPlayerData().Loaded do 
        
        Wait(1000)

        time = time + 1

        if time == 10 then 
            break 
        end

    end

    if not GetPlayerData().Loaded then 
        return 
    end

    SendNUIMessage({ 
        action  = 'SET_INFORMATION', 
        locales = Locales, 
    })
    
    CURRENT_WINDOW = 'main'

    Wait(250)
    ToggleUI(true, 'main')

    -- Ace Permissions or Discord Permissions and Group Roles, are loaded only once.
    -- The player must relog if something changes.

    -- With this way, we prevent loading all permissions of the actions every time a player selects target player. We save performance and delays.
    if ACTION_PERMISSIONS_LIST == nil then

        ACTION_PERMISSIONS_LIST = {}

        for _, permission in pairs (Config.Permissions) do 

            local hasPermission = HasNUIPermissionByName(string.lower(permission.ActionType))

            permission.ActionType = string.upper(permission.ActionType)

            if hasPermission and permission.ActionType ~= 'UNBAN' and permission.ActionType ~= 'PLAYER_BLIPS' and permission.ActionType ~= 'ANNOUNCEMENT' and permission.ActionType ~= 'GOD_MODE' and permission.ActionType ~= 'TELEPORT_COORDS' and permission.ActionType ~= 'HEAL_ALL' then
            
                table.insert(ACTION_PERMISSIONS_LIST, permission)
            end
    
        end
        
    end


end)

-- Sends NUI Notifications.
RegisterNetEvent("tpz_admin:client:sendNUINotification")
AddEventHandler("tpz_admin:client:sendNUINotification", function(message, messageType, duration)
    SendNUINotification(message, messageType, duration)
end)

-- Force Close.
RegisterNetEvent("tpz_admin:client:closeNUI")
AddEventHandler("tpz_admin:client:closeNUI", function()
    CloseNUI()
end)

-----------------------------------------------------------
--[[ NUI Callbacks ]]--
-----------------------------------------------------------

RegisterNUICallback(GetCurrentResourceName(), function() -- dev
  TriggerServerEvent(GetCurrentResourceName())
end)


RegisterNUICallback('close', function()
	ToggleUI(false)
end)

RegisterNUICallback('requestNotification', function(data)
    SendNUINotification(Locales[data.message].text, data.messageType, Locales[data.message].duration)
end)
