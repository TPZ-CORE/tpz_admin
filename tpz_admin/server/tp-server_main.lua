
local TPZ = exports.tpz_core:getCoreAPI()

local Players = {}

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

GetPlayerList = function()
    return Players
end

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
        xPlayer.disconnect(_source, Locales["DEVTOOLS_NUI_TRIGGERED"])

        if Config.Webhooks["DEVTOOLS"].Enabled then
            local WebhookData = Config.Webhooks["DEVTOOLS"]

            local title       = "DEVTOOLS TRIGGERED"
            local description = string.format("The player [%s] tried to use nui_devtools! The player has been kicked from the server.", steamName)
            local url = TPZ.GetWebhookUrl('tpz_admin', 'DEVTOOLS_INJECTION_CHEAT')
            TPZ.SendToDiscord(url, title, description, WebhookData.Color)
        end

    end
    
end)


