Config = {}

Config.DevMode = false

-- The following is only when a notification sent while NUI is open (It has its own notification system).
Config.NotificationColors = { 
    ['error']   = "rgba(255, 0, 0, 0.79)",
    ['success'] = "rgba(0, 255, 0, 0.79)",
    ['info']    = "rgba(102, 178, 255, 0.79)"
}

---------------------------------------------------------------
--[[ General Settings ]]--
---------------------------------------------------------------

-- The maximum server players to be displayed on the online player list.
Config.ServerPlayers = 48

-- When reaching max player warnings, the player will be automatically banned by the system.
-- As default, Max Player Warnings are 4, that means, when player reach 4 warnings, the player will
-- be instantly banned by the system.
Config.MaxPlayerWarnings = 4

Config.DevTools = { -- ace permission: tpzcore.admin.devtools or tpzcore.admin.all
    PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
    PermittedGroups = { 'admin' },
}

Config.AdminMenu = {

    Command = 'admin',
    Suggestion = "Execute this command to open the Admin Menu.",

    PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
    PermittedGroups = { 'admin' },
    
    HistoryActions = {
        PermittedDiscordRoles = { 11111111111111111, 222222222222222222 },
    }
}

Config.Noclip = {
    
    Command = 'noclip',
    Suggestion = "Execute this command for noclip.",

    PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
    PermittedGroups = { 'admin' },

    Speeds = {

       [1] =  { label = 'Very Slow', speed = 0   },
       [2] =  { label = 'Slow',      speed = 0.5 },
       [3] =  { label = 'Normal',    speed = 2   },
       [4] =  { label = 'Fast',      speed = 10  },
       [5] =  { label = 'Very Fast', speed = 15  },
       [6] =  { label = 'Max',       speed = 29  },
    },

    Controls = {

        ['UP']               = 0xD9D0E1C0, -- SPACE BAR
        ['DOWN']             = 0x26E9DC00, -- Z
        ['FORWARD']          = 0x8FD015D8, -- W
        ['SPEED_ADJUSTMENT'] = 0x8FFC75D6, -- L-Shift
        ['CAMERA_MODE']      = 0x24978A28, -- H

    },

    OffsetMultipliers = {
        ['Y'] = 0.2,  -- Forward and backward movement speed multiplier.
        ['Z'] = 0.1,  -- Upward and downward movement speed multiplier.
        ['H'] = 1,    -- Rotation movement speed multiplier.
    },

    Webhooks = { -- IT CAN BE SPAMMABLE IF YOU ARE OR YOUR TEAM USING IT FREQUENTLY.
        Enabled = false, 
        Url = "", 
        Color = 10038562,
    },
}



---------------------------------------------------------------
--[[ Commands ]]--
---------------------------------------------------------------

