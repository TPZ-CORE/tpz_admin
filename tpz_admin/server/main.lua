
local TPZ     = exports.tpz_core:getCoreAPI()
local Players = {}

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

GetPlayerList = function()
    return Players
end

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

-- Removing old history actions on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end

    -- Get current time
    local currentTime = os.time()
    local threeDaysSeconds = Config.DeleteHistoryActionAfter * 24 * 60 * 60 -- x days in seconds
    
    -- Fetch actions older than x days
    exports.ghmattimysql:execute(
        "SELECT * FROM admin_history WHERE timestamp <= @timeLimit",
        {
            ["@timeLimit"] = currentTime - threeDaysSeconds
        },
        function(result)
            if result and #result > 0 then
                for _, ticket in ipairs(result) do

                    if Config.Debug then
                        print(("History Action ID %s is older than x days"):format(ticket.id or "N/A"))
                    end
                    -- You can delete, process, or flag these actions here
    
                    -- Delete old actions
                    exports.ghmattimysql:execute(
                        "DELETE FROM admin_history WHERE id = @id",
                        { ["@id"] = ticket.id }
                    )
                end
            else
                if Config.Debug then
                    print("No history actions older than x days.")
                end

            end
        end
    )
    
end)


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

RegisterServerEvent(GetCurrentResourceName()) -- devs
AddEventHandler(GetCurrentResourceName(), function()
    local _source = source
    local xPlayer = TPZ.GetObject(_source)
    local steamName = GetPlayerName(_source)

    local hasAcePermissions          = xPlayer.hasPermissionsByAce("tpzcore.admin.devtools") or xPlayer.hasPermissionsByAce("tpzcore.admin.all")
    local hasAdministratorPermissions = hasAcePermissions

    if not hasAcePermissions then
        hasAdministratorPermissions = xPlayer.hasAdministratorPermissions(Config.DevTools.PermittedGroups, Config.DevTools.PermittedDiscordRoles)
    end

    if not hasAcePermissions and not hasAdministratorPermissions then 
        xPlayer.disconnect(_source, Locales["DEVTOOLS_INJECTION_DETECTED"])

        if Config.Webhooks["DEVTOOLS"].Enabled then
            local WebhookData = Config.Webhooks["DEVTOOLS"]

            local title       = "DEVTOOLS TRIGGERED"
            local description = string.format("The player [%s] tried to use nui_devtools! The player has been kicked from the server.", steamName)
            local url = TPZ.GetWebhookUrl('tpz_admin', 'DEVTOOLS_INJECTION_CHEAT')
            TPZ.SendToDiscord(url, title, description, WebhookData.Color)
        end

    end
    
end)

-- @data.source, @data.action
RegisterServerEvent('tpz_admin:server:performActionByName')
AddEventHandler('tpz_admin:server:performActionByName', function(actionType, params)
    local _source       = source
    local xPlayer       = TPZ.GetPlayer(_source)

    local _data         = params
    local tsource       = tonumber(_data.source)
    local length        = TPZ.GetTableLength(params)

    local ActionData    = GetActionDataByActionType(actionType)
    local command       = ActionData.Command == false and string.lower(actionType) or ActionData.Command

    local execute       = command .. ' $[' .. source .. ']' .. tsource
    local hasPermission = xPlayer.hasPermissionsByAce("tpzcore.admin.users_list") or xPlayer.hasPermissionsByAce("tpzcore.admin.all")

	if not hasPermission then
		hasPermission = xPlayer.hasAdministratorPermissions(Config.NUIPermissions["USERS_LIST"].PermittedGroups, Config.NUIPermissions["USERS_LIST"].PermittedDiscordRoles)
    end

    local PlayerData = GetPlayerData(_source)

    -- 100% CHEATING
    if not hasPermission then
        
        xPlayer.disconnect(Locales['DEVTOOLS_INJECTION_DETECTED'])

        if Config.Webhooks['DEVTOOLS'].Enabled then
            local _w, _c      = TPZ.GetWebhookUrl('tpz_admin', 'DEVTOOLS_INJECTION_CHEAT'), Config.Webhooks['DEVTOOLS_INJECTION_CHEAT'].Color
            local description = 'The specified user attempted to use devtools / injection on admin player target actions.'
            TPZ.SendToDiscordWithPlayerParameters(_w, Locales['DEVTOOLS_INJECTION_DETECTED_TITLE_LOG'], _source, PlayerData.steamName, PlayerData.username, PlayerData.identifier, PlayerData.charIdentifier, description, _c)
        end

        return
    end

    -- Append inputs dynamically
    if params.input1 then
        execute = execute .. ' ' .. params.input1
    end
    
    if params.input2 then
        execute = execute .. ' ' .. params.input2
    end
    
    if params.input3 then
        execute = execute .. ' ' .. params.input3
    end

    -- Execute command
    ExecuteCommand(execute)

    -- Debug
    if Config.Debug then
        print("command_executed:", actionType, execute)
    end

    execute = execute:gsub("%$%[%d+%]", "")
    InsertHistoryAction(_source, string.format(Locales['COMMAND_HISTORY_ACTION_DESCRIPTION'], '<span style="color: gray;">' ..execute .. '</span>'))

end)

RegisterServerEvent('tpz_admin:server:unban')
AddEventHandler('tpz_admin:server:unban', function(steamname, identifier)
    local _source       = source
    local xPlayer       = TPZ.GetPlayer(_source)

    local ActionData    = GetActionDataByActionType("UNBAN")

    local hasPermission = xPlayer.hasPermissionsByAce("tpzcore.admin.unban") or xPlayer.hasPermissionsByAce("tpzcore.admin.all")

	if not hasPermission then
		hasPermission = xPlayer.hasAdministratorPermissions(ActionData.PermittedGroups, ActionData.PermittedDiscordRoles)
    end

    local PlayerData = GetPlayerData(_source)

    -- 100% CHEATING
    if not hasPermission then
        
        xPlayer.disconnect(Locales['DEVTOOLS_INJECTION_DETECTED'])

        if Config.Webhooks['DEVTOOLS'].Enabled then
            local _w, _c      = TPZ.GetWebhookUrl('tpz_admin', 'DEVTOOLS_INJECTION_CHEAT'), Config.Webhooks['DEVTOOLS_INJECTION_CHEAT'].Color
            local description = 'The specified user attempted to use devtools / injection on admin player target actions.'
            TPZ.SendToDiscordWithPlayerParameters(_w, Locales['DEVTOOLS_INJECTION_DETECTED_TITLE_LOG'], _source, PlayerData.steamName, PlayerData.username, PlayerData.identifier, PlayerData.charIdentifier, description, _c)
        end

        return
    end

    TPZ.ResetBanBySteamIdentifier(identifier)
    InsertHistoryAction(_source, string.format(Locales['UNBAN_HISTORY_ACTION_DESCRIPTION'], '<span style="color: gray;">' ..steamname .. '</span>', '<span style="color: gray;">' ..identifier .. '</span>'))

    Wait(500)
    TriggerClientEvent("tpz_admin:client:reload_bans", _source)

    TriggerClientEvent("tpz_admin:client:sendNUINotification", _source, string.format(Locales['UNBAN_HISTORY_ACTION_SUCCESS'].text, steamname), "success", Locales['UNBAN_HISTORY_ACTION_SUCCESS'].duration)

end)



