
GetPlayerData = function(source)
	local _source = source
    local xPlayer = exports.tpz_core:getCoreAPI().GetPlayer(_source)

	return {
        steamName      = GetPlayerName(_source),
        username       = xPlayer.getFirstName() .. ' ' .. xPlayer.getLastName(),
		identifier     = xPlayer.getIdentifier(),
        charIdentifier = xPlayer.getCharacterIdentifier(),
		job            = xPlayer.getJob(),
	}

end

GetSteamID = function(source)
    local sid = GetPlayerIdentifiers(source)[1] or false

    if (sid == false or sid:sub(1, 5) ~= "steam") then

        return false
    end

    return sid
end

GetIdentity = function(source, identity)
    local num = 0
    if not source then return end
    
    local num2 = GetNumPlayerIdentifiers(source)

    if GetNumPlayerIdentifiers(source) > 0 then
        local ident = nil
        while num < num2 and not ident do
            local a = GetPlayerIdentifier(source, num)
            if string.find(a, identity) then ident = a end
            num = num + 1
        end
        --return ident;
        if ident == nil then
            return ""
        end
        return string.sub(ident, 9)
    end
end

GetActionDataByActionType = function(actionType)

    for _, data in pairs (Config.Permissions) do 

        if data.ActionType == actionType then 
            return data 

        end

    end

    return nil
    
end

InsertHistoryAction = function(source, text)
    local _source        = source
    local PlayerData     = GetPlayerData(_source)
    local currentTime    = os.date("%H:%M %d/%m/%Y")

    local data = {
        steamname  = PlayerData.steamName,
        identifier = PlayerData.identifier,
        action     = text,
        date       = currentTime,
    }

    exports.ghmattimysql:execute('INSERT INTO admin_history (identifier, steamname, action, date) VALUES (@identifier, @steamname, @action, @date)', {
        ['@identifier'] = data.identifier,
        ['@steamname']  = data.steamname,
        ['@action']     = data.action,
        ['@date']       = data.date,
        ['@timestamp']  = os.time(),
    }, function(affectedRows) end)
end

CreateTicket = function(source, title, message, exclamation)
    local _source     = source
    local PlayerData  = GetPlayerData(_source)
    local currentTime = os.date("%H:%M %d/%m/%Y")

    exports.ghmattimysql:execute('INSERT INTO admin_tickets (identifier, charidentifier, steamname, fullname, title, message, exclamation, date, timestamp) VALUES (@identifier, @charidentifier, @steamname, @fullname, @title, @message, @exclamation, @date, @timestamp)', {
        ['@identifier']     = PlayerData.identifier,
        ['@charidentifier'] = PlayerData.charIdentifier,
        ['@steamname']      = PlayerData.steamName,
        ['@fullname']       = PlayerData.username,
        ['@title']          = title,
        ['@message']        = message,
        ['@exclamation']    = tonumber(exclamation),
        ['@date']           = currentTime,
        ['@timestamp']      = os.time(),
    }, function(affectedRows) end)

    if Config.Webhooks["TICKETS"].Enabled then
        local WebhookData = Config.Webhooks["TICKETS"]

        local webhook = exports.tpz_core:getCoreAPI().GetWebhookUrl('tpz_admin', 'TICKETS')
        exports.tpz_core:getCoreAPI().SendToDiscordWithPlayerParameters(webhook, title, _source, PlayerData.steamName, PlayerData.username, PlayerData.identifier, PlayerData.charIdentifier, message, WebhookData.Color)

    end

end