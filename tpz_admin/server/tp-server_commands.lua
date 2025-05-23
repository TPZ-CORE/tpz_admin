local TPZ = exports.tpz_core:getCoreAPI()

-----------------------------------------------------------
--[[ Command Registrations ]]--
-----------------------------------------------------------

-- ADMIN MENU
RegisterCommand(Config.AdminMenu.Command, function(source, args, rawCommand)
  local _source = source
	local xPlayer = TPZ.GetPlayer(source)

  local hasAcePermissions           = xPlayer.hasPermissionsByAce("tpzcore.admin.menu") or xPlayer.hasPermissionsByAce("tpzcore.admin.all")
  local hasAdministratorPermissions = hasAcePermissions

  if not hasAcePermissions then
      hasAdministratorPermissions = xPlayer.hasAdministratorPermissions(Config.AdminMenu.PermittedDiscordGroups, Config.AdminMenu.PermittedDiscordRoles)
  end

  if hasAcePermissions or hasAdministratorPermissions then
    TriggerClientEvent("tpz_admin:client:open", _source)

  else
    SendNotification(_source, Locales['NOT_PERMITTED'], "error")
  end

end, false)

-- NOCLIP
RegisterCommand(Config.Noclip.Command, function(source, args, rawCommand)
  local _source = source
  local xPlayer = TPZ.GetPlayer(source)

  local hasAcePermissions           = xPlayer.hasPermissionsByAce("tpzcore.admin.noclip") or xPlayer.hasPermissionsByAce("tpzcore.admin.all")
  local hasAdministratorPermissions = hasAcePermissions

  if not hasAcePermissions then
      hasAdministratorPermissions = xPlayer.hasAdministratorPermissions(Config.Noclip.PermittedDiscordGroups, Config.Noclip.PermittedDiscordRoles)
  end

  if hasAcePermissions or hasAdministratorPermissions then

    TriggerClientEvent("tpz_admin:setNoClipStatus", _source)

  else
    SendNotification(_source, Locales['NOT_PERMITTED'], "error")
  end

end, false)


