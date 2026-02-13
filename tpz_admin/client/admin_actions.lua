local TPZ = exports.tpz_core:getCoreAPI()

local ActionData = { 
    HasNoClip            = false,
    NoClipSpeed          = 1,

    IsSpectating         = false,
    LastSpectatingCoords = nil,

    HasActiveBlips       = false,
    PlayerBlips          = {},

    HasFreezeState       = false,

    HasGodMode           = false,
}

local Cooldown = false

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    for _, blip in pairs (ActionData.PlayerBlips) do
        RemoveBlip(blip)
    end    

    ActionData.PlayerBlips = nil
    
end)

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterNetEvent("tpz_admin:setNoClipStatus")
AddEventHandler("tpz_admin:setNoClipStatus", function()
    local player = PlayerPedId()

    ActionData.HasNoClip = not ActionData.HasNoClip

    if ActionData.HasNoClip then

        TriggerEvent("tpz_admin:client:noclip_tasks")

    elseif not ActionData.HasNoClip then
        
        ResetEntityAlpha(player)
        if (player ~= PlayerPedId()) then
            ResetEntityAlpha(PlayerPedId())
        end

        SetEntityCollision(player, true, true)
        FreezeEntityPosition(player, false)
        SetEntityInvincible(player, false)
        SetEntityVisible(player, true)
        SetEveryoneIgnorePlayer(PlayerPedId(), false)
        SetPedCanBeTargetted(player, true)

    end
end)


RegisterNetEvent("tpz_admin:spectatePlayer")
AddEventHandler("tpz_admin:spectatePlayer", function(target)
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)

    if (target ~= nil) then 

        while not IsScreenFadedOut() do
            Wait(50)
            DoScreenFadeOut(2000)
        end
    
        ActionData.IsSpectating = true

        if ActionData.LastSpectatingCoords == nil then
            ActionData.LastSpectatingCoords = { x = coords.x, y = coords.y, z = coords.z, h = GetEntityHeading(player) }
        end

        local targetId   = GetPlayerFromServerId(target)
        local targetPed  = GetPlayerPed(targetId)
        local tcoords    = GetEntityCoords(targetPed)

        SetEntityVisible(player, false)

        exports.tpz_core.getCoreAPI().TeleportToCoords( tcoords.x, tcoords.y, tcoords.z, tcoords.h)
        SetEntityCollision(player, true, false)
        DisplayRadar(false)

        Wait(3000)
        DoScreenFadeIn(2000)

        Citizen.CreateThread(function()

            while ActionData.IsSpectating do 

                Wait(0)

                TaskStandStill(player, -1)
                SetEntityCanBeDamaged(player, false)
                SetEntityInvincible(player, true)
                SetEntityCollision(player, false, false)
                DisplayRadar(false)

            end

        end)
        
         Citizen.CreateThread(function()
        
            while ActionData.IsSpectating do 
                Wait(10)
                local targetPed = GetPlayerPed(targetId)
                local tcoords   = GetEntityCoords(targetPed)
                SetEntityCoords(player, tcoords.x, tcoords.y, tcoords.z, true, true, true, false)
            end
        
        end)

    else 

        if not ActionData.IsSpectating then 
            return
        end

        while not IsScreenFadedOut() do
            Wait(50)
            DoScreenFadeOut(2000)
        end    


        ActionData.IsSpectating = false
        Wait(1000)
        SetEntityCollision(player, true, true)
        TaskStandStill(player, 1)

        exports.tpz_core.getCoreAPI().TeleportToCoords( ActionData.LastSpectatingCoords.x, ActionData.LastSpectatingCoords.y, ActionData.LastSpectatingCoords.z, ActionData.LastSpectatingCoords.h)

        SetEntityVisible(player, true)
        SetEntityCanBeDamaged(player, true)
        SetEntityInvincible(player, false)

        DisplayRadar(true)

        ActionData.LastSpectatingCoords = nil

        Wait(5000)
        DoScreenFadeIn(2000)

    end

end)

RegisterNetEvent("tpz_admin:freezePlayer")
AddEventHandler("tpz_admin:freezePlayer", function()
    ActionData.HasFreezeState = not ActionData.HasFreezeState

    FreezeEntityPosition(PlayerPedId(), ActionData.HasFreezeState)
end)

RegisterNetEvent("tpz_admin:setPlayerBlipsVisibility")
AddEventHandler("tpz_admin:setPlayerBlipsVisibility", function()
    
    if Cooldown then
        return
    end

    Cooldown = true

    ActionData.HasActiveBlips = not ActionData.HasActiveBlips

    if not ActionData.HasActiveBlips then
        Cooldown = false
    end

    SendNotification(nil, Locales['PLAYER_BLIPS_' .. string.upper(tostring(ActionData.HasActiveBlips))], "success")
		
    Citizen.CreateThread(function ()

        while true do

            for _, blip in pairs (ActionData.PlayerBlips) do
                RemoveBlip(blip)
            end   

            if not ActionData.HasActiveBlips then
                Cooldown = false
                break
            end

            if ActionData.HasActiveBlips then

                TriggerEvent("tpz_core:ExecuteServerCallBack", "tpz_admin:getOnlinePlayers", function(result)

                    for _, player in pairs (result) do
            
                        local BlipHandle = N_0x554d9d53f696d002(1664425300, player.coords.x, player.coords.y, player.coords.z)
                
                        SetBlipSprite(BlipHandle, -1350763423, 1)
                        SetBlipScale(BlipHandle, 0.2)
                        Citizen.InvokeNative(0x9CB1A1623062F402, BlipHandle, player.steamname .. " (" .. player.username .. ")")

                        ActionData.PlayerBlips[player.source] = BlipHandle
                    end
            
                end, { requestAll = false })

            end

            Wait(10000)

        end

    end)

    Wait(2000)
    Cooldown = false

end)

