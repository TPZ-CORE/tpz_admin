
--[[-------------------------------------------------------
 Handlers
]]---------------------------------------------------------

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

end)

--[[-------------------------------------------------------
 Prompts
]]---------------------------------------------------------

local NoClipPrompt1, NoClipPrompt2, NoClipPrompt4
PromptGroup = GetRandomIntInRange(0, 0xffffff)

RegisterNoClipPromptActions = function()
    
    local Controls  = Config.Noclip.Controls

    NoClipPrompt1 = PromptRegisterBegin()
    PromptSetControlAction(NoClipPrompt1, Controls['DOWN'])
    PromptSetControlAction(NoClipPrompt1, Controls['UP'])
    local str1 = CreateVarString(10, 'LITERAL_STRING', Locales['UP_AND_DOWN'])
    PromptSetText(NoClipPrompt1, str1)
    PromptSetEnabled(NoClipPrompt1, 1)
    PromptSetVisible(NoClipPrompt1, 1)
    PromptSetStandardMode(NoClipPrompt1, 1)
    PromptSetGroup(NoClipPrompt1, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, NoClipPrompt1, true)
    PromptRegisterEnd(NoClipPrompt1)

    NoClipPrompt2 = PromptRegisterBegin()
    PromptSetControlAction(NoClipPrompt2, Controls['SPEED_ADJUSTMENT']) -- shift
    local str2 = CreateVarString(10, 'LITERAL_STRING', Locales['SPEED_ADJUSTMENT'])
    PromptSetText(NoClipPrompt2, str2)
    PromptSetEnabled(NoClipPrompt2, 1)
    PromptSetVisible(NoClipPrompt2, 1)
    PromptSetStandardMode(NoClipPrompt2, 1)
    PromptSetGroup(NoClipPrompt2, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, NoClipPrompt2, true)
    PromptRegisterEnd(NoClipPrompt2)

  
    NoClipPrompt4 = PromptRegisterBegin()
    PromptSetControlAction(NoClipPrompt4, Controls['FORWARD'])
    local str3 = CreateVarString(10, 'LITERAL_STRING', Locales['FORWARD'])
    PromptSetText(NoClipPrompt4, str3)
    PromptSetEnabled(NoClipPrompt4, 1)
    PromptSetVisible(NoClipPrompt4, 1)
    PromptSetStandardMode(NoClipPrompt4, 1)
    PromptSetGroup(NoClipPrompt4, PromptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, NoClipPrompt4, true)
    PromptRegisterEnd(NoClipPrompt4)
end
