
---------------------------------------------------------------
--[[ NUI PERMISSIONS ]]--
---------------------------------------------------------------

Config.NUIPermissions = {

    -- If there is an action on a player (ban, kick, addaccount, freeze, etc) and the player SOMEHOW did this action and is not listed below,
    -- the system will consider it as Injection / DevTools.
    ['USERS_LIST'] = { -- tpzcore.admin.users_list ace permission for opening the online players list section.
        PermittedDiscordRoles  = { 670899926783361024, 1174077274153299988, 709868210366840835, 830720264757182504 },
        PermittedGroups = { 'admin', 'mod' },
    },

    ['ADMIN_PRIVACY'] = { -- tpzcore.admin.admin_privacy ace permission for opening the admin privacy section.
        PermittedDiscordRoles  = { 670899926783361024, 1174077274153299988},
        PermittedGroups =  { 'admin', 'mod' },
    },

    ['BANS'] = { -- tpzcore.admin.bans ace permission for opening the bans management section.
        PermittedDiscordRoles  = { 670899926783361024, 1174077274153299988},
        PermittedGroups =  { 'admin', 'mod' },
    },
    
    ['TICKETS'] = { -- tpzcore.admin.tickets ace permission for opening the bans management section.
        PermittedDiscordRoles  = { 670899926783361024, 1174077274153299988},
        PermittedGroups =  { 'admin', 'mod' },
    },


}

---------------------------------------------------------------
--[[ ADMIN PRIVACY SECTION ]]--
---------------------------------------------------------------

-- After how many days should an admin action be automatically removed by the system?
Config.DeleteHistoryActionAfter = 3 -- time in days.

-- After how many days should a created ticket be automatically removed by the system?
Config.DeleteTicketAfter = 3 -- time in days.

---------------------------------------------------------------
--[[ Tickets ]]--
---------------------------------------------------------------

Config.CreateTicket = {
    
    Enabled = true,

    Command = 'createticket',
    Suggestion = "Execute this command to create a ticket for the administration.",
}