local TPZ = exports.tpz_core:getCoreAPI()
local CURRENT_WINDOW = nil
local HAS_COOLDOWN = false
local SEARCH_INPUT = nil

local SELECTED_ITEMS_LIST_ACTION_TYPE = nil

local Pages = {
    {min = 1,     max = 10,    page = 1},
    {min = 11,    max = 20,    page = 2},
    {min = 21,    max = 30,    page = 3},
    {min = 31,    max = 40,    page = 4},
    {min = 41,    max = 50,    page = 5},
    {min = 51,    max = 60,    page = 6},
    {min = 61,    max = 70,    page = 7},
    {min = 71,    max = 80,    page = 8},
    {min = 81,    max = 90,    page = 9},
    {min = 91,    max = 100,   page = 10},
    {min = 101,   max = 110,   page = 11},
    {min = 111,   max = 120,   page = 12},
    {min = 121,   max = 130,   page = 13},
    {min = 131,   max = 140,   page = 14},
    {min = 141,   max = 150,   page = 15},
    {min = 151,   max = 160,   page = 16},
    {min = 161,   max = 170,   page = 17},
    {min = 171,   max = 180,   page = 18},
    {min = 181,   max = 190,   page = 19},
    {min = 191,   max = 200,   page = 20},
    {min = 201,   max = 210,   page = 21},
    {min = 211,   max = 220,   page = 22},
    {min = 221,   max = 230,   page = 23},
    {min = 231,   max = 240,   page = 24},
    {min = 241,   max = 250,   page = 25},
    {min = 251,   max = 260,   page = 26},
    {min = 261,   max = 270,   page = 27},
    {min = 271,   max = 280,   page = 28},
    {min = 281,   max = 290,   page = 29},
    {min = 291,   max = 300,   page = 30},
    {min = 301,   max = 310,   page = 31},
    {min = 311,   max = 320,   page = 32},
    {min = 321,   max = 330,   page = 33},
    {min = 331,   max = 340,   page = 34},
    {min = 341,   max = 350,   page = 35},
    {min = 351,   max = 360,   page = 36},
    {min = 361,   max = 370,   page = 37},
    {min = 371,   max = 380,   page = 38},
    {min = 381,   max = 390,   page = 39},
    {min = 391,   max = 400,   page = 40},
}


-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

local function GetPageByIndex(index)

    if index >= 200 then
        return 20
    end

    if index > 0 then

        for _, value in pairs (Pages) do

            if index == value.min or index == value.max then
                return value.page
            end

            if index >= value.min and index <= value.max then
                return value.page
            end
        end

    end

    return 0
end


local RequestUsersSection = function(selectedPage)

    if HAS_COOLDOWN then return end 

    HAS_COOLDOWN = true

    SendNUIMessage({ action = 'RESET_USERS_LIST' })

    local hasPermission = HasNUIPermissionByName("users_list")

    if not hasPermission then

        SendNUIMessage({
            action        = 'SELECTED_WINDOW_SECTION',
            window        = "users-section",
            hasPermission = false,
        })
        
        HAS_COOLDOWN = false
        
        return
    end

    TriggerEvent("tpz_core:ExecuteServerCallBack", "tpz_admin:getOnlinePlayers", function(result)

        local count = 0 

        if TPZ.GetTableLength(result) > 0 then

            for _, player in pairs (result) do 
                
                count = count + 1

                local currentPage = GetPageByIndex(count)
                
                if (currentPage == selectedPage) then

                    SendNUIMessage({
                        action = 'USERS_LIST_INSERT',
                        result = player,
    
                    })
                
                end

            end

        end

        local totalPages = GetPageByIndex(count)

        SendNUIMessage({
            action          = 'SELECTED_WINDOW_SECTION',
            window          = "users-section",
            hasPermission   = true,
            current_players = TPZ.GetTableLength(result),
            max_players     = Config.ServerPlayers,
            locales         = Locales,
            total_pages     = totalPages,
            selected_page   = selectedPage,
        })    

    end, { requestAll = true, requestSelf = true, searchInput = SEARCH_INPUT })

    Wait(1000)
    HAS_COOLDOWN = false

end

local function emptyToNil(value)
    if value == "" or #value == 0 then
        return nil
    end
    return value
end