-- ALL COMMANDS THROUGH PERMISSIONS
Citizen.CreateThread(function()

  for index, command in pairs (Config.Permissions) do

    if command.Command ~= false then
  
      RegisterCommand(command.Command, function(source, args, rawCommand)
        local _source = source
        local xPlayer = TPZ.GetPlayer(source)
  
        local hasAcePermissions           = xPlayer.hasPermissionsByAce("tpzcore.admin." .. string.lower(command.ActionType)) or xPlayer.hasPermissionsByAce("tpzcore.admin.all")
        local hasAdministratorPermissions = hasAcePermissions
      
        if not hasAcePermissions then
            hasAdministratorPermissions = xPlayer.hasAdministratorPermissions(command.PermittedDiscordGroups, command.PermittedDiscordRoles)
        end
      
        if hasAcePermissions or hasAdministratorPermissions then

          -- The specified commands require target source.
          if command.ActionType == 'SPECTATE' or command.ActionType == 'FREEZE' or command.ActionType == 'KICK' or command.ActionType == 'BAN' or command.ActionType == 'WARN' then
            local target = args[1]

            if target == nil or target == '' then
              SendNotification(_source,  "~e~ERROR: Use Correct Sintaxis", "error")
              return
            end

            target = tonumber(target)

            local targetSteamName = GetPlayerName(target)

            if targetSteamName == nil then
              SendNotification(_source, Locales['NOT_ONLINE'], "error")
              return
            end

            local tPlayer = TPZ.GetPlayer(tonumber(target))

            if not tPlayer.loaded() then
              SendNotification(_source, Locales['PLAYER_IS_ON_SESSION'], "error")
              return
            end

            local PlayersList = GetPlayerList()

            if command.ActionType == 'SPECTATE' then

              local targetCoords = GetEntityCoords(GetPlayerPed(target))
              TriggerClientEvent("tpz_admin:spectatePlayer", _source, target, targetCoords)
        
            elseif command.ActionType == 'FREEZE' then

              PlayersList[target].isFrozen = not PlayersList[target].isFrozen

              TriggerClientEvent("tpz_admin:freezePlayer", target, PlayersList[target].isFrozen)

              SendNotification(_source, Locales['FREEZE_' .. string.upper(tostring(PlayersList[target].isFrozen))], "info")

            elseif command.ActionType == 'KICK' then
            
              local reason = args[2]

              if reason == nil or reason == '' then
                SendNotification(_source, "~e~ERROR: Use Correct Sintaxis" , "error")
                return
              end
  
              local reason = table.concat(args, " ", 2)

              DropPlayer(target, reason)
              SendNotification(_source, Locales['KICKED_SELECTED_PLAYER'], "success")

            elseif command.ActionType == 'BAN' then
									
              local duration, reason = args[2], args[3]

              if reason == nil or reason == '' or duration == nil or duration == '' or duration == 0 or tonumber(duration) == nil then
                SendNotification(_source, "~e~ERROR: Use Correct Sintaxis", "error")
                return
              end

              local reasonConcat = table.concat(args, " ", 3)
              duration = tonumber(duration)

              local reasonDisplay = string.format(Locales['BAN_REASON_DESCRIPTION'], reasonConcat) -- permanent
              tPlayer.ban(reasonConcat, ( duration * 60 ) ) -- HOURS

              SendNotification(_source, Locales['BANNED_SELECTED_PLAYER'], "success")
              
            elseif command.ActionType == 'WARN' then

              local reason = args[2]

              if (reason == nil or reason == '') then
                SendNotification(_source, "~e~ERROR: Use Correct Sintaxis", "error")
                return
              end

              local isBanned = tPlayer.addWarning()

              Wait(1000) -- mandatory wait.

              if isBanned then
                SendNotification(_source, Locales['BANNED_SELECTED_PLAYER_REACHED_WARNINGS'], "success")

              else
                SendNotification(_source, Locales['WARNING_SENT'], "success")
              end

            elseif command.ActionType == 'RESET_WARNINGS' then

              tPlayer.clearPlayerWarnings()
              SendNotification(_source, Locales['WARNINGS_RESET'], "success")

            end

          elseif command.ActionType == 'HEAL_ALL' or command.ActionType == 'GOD_MODE' or command.ActionType == 'PLAYER_BLIPS' then

            local args = args[1]

            if args then -- THERE SHOULD NOT BE ANY ARGS FOR THOSE COMMANDS.
              SendNotification(_source, "~e~ERROR: Use Correct Sintaxis", "error")
              return
            end

            if command.ActionType == 'GOD_MODE' then
              TriggerClientEvent('tpz_admin:onSelectedPlayerGodModeStatus', _source)

            elseif command.ActionType == 'HEAL_ALL' then

              local playersList = TPZ.GetPlayers()

              for _, player in pairs (playersList.players) do
                
                local target = tonumber(player.source)

                TriggerClientEvent('tpz_core:healPlayer', tonumber(target))

                -- tpz_metabolism.
                TriggerClientEvent("tpz_metabolism:setMetabolismValue", tonumber(target), "HUNGER", "add", 100)
                TriggerClientEvent("tpz_metabolism:setMetabolismValue", tonumber(target), "THIRST", "add", 100)

                TriggerClientEvent("tpz_metabolism:setMetabolismValue", tonumber(target), "STRESS", "remove", 100)
                TriggerClientEvent("tpz_metabolism:setMetabolismValue", tonumber(target), "ALCOHOL", "remove", 100)

                SendNotification(tonumber(target), Locales['TARGET_HEALED'], "info")
              end

              SendNotification(_source, Locales['HEALED_ALL_PLAYERS'], "success")

            elseif command.ActionType == 'PLAYER_BLIPS' then
              TriggerClientEvent("tpz_admin:setPlayerBlipsVisibility", _source)
            end


          elseif command.ActionType == 'ANNOUNCEMENT' then
            -- todo
          end

        else
          SendNotification(_source, Locales['NOT_PERMITTED'], "error")
        end
  
      end)
  
    end
  
  end

end)


-----------------------------------------------------------
--[[ Chat Suggestion Registrations ]]--
-----------------------------------------------------------

RegisterServerEvent("tpz_admin:server:addChatSuggestions")
AddEventHandler("tpz_admin:server:addChatSuggestions", function()
  local _source = source
  TriggerClientEvent("chat:addSuggestion", _source, "/" .. Config.AdminMenu.Command, Config.AdminMenu.Suggestion, { })
  TriggerClientEvent("chat:addSuggestion", _source, "/" .. Config.Noclip.Command, Config.Noclip.Suggestion, { })

  for index, command in pairs (Config.Permissions) do

    if command.Command ~= false then 

      local displayTip = command.CommandHelpTips 

      if not displayTip then
        displayTip = {}
      end

      TriggerClientEvent("chat:addSuggestion", _source, "/" .. command.Command, command.Suggestion, command.CommandHelpTips )
    end

  end

end)