RegisterNetEvent("tpz_admin:onSelectedPlayerGodModeStatus")
AddEventHandler("tpz_admin:onSelectedPlayerGodModeStatus", function()
    local player = PlayerId()

    if Cooldown then
        return
    end

    Cooldown = true

    ActionData.HasGodMode = not ActionData.HasGodMode

    SendNotification(nil, Locales['GOD_MODE_' .. string.upper(tostring(ActionData.HasGodMode))], "success")
		
    Citizen.CreateThread(function ()

        while true do

            Citizen.Wait(1000)

            if not ActionData.HasGodMode then
                SetPlayerInvincible(player, false)
                Cooldown = false
                break
            end

            if ActionData.HasGodMode then
                SetPlayerInvincible(player, true)

                TriggerEvent("tpz_metabolism:setMetabolismValue", "HUNGER", "add", 100)
                TriggerEvent("tpz_metabolism:setMetabolismValue", "THIRST", "add", 100)
        
                TriggerEvent("tpz_metabolism:setMetabolismValue", "STRESS", "remove", 100)
                TriggerEvent("tpz_metabolism:setMetabolismValue", "ALCOHOL", "remove", 100)
            end
        end

    end)

    Wait(2000)
    Cooldown = false
end)

-----------------------------------------------------------
--[[ Threads ]]--
-----------------------------------------------------------

Citizen.CreateThread(function() RegisterNoClipPromptActions() end)

AddEventHandler("tpz_admin:client:noclip_tasks", function()

    Citizen.CreateThread(function()

        local FollowCamMode = true
    
        while true do

            Wait(1)

            local player     = PlayerPedId()
            local PlayerData = GetPlayerData()

            if not ActionData.HasNoClip then
                break
            end
    
            local NoClipData        = Config.Noclip
            local CurrentSpeed      = NoClipData.Speeds[ActionData.NoClipSpeed].speed
            local CurrentSpeedLabel = NoClipData.Speeds[ActionData.NoClipSpeed].label

            local Controls          = NoClipData.Controls

            if IsPedInAnyVehicle(player, false) then
                player = GetVehiclePedIsIn(player, false)
            end

            local yoff, zoff = 0.0, 0.0

            DisableControlAction(0, 0xB238FE0B, true)
            DisableControlAction(0, 0x3C0A40F2, true)

            if IsDisabledControlJustPressed(1, Controls['CAMERA_MODE']) then
                FollowCamMode = not FollowCamMode
            end

            local label = CreateVarString(10, 'LITERAL_STRING', string.format(Locales['NO_CLIP_DESCRIPTION'], CurrentSpeedLabel, CurrentSpeed))
            PromptSetActiveGroupThisFrame(PromptGroup, label)

            if IsDisabledControlJustPressed(1, Controls['SPEED_ADJUSTMENT']) then

                local speedsLenth = TPZ.GetTableLength(NoClipData.Speeds)

                if speedsLenth > 1 then

                    ActionData.NoClipSpeed = ActionData.NoClipSpeed + 1

                    if ActionData.NoClipSpeed > speedsLenth then
                        ActionData.NoClipSpeed = 1
                    end

                end
                
            end

            if IsDisabledControlPressed(0, Controls['FORWARD']) then
                yoff = NoClipData.OffsetMultipliers['Y']
            end

            if IsDisabledControlPressed(0, Controls['UP']) then
                zoff = NoClipData.OffsetMultipliers['Z']
            end

            if IsDisabledControlPressed(0, Controls['DOWN']) then
                zoff = -NoClipData.OffsetMultipliers['Z']
            end

            local newPos  = GetOffsetFromEntityInWorldCoords(player, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
            local heading = GetEntityHeading(player)

            SetEntityVelocity(player, 0.0, 0.0, 0.0)
            SetEntityRotation(player, 0.0, 0.0, 0.0, 0, false)
  
            if (FollowCamMode) then
                SetEntityHeading(player, GetGameplayCamRelativeHeading())
            else
                SetEntityHeading(player, heading);
            end

            SetEntityCoordsNoOffset(player, newPos.x, newPos.y, newPos.z, true, true, true)
            SetEntityAlpha(player, 51, false)

            if (player ~= PlayerPedId()) then
                SetEntityAlpha(PlayerPedId(), 51, false)
            end

            SetEntityCollision(player, false, false)
            FreezeEntityPosition(player, true)
            SetEntityInvincible(player, true)
            SetEntityVisible(player, false)
            SetEveryoneIgnorePlayer(PlayerPedId(), true)
            SetPedCanBeTargetted(player, false)

        end

    end)

end)