Config.Permissions = {

    { 
        ActionType = "HEAL", -- DO NOT TOUCH
        Label = "Heal",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false,  -- No command available, TPZ_CORE Commands already contains /heal [id]

        RequiredParameters = false, -- DO NOT TOUCH
    },

    
    { 
        ActionType = "REVIVE", -- DO NOT TOUCH
        Label = "Revive",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false,  -- No command available, TPZ_CORE Commands already contains /revive [id]

        RequiredParameters = false, -- DO NOT TOUCH
    },

    { 
        ActionType = "BRING", -- DO NOT TOUCH
        Label = "Bring the player to your location",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false,  -- No command available, TPZ_CORE Commands already contains /tphere [id]

        RequiredParameters = false, -- DO NOT TOUCH
    },

    { 
        ActionType = "GOTO", -- DO NOT TOUCH
        Label = "Go to (Teleport) the player's location",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },
        
        Command = false, -- No command available, TPZ_CORE Commands already contains /tpto [id]

        RequiredParameters = false, -- DO NOT TOUCH
    },

    { 
        ActionType = "SPECTATE", -- DO NOT TOUCH
        Label = "Spectate",
        
        Suggestion = "Execute this command to spectate the selected player.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'spectate',
        CommandHelpTips = { { name = "Id", help = 'Player ID' } },

        RequiredParameters = false, -- DO NOT TOUCH
    },

    { 
        ActionType = "FREEZE", -- DO NOT TOUCH
        Label = "Freeze or unfreeze the selected player",

        Suggestion = "Execute this command to freeze or unfreeze the selected player.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'freeze',
        CommandHelpTips = { { name = "Id", help = 'Player ID' } },

        RequiredParameters = false, -- DO NOT TOUCH
    },

    { 
        ActionType = "KILL", -- DO NOT TOUCH
        Label = "Kill (Slay)",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available, TPZ_CORE Commands already contains /kill [id]

        RequiredParameters = false, -- DO NOT TOUCH
    },

    { 
        ActionType = "KICK", -- DO NOT TOUCH
        Label = "Kick the selected player from the game",

        Suggestion = "Execute this command to kick the selected player from the server.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'kick',
        CommandHelpTips = { { name = "Id", help = 'Player ID' }, { name = "Reason", help = 'Explain the reason for kicking the specified player.' } },

        RequiredParameters = true, -- DO NOT TOUCH
    },


    { 
        ActionType = "BAN", -- DO NOT TOUCH
        Label = "Ban the selected player and describe the reason",

        Suggestion = "Execute this command to ban the selected player from the server.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'ban',
        CommandHelpTips = { { name = "Id", help = 'Player ID' }, { name = "Duration", help = "The duration of the ban in HOURS (-1 = PERMANENTLY)" }, { name = "Reason", help = 'Explain the reason for banning the specified player.' } },


        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = "UNBAN", -- DO NOT TOUCH
        Label = "Unban the selected user by the steam hex.",

        Suggestion = "Execute this command to unban the selected user from the server.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'unban',
        CommandHelpTips = { { name = "Steam Hex", help = "The user steam hex id." } },

        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = "WARN", -- DO NOT TOUCH
        Label = "Give a warning",

        Suggestion = "Execute this command to warn the selected player.",
        HelpTip    = "Explain the reason for warning the specified player.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'warn',
        CommandHelpTips = { { name = "Id", help = 'Player ID' }, { name = "Reason", help = 'Explain the reason for warning the specified player.' } },

        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = "RESET_WARNINGS", -- DO NOT TOUCH
        Label = "Reset all the warnings from the selected player.",

        Suggestion = "Execute this command to reset all the warnings from the selected player.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'resetwarnings',
        CommandHelpTips = { { name = "Id", help = 'Player ID' } },

        RequiredParameters = false, -- DO NOT TOUCH
    },


    { 
        ActionType = 'SET_JOB', -- DO NOT TOUCH
        Label = "Set current job",
        
        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available, TPZ_CORE Commands already contains /setjob [id] [job] [grade]
    
        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = 'SET_JOB_GRADE', -- DO NOT TOUCH
        Label = "Set current job grade",
        
        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available, TPZ_CORE Commands already contains /setjob [id] [job] [grade]
    
        RequiredParameters = true, -- DO NOT TOUCH
    },


    { 
        ActionType = 'SET_GROUP', -- DO NOT TOUCH
        Label = "Set group",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available, TPZ_CORE Commands already contains /setgroup [id] [group]
   
        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = 'ADD_ACCOUNT', -- DO NOT TOUCH
        Label = "Add account money (currency type)",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available, TPZ_CORE Commands already contains /addaccount [id] [type] [quantity]
   
        RequiredParameters = true, -- DO NOT TOUCH

    },
    
    { 
        ActionType = 'REMOVE_ACCOUNT', -- DO NOT TOUCH
        Label = "Remove account money (currency type)",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available
   
        RequiredParameters = true, -- DO NOT TOUCH

    },
    
    { 
        ActionType = 'GIVE_ITEM_AND_WEAPONS', -- DO NOT TOUCH
        Label = "Give the desired item quantity or a weapon.",
        
        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available, TPZ_CORE Commands already contains /additem [id] [item] [quantity]
    
        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = 'GOD_MODE', -- DO NOT TOUCH (SUPPORTS TPZ_METABOLISM)
        Label = "God Mode",

        Suggestion = "Execute this to enable or disable GOD MODE.",
        
        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command =  'godmode',
    
        RequiredParameters = false, -- DO NOT TOUCH
    },

    -- Player Permitted Actions -- 
    { 
        ActionType = 'PLAYER_BLIPS', -- DO NOT TOUCH
        Label = "Show / Hide the location of all the online players",
        
        Suggestion = "Execute this command to enable or disable player blips on the map.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command =  "playerblips",

        RequiredParameters = false, -- DO NOT TOUCH
    },

    { 
        ActionType = 'ANNOUNCEMENT', -- DO NOT TOUCH
        Label = "Send an announcement to all the online players.",

        Suggestion = "Execute this command to announce anything to all online players.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'announce',
        CommandHelpTips = { { name = "Duration", help = 'Duration in seconds' }, { name = "Announcement", help = 'Announcement' }  },
        
        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = 'TELEPORT_COORDS', -- DO NOT TOUCH
        Label = "Teleport to the selected coords {x,y,z}",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = false, -- No command available, TPZ_CORE Commands already contains /tpcoords [x] [y] [z]
        RequiredParameters = true, -- DO NOT TOUCH
    },

    { 
        ActionType = 'HEAL_ALL', -- DO NOT TOUCH
        Label = "Heal all the available online players.",

        Suggestion = "Execute this command to heal all the available online players.",

        PermittedDiscordRoles  = { 11111111111111111, 222222222222222222 },
        PermittedGroups = { 'admin' },

        Command = 'healall',
        RequiredParameters = false, -- DO NOT TOUCH
    },

}

---------------------------------------------------------------
--[[ Discord Webhooking ]]--
---------------------------------------------------------------

Config.Webhooks = {

    ['COMMANDS'] = {
        
        Enabled = false, 
        Url     =  "",
        Color   = 10038562,

    },

    ['DEVTOOLS'] = {
        Enabled = false, 
        Url     = "",
        Color   = 10038562,
    },
}

-----------------------------------------------------------
--[[ Notification Functions  ]]--
-----------------------------------------------------------

-- @param source is always null when called from client.
-- @param messageType returns "success" or "error" depends when and where the message is sent.
function SendNotification(source, message, messageType)

    if source == nil then -- CLIENT SIDE
        TriggerEvent('tpz_core:sendBottomTipNotification', message, 3000)

    elseif source == 0 then  -- CONSOLE - NO DURATION SUPPORT OR TYPE.
        print(message:gsub("~e~", '^1') .. '^0')
        
    elseif source and source ~= 0 then -- PLAYER OBJECT
        TriggerClientEvent('tpz_core:sendBottomTipNotification', source, message, 3000)
    end
  
end




