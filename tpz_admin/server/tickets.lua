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
    local threeDaysSeconds = Config.DeleteTicketAfter * 24 * 60 * 60 -- x days in seconds
    
    -- Fetch tickets older than x days
    exports.ghmattimysql:execute(
        "SELECT * FROM admin_tickets WHERE timestamp <= @timeLimit",
        {
            ["@timeLimit"] = currentTime - threeDaysSeconds
        },
        function(result)
            if result and #result > 0 then
                for _, ticket in ipairs(result) do

                    if Config.Debug then
                        print(("Ticket ID %s is older than x days"):format(ticket.id or "N/A"))
                    end

                    -- You can delete, process, or flag these tickets here
    
                    -- Delete old tickets
                    exports.ghmattimysql:execute(
                        "DELETE FROM admin_tickets WHERE id = @id",
                        { ["@id"] = ticket.id }
                    )
                end
            else

                if Config.Debug then
                    print("No tickets older than x days.")
                end
            end
        end
    )
    
end)

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