local function LoadItemsListByType(action, searchInput)

    SendNUIMessage({ action = 'RESET_SELECTED_USER_ITEMS_WEAPONS_LIST' })
    Wait(150)

    local itemsList

    if action == 'ADDITEM' then 
        itemsList = exports.tpz_inventory:getInventoryAPI().getSharedItems()

    elseif action == 'ADDWEAPON' then 
        itemsList = exports.tpz_inventory:getInventoryAPI().getSharedWeapons().Weapons
    end

    local sortedKeys = {}

    for item, _ in pairs(itemsList) do
        if item ~= 'slot1' and item ~= 'slot2'
        and item ~= 'slot3' and item ~= 'slot4' then
            table.insert(sortedKeys, item)
        end
    end

    table.sort(sortedKeys)

    -- normalize search input (nil / empty-safe)
    local search = nil
    if searchInput and searchInput ~= "" then
        search = string.lower(searchInput)
    end

    for _, item in ipairs(sortedKeys) do
        local data = itemsList[item]

        data.item = item
        data.weight = data.weight or 0

        -- only filter if search exists
        if search then
            local label = data.label and string.lower(data.label) or ""
            local itemName = string.lower(item)

            if not (
                string.find(label, search, 1, true) or
                string.find(itemName, search, 1, true)
            ) then
                goto continue
            end
        end

        SendNUIMessage({
            action = 'INSERT_DIALOG_ITEMS_LIST',
            result = data,
        })

        ::continue::
    end
end

