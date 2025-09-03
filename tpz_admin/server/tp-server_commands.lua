local TPZ = exports.tpz_core:getCoreAPI()


-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

local function GetPlayerData(source)

  local xPlayer = TPZ.GetPlayer(source)

  return {
    identifier     = xPlayer.getIdentifier(),
    charIdentifier = xPlayer.getCharacterIdentifier(),
    group          = xPlayer.getGroup(),
    steamName      = GetPlayerName(source),
  }

end

-----------------------------------------------------------
--[[ Command Registrations ]]--
-----------------------------------------------------------

-- ADMIN MENU
RegisterCommand(Config.AdminMenu.Command, function(source, args, rawCommand)
  local _source = source

  if _source == 0 then
    print(Locales['COMMAND_NOT_PERMITTED_ON_CONSOLE'])
    return
  end

	local xPlayer = TPZ.GetPlayer(source)

  local hasPermissions = xPlayer.hasPermissionsByAce("tpzcore.admin.menu") or xPlayer.hasPermissionsByAce("tpzcore.admin.all")

  if not hasPermissions then
    hasPermissions = xPlayer.hasAdministratorPermissions(Config.AdminMenu.PermittedGroups, Config.AdminMenu.PermittedDiscordRoles)
  end

  if hasPermissions then
    TriggerClientEvent("tpz_admin:client:open", _source)

  else
    SendNotification(_source, Locales['NOT_PERMITTED'], "error")
  end

end, false)

-- NOCLIP
RegisterCommand(Config.Noclip.Command, function(source, args, rawCommand)
  local _source = source
  local xPlayer = TPZ.GetPlayer(source)

  if _source == 0 then
    print(Locales['COMMAND_NOT_PERMITTED_ON_CONSOLE'])
    return
  end

  if not xPlayer.loaded() then -- in case player executes the command from character selection.
    return
  end

  local identifier     = xPlayer.getIdentifier()
  local charIdentifier = xPlayer.getCharacterIdentifier()
  local group          = xPlayer.getGroup()
  local steamName      = GetPlayerName(_source)

  local hasPermissions = xPlayer.hasPermissionsByAce("tpzcore.admin.noclip") or xPlayer.hasPermissionsByAce("tpzcore.admin.all")

  if not hasPermissions then
    hasPermissions = xPlayer.hasAdministratorPermissions(Config.Noclip.PermittedGroups, Config.Noclip.PermittedDiscordRoles)
  end

  if hasPermissions then
    TriggerClientEvent("tpz_admin:setNoClipStatus", _source)

  else
    SendNotification(_source, Locales['NOT_PERMITTED'], "error")
  end

  local webhookData = Config.Noclip.Webhooks

  if webhookData.Enabled then

    local title   = "📋` /" .. Config.Noclip.Command .. "`"
    local message = "**Steam name:** `" .. steamName .. " (" .. group .. ")`\n**Identifier:** `" .. identifier .. "`\n**Character Identifier:** `" .. charIdentifier .. "`\n**Action:** `Used No Clip Command`"

    TPZ.SendToDiscord(webhookData.Url, title, message, webhookData.Color)
  end

end, false)


