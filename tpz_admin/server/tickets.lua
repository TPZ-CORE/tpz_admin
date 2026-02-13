
-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterServerEvent('tpz_admin:server:createTicket')
AddEventHandler('tpz_admin:server:createTicket', function(title, message, exclamation)
    local _source = source
    CreateTicket(_source, title, message, exclamation)

    TriggerClientEvent("tpz_admin:client:sendNUINotification", _source, Locales['TICKET_CREATED_SUCCESSFULLY'].text, "success", Locales['TICKET_CREATED_SUCCESSFULLY'].duration)
end)

-- No need to check for devtools - injection, they can never find the timestamp of the tickets.
RegisterServerEvent('tpz_admin:server:deleteTicket')
AddEventHandler('tpz_admin:server:deleteTicket', function(timestamp)
    local _source = source

    timestamp = tonumber(timestamp)

    exports.ghmattimysql:execute(
        "DELETE FROM admin_tickets WHERE timestamp = @timestamp",
        {
            ["@timestamp"] = timestamp
        }
    )

    TriggerClientEvent("tpz_admin:client:reload_tickets", _source)
    TriggerClientEvent("tpz_admin:client:sendNUINotification", _source, Locales['TICKET_DELETED_SUCCESSFULLY'].text, "success", Locales['TICKET_DELETED_SUCCESSFULLY'].duration)

end)