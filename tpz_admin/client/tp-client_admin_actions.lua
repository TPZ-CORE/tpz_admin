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

    if not ActionData.HasNoClip then
        
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
AddEventHandler("tpz_admin:spectatePlayer", function(target, targetCoords)
    local player     = PlayerPedId()
    local targetPed  = 0

    if ActionData.IsSpectating or target == 0 or targetCoords == nil then

        if ActionData.IsSpectating then

            DoScreenFadeOut(2000)

            repeat Wait(0) until not IsScreenFadingOut()
    
            RenderScriptCams(true, false, 1, true, true, 0)
            DestroyCam(Camera, true)
            DestroyAllCams(true)
            SetEntityCoords(player, ActionData.LastSpectatingCoords.x, ActionData.LastSpectatingCoords.y, ActionData.LastSpectatingCoords.z - 1, false, false, false, false)
            SetEntityVisible(player, true)
            SetEntityCanBeDamaged(player, false)
            SetEntityInvincible(player, true)
            DoScreenFadeIn(2000)
    
            repeat Wait(0) until IsScreenFadingIn()
    
            ActionData.IsSpectating = false
            ActionData.LastSpectatingCoords = nil

        end

        return
    end

    DoScreenFadeOut(2000)

    repeat Wait(0) until not IsScreenFadingOut()

    ActionData.LastSpectatingCoords = GetEntityCoords(player)

    SetEntityVisible(player, false)
    SetEntityCanBeDamaged(player, false)
    SetEntityInvincible(player, true)
    SetEntityCoords(player, targetCoords.x + 15, targetCoords.y + 15, targetCoords.z, false, false, false, false)
   
    Wait(500)
    targetPed = GetPlayerPed(target)
   
    Wait(500)

    Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(Camera, targetPed, 0.0, -2.0, 1.0, false)
    SetCamActive(Camera, true)
    RenderScriptCams(true, true, 1, true, true, 0)
    DoScreenFadeIn(2000)

    repeat Wait(0) until IsScreenFadingIn()

    ActionData.IsSpectating = true

end)

RegisterNetEvent("tpz_admin:freezePlayer")
AddEventHandler("tpz_admin:freezePlayer", function(state)
    local player = PlayerPedId()
    ActionData.HasFreezeState = not ActionData.HasFreezeState

    FreezeEntityPosition(player, ActionData.HasFreezeState)
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
            
                        local targetPed = GetPlayerPed(tonumber(player.source))
                        local coords    = GetEntityCoords(targetPed)
                
                        local BlipHandle = N_0x554d9d53f696d002(1664425300, coords.x, coords.y, coords.z)
                
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

Citizen.CreateThread(function()

    RegisterNoClipPromptActions()

    local FollowCamMode = true

    while true do

        Wait(0)

        local player = PlayerPedId()
        local sleep  = true

		local PlayerData = GetPlayerData()

        if PlayerData.Loaded and ActionData.HasNoClip then
            sleep = false

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

        if sleep then
            Wait(1000)
        end

    end
end)