-- ALL COMMANDS THROUGH PERMISSIONS
Citizen.CreateThread(function()

  for index, command in pairs (Config.Permissions) do

    if command.Command ~= false then
  
      RegisterCommand(command.Command, function(source, args, rawCommand)
        local _source = source
  
        local hasPermissions, await = false, true
   
        if _source ~= 0 then

          local xPlayer = TPZ.GetPlayer(source)
  
          hasPermissions = xPlayer.hasPermissionsByAce("tpzcore.admin." .. string.lower(command.ActionType)) or xPlayer.hasPermissionsByAce("tpzcore.admin.all")
  
          if not hasPermissions then
            hasPermissions = xPlayer.hasAdministratorPermissions(command.PermittedGroups, command.PermittedDiscordRoles)
          end

          await = false
          
        else
          hasPermissions = true -- CONSOLE HAS PERMISSIONS.
          await = false
        end
    
        while await do
          Wait(100)
        end
      
        if hasPermissions then

          local webhookTitle

          -- The specified commands require target source.
          if command.ActionType == 'SPECTATE' or command.ActionType == 'FREEZE' or command.ActionType == 'KICK' or command.ActionType == 'BAN' or command.ActionType == 'WARN' then
            local target = args[1]

            if target == nil or target == '' or tonumber(target) == nil then
              SendNotification(_source,  Locales['INCORRECT_SYNTAX'], "error")
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

            if command.ActionType == 'SPECTATE' then

              if _source == 0 then
                print(Locales['COMMAND_NOT_PERMITTED_ON_CONSOLE'])
                return
              end

              local targetCoords = GetEntityCoords(GetPlayerPed(target))
              TriggerClientEvent("tpz_admin:spectatePlayer", _source, target, targetCoords)

              webhookTitle   = "📋` /" .. command.Command .. ' ' .. target .. "`"

            elseif command.ActionType == 'FREEZE' then

              TriggerClientEvent("tpz_admin:freezePlayer", target)

              webhookTitle   = "📋` /" .. command.Command .. ' ' .. target .. "`"

            elseif command.ActionType == 'KICK' then
            
              local reason = args[2]

              if reason == nil or reason == '' then
                SendNotification(_source, Locales['INCORRECT_SYNTAX'] , "error")
                return
              end
  
              local reasonConcat = table.concat(args, " ", 2)

              DropPlayer(target, reasonConcat)
              SendNotification(_source, Locales['KICKED_SELECTED_PLAYER'], "success")

              webhookTitle   = "📋` /" .. command.Command .. ' ' .. target .. ' ' .. reasonConcat .. "`"

            elseif command.ActionType == 'BAN' then

              local duration, reason = args[2], args[3]

              if reason == nil or reason == '' or duration == nil or duration == '' or duration == 0 or tonumber(duration) == nil then
                SendNotification(_source, Locales['INCORRECT_SYNTAX'], "error")
                return
              end

              local reasonConcat = table.concat(args, " ", 3)
              duration = tonumber(duration)

              local reasonDisplay = string.format(Locales['BAN_REASON_DESCRIPTION'], reasonConcat) -- permanent
              tPlayer.ban(reasonConcat, ( duration * 60 * 60 ) ) -- HOURS

              SendNotification(_source, Locales['BANNED_SELECTED_PLAYER'], "success")

              webhookTitle   = "📋` /" .. command.Command .. ' ' .. target .. ' ' .. reasonConcat .. ' ' .. duration .. "`"

            elseif command.ActionType == 'WARN' then

              local reason = args[2]

              if (reason == nil or reason == '') then
                SendNotification(_source, Locales['INCORRECT_SYNTAX'], "error")
                return
              end

              local reasonConcat = table.concat(args, " ", 2)

              local isBanned = tPlayer.addWarning()

              Wait(1000) -- mandatory wait.

              if isBanned then
                SendNotification(_source, Locales['BANNED_SELECTED_PLAYER_REACHED_WARNINGS'], "success")

              else
                SendNotification(_source, Locales['WARNING_SENT'], "success")
              end

              webhookTitle   = "📋` /" .. command.Command .. ' ' .. target .. ' ' .. reasonConcat .. "`"

            elseif command.ActionType == 'RESET_WARNINGS' then

              tPlayer.clearPlayerWarnings()
              SendNotification(_source, Locales['WARNINGS_RESET'], "success")

              webhookTitle   = "📋` /" .. command.Command .. ' ' .. target .. "`"

            end

          elseif command.ActionType == 'HEAL_ALL' or command.ActionType == 'GOD_MODE' or command.ActionType == 'PLAYER_BLIPS' then

            local args = args[1]

            if args then -- THERE SHOULD NOT BE ANY ARGS FOR THOSE COMMANDS.
              SendNotification(_source, Locales['INCORRECT_SYNTAX'], "error")
              return
            end

            if command.ActionType == 'GOD_MODE' then

              if _source == 0 then
                print(Locales['COMMAND_NOT_PERMITTED_ON_CONSOLE'])
                return
              end

              TriggerClientEvent('tpz_admin:onSelectedPlayerGodModeStatus', _source)

              webhookTitle   = "📋` /" .. command.Command .. "`"

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

              webhookTitle   = "📋` /" .. command.Command .. "`"

            elseif command.ActionType == 'PLAYER_BLIPS' then

              if _source == 0 then
                print(Locales['COMMAND_NOT_PERMITTED_ON_CONSOLE'])
                return
              end

              TriggerClientEvent("tpz_admin:setPlayerBlipsVisibility", _source)
            end

            webhookTitle   = "📋` /" .. command.Command .. "`"

          elseif command.ActionType == 'ANNOUNCEMENT' then
            local duration, announcement = args[1], args[2]

            if announcement == nil or announcement == '' or duration == nil or duration == '' or duration == 0 or tonumber(duration) == nil then
              SendNotification(_source, Locales['INCORRECT_SYNTAX'], "error")
              return
            end

            local announcementConcat = table.concat(args, " ", 2)
            duration = tonumber(duration)

            TriggerClientEvent('tpz_core:sendAnnouncement', -1, Locales['SERVER_ANNOUNCEMENT'], announcementConcat, duration * 1000)

          elseif command.ActionType == "UNBAN" then
            local targetSteamHex = args[1]

            if targetSteamHex == nil or targetSteamHex == '' then
              SendNotification(_source, Locales['INCORRECT_SYNTAX'], "error")
              return
            end

            TPZ.ResetBanBySteamIdentifier(targetSteamHex)
            SendNotification(_source, string.format(Locales['UNBANNED_SELECTED_PLAYER'], targetSteamHex), "success")
          end

          if Config.Webhooks['COMMANDS'].Enabled then

            local message = 'The specified command has been executed from the console (txadmin?).'

            if _source ~= 0 then
              local PlayerData = GetPlayerData(_source)
              message = string.format("**Steam name:** `%s (%s)`\n**Identifier:** `%s`\n**Character Identifier:** `%s`\n**Action:** `Used %s Command Type`", PlayerData.steamName, PlayerData.group, PlayerData.identifier, PlayerData.charIdentifier, command.ActionType)
            end
            
            TPZ.SendToDiscord(Config.Webhooks['COMMANDS'].Url, webhookTitle, message, Config.Webhooks['COMMANDS'].Color)
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