-----------------------------------------------------------
--[[ Base Events ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end


end)

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

-----------------------------------------------------------
--[[ NUI Callbacks ]]--
-----------------------------------------------------------

RegisterNUICallback('request_users_section', function()
    SEARCH_INPUT = nil
    RequestUsersSection(1)
end)

-- @data.page
RegisterNUICallback('request_users_page', function(data)
    RequestUsersSection(tonumber(data.page))
end)

-- @data.input 
RegisterNUICallback('request_users_search_input', function(data)
    SEARCH_INPUT = data.input 
    RequestUsersSection(1)
end)

-- @data.source, data.steamname
RegisterNUICallback('request_selected_user_data', function(data)

    SendNUIMessage({ action = 'RESET_SELECTED_USERS_LIST' })

    -- Now we load the selected target player data. (Imagine doing permission checks & request player data, the delay would be higher if we had to load permission checks every time).

    local wait = true
    local data_result
    
    TriggerEvent("tpz_core:ExecuteServerCallBack", "tpz_core:getPlayerData", function(cb)
        data_result = cb
        wait = false
    end, { source = tonumber(data.source)})

    while wait do
        Wait(25)
    end

    data_result.steamname = data.steamname

    while GetActionPermissionsList() == nil do 
        Wait(100)
    end

    for _, action in pairs (GetActionPermissionsList()) do 
        
        SendNUIMessage({
            action = 'USERS_SELECTED_LIST_INSERT',
            result = action,
            source = data.source,
        })

    end

    TriggerEvent("tpz_core:ExecuteServerCallBack", "tpz_admin:getPlayerInventoryContents", function(result)

        for _, item in pairs (result) do

            item.description = item.metadata.description

            item.durability  = item.metadata.durability
            item.usedType    = 0

            SendNUIMessage({
                action = 'USERS_SELECTED_LIST_INSERT_INVENTORY',
                result = item,
            })

        end


    end, { source = data.source })

    SendNUIMessage({
        action          = 'SELECTED_WINDOW_SECTION',
        window          = "users-selected-section",
        hasPermission   = true,
        locales         = Locales,
        result          = data_result,
        description = string.format(
            Locales['NUI_USERS_SELECTED_INFO_TARGET_DESCRIPTION'],
            '<span style="color: white;">' .. data_result.firstname .. ' ' .. data_result.lastname .. '</span>',
            '<span style="color: green;">' .. data_result.money .. '</span>',
            '<span style="color: gold;">' .. data_result.gold .. '</span>',
            '<span style="color: gray;">' .. data_result.blackmoney .. '</span>'
        )
        
        
    })   

end)

local NOT_REQUIRED_PARAMS_LIST = {
    ['HEAL'] = 1,
    ['REVIVE'] = 1,
    ['TPHERE'] = 1,
    ['TPTO'] = 1,
    ['SPECTATE'] = 1,
    ['SPECTATE_CANCEL'] = 1,
    ['FREEZE'] = 1,
    ['KILL'] = 1,
    ['RESET_WARNINGS'] = 1,
}

-- data.source, data.action
RegisterNUICallback('request_perform_selected_user_action', function(data)
    local action, source = data.action, tonumber(data.source)

    --local ActionData = GetActionDataByActionType(data.action)
    
    -- actions that does not require any other params except source.

    if NOT_REQUIRED_PARAMS_LIST[action] then

        TriggerServerEvent("tpz_admin:server:performActionByName", action, { 
            source = source 
        })
        return
    end

    if action == 'ADDITEM' or action == 'ADDWEAPON' then 

        SELECTED_ITEMS_LIST_ACTION_TYPE = action

        SendNUIMessage({
            action  = 'OPEN_DIALOG_ITEMS_WEAPONS_LIST',
            source  = source,
            action_type = action,

            title = action == 'ADDITEM' and Locales['NUI_DIALOG_LIST_ITEMS_TITLE'] or Locales['NUI_DIALOG_LIST_WEAPONS_TITLE'],

            description = action == 'ADDITEM' and Locales['NUI_DIALOG_LIST_ITEMS_DESC'] or Locales['NUI_DIALOG_LIST_WEAPONS_DESC']
        })

        LoadItemsListByType(action, nil)

        return
    end

    -- If action is not additem and not addweapon, we open dialog input.
    local ParamRequirements = {}

    if action == 'KICK' or action == 'WARN' or action == 'SETGROUP' then 

        -- requires SOURCE AND STRING
        ParamRequirements = { [1] = 'STRING' }

    elseif action == 'BAN' then 

        -- requires SOURCE, INT AND STRING
        ParamRequirements = { [1] = '-INT', [2] = 'STRING' }

    elseif action == 'SETJOB' then 

        -- requires SOURCE, STRING AND INT
        ParamRequirements = { [1] = 'STRING', [2] = 'FLOAT' }

    elseif action == 'ADDACCOUNT' or action == 'REMOVEACCOUNT' then 

        -- requires SOURCE, INT AND INT
        ParamRequirements = { [1] = 'INT', [2] = 'FLOAT' }
    end

    local param_length = TPZ.GetTableLength(ParamRequirements)

    SendNUIMessage({
        action  = 'OPEN_DIALOG_INPUT',
        source  = source,
        action_type = action,
        locales = Locales,
        title   = Locales[action .. '_DIALOG_TITLE'],
        input1_description = (param_length >= 1) and Locales[action .. '_DIALOG_DESCRIPTION'][1] or nil,
        input2_description = (param_length >= 2) and Locales[action .. '_DIALOG_DESCRIPTION'][2] or nil,
        input3_description = (param_length >= 3) and Locales[action .. '_DIALOG_DESCRIPTION'][3] or nil,

        placeholder1 = (param_length >= 1) and Locales[action .. '_DIALOG_PLACEHOLDER'][1] or nil,
        placeholder2 = (param_length >= 2) and Locales[action .. '_DIALOG_PLACEHOLDER'][2] or nil,
        placeholder3 = (param_length >= 3) and Locales[action .. '_DIALOG_PLACEHOLDER'][3] or nil,

        input1_type = (param_length >= 1) and ParamRequirements[1] or "STRING",
        input2_type = (param_length >= 2) and ParamRequirements[2] or "STRING",
        input3_type = (param_length >= 3) and ParamRequirements[3] or "STRING",

        item = nil,
    })   



end)


RegisterNUICallback('request_perform_selected_user_action2', function(data)
    local action, source, input1, input2, input3 = data.action, tonumber(data.source), data.input1, data.input2, data.input3

    input1 = emptyToNil(input1)
    input2 = emptyToNil(input2)
    input3 = emptyToNil(input3)

    local action_data = {
        source = source,
        input1 = input1,
    }

    if input2 ~= nil then
        action_data.input2 = input2
    end
    
    if input3 ~= nil then
        action_data.input3 = input3
    end

    if Config.Debug then

        input1 = input1 or ""
        input2 = input2 or ""
        input3 = input3 or ""

        print("action_executed: ", action, "input1: " .. input1, "input2: " ..  input2, "input3: " ..  input3)
    end

    TriggerServerEvent("tpz_admin:server:performActionByName", action, action_data)
end)


RegisterNUICallback('request_users_refresh_items_list', function()
    LoadItemsListByType(SELECTED_ITEMS_LIST_ACTION_TYPE, nil)
end)

-- @param data.input
RegisterNUICallback('request_users_search_items_list', function(data)
    LoadItemsListByType(SELECTED_ITEMS_LIST_ACTION_TYPE, data.input)
end)

-- @param data.source, data.item, data.label
RegisterNUICallback('request_perform_selected_user_action3', function(data)
    local label, item, source = data.label, data.item, tonumber(data.source)
    
    local action = SELECTED_ITEMS_LIST_ACTION_TYPE

    if action == 'ADDITEM' then 

        ParamRequirements = { [1] = 'INT' }
    
    elseif action == 'ADDWEAPON' then 

        ParamRequirements = { [1] = 'STRING' }
    end

    local param_length = TPZ.GetTableLength(ParamRequirements)

    SendNUIMessage({
        action  = 'OPEN_DIALOG_INPUT',
        source  = source,
        action_type = action,
        locales = Locales,
        title   = label,
        input1_description = (param_length >= 1) and Locales[action .. '_DIALOG_DESCRIPTION'][1] or nil,
        input2_description = nil,
        input3_description = nil,

        placeholder1 = (param_length >= 1) and Locales[action .. '_DIALOG_PLACEHOLDER'][1] or nil,
        placeholder2 = nil,
        placeholder3 = nil,

        input1_type = (param_length >= 1) and ParamRequirements[1] or "STRING",
        input2_type = "STRING",
        input3_type = "STRING",

        item = item,
    })   

    
end)