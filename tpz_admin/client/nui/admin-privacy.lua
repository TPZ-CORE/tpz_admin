local TPZ = exports.tpz_core:getCoreAPI()

local HAS_COOLDOWN = false
local SEARCH_INPUT = nil

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


local RequestHistoryActions = function(selectedPage)

    if HAS_COOLDOWN then return end 

    HAS_COOLDOWN = true

    SendNUIMessage({ action = 'RESET_ADMIN_PRIVACY_LIST' })

    local hasPermission = HasNUIPermissionByName("admin_privacy")

    if not hasPermission then

        SendNUIMessage({
            action        = 'SELECTED_WINDOW_SECTION',
            window        = "admin-privacy-section",
            hasPermission = false,
        })
        
        HAS_COOLDOWN = false

        return
    end


    TriggerEvent("tpz_core:ExecuteServerCallBack", "tpz_admin:getHistoryActions", function(result)

        local count = 0 

        if TPZ.GetTableLength(result) > 0 then

            for _, data in pairs (result) do 

                count = count + 1

                local currentPage = GetPageByIndex(count)
                
                if (currentPage == selectedPage) then

                    data.count = count

                    SendNUIMessage({
                        action = 'ADMIN_PRIVACY_LIST_INSERT',
                        result = data,
    
                    })
                
                end

            end

        end

        local totalPages = GetPageByIndex(count)

        SendNUIMessage({
            action          = 'SELECTED_WINDOW_SECTION',
            window          = "admin-privacy-section",
            hasPermission   = true,
            current_players = TPZ.GetTableLength(result),
            locales         = Locales,
            total_pages     = totalPages,
            selected_page   = selectedPage,
        })    

    end, { searchInput = SEARCH_INPUT })

    Wait(1000)
    HAS_COOLDOWN = false

end

-----------------------------------------------------------
--[[ NUI Callbacks ]]--
-----------------------------------------------------------

RegisterNUICallback('request_admin_history_actions_section', function()
    SEARCH_INPUT = nil
    RequestHistoryActions(1)
end)

-- @data.page
RegisterNUICallback('request_admin_history_actions_section_page', function(data)
    RequestHistoryActions(tonumber(data.page))
end)

-- @data.input 
RegisterNUICallback('request_admin_history_actions_section_search_input', function(data)
    SEARCH_INPUT = data.input 
    RequestHistoryActions(1)
end)
