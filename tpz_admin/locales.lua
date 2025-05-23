Locales = {}

Locales = {
    ['UP_AND_DOWN']                                     = 'UP - DOWN',
    ['LEFT_TURN']                                       = 'LEFT_TURN',
    ['RIGHT_TURN']                                      = 'RIGHT_TURN',
    ['FORWARD']                                         = 'FORWARD',
    ['SPEED_ADJUSTMENT']                                = 'CHANGE SPEED ADJUSTMENT',
    ['CAMERA_MODE']                                     = 'CAMERA_MODE',

    ['NO_CLIP_DESCRIPTION']                             = "No Clip | Speed Type: %s, Speed: %s",

    ['KICK_INPUT_TITLE']                                = 'Kick Reason',
    ['KICK_INPUT_DESCRIPTION']                          = 'Describe the reason for kicking the selected player.',

    ['WARN_INPUT_TITLE']                                = 'Warn Reason',
    ['WARN_INPUT_DESCRIPTION']                          = 'Describe the reason for warning the selected player (If the player reach the maximum warnings, the player will be automatically banned).',

    ['SET_JOB_INPUT_TITLE']                             = 'Set Job',
    ['SET_JOB_INPUT_DESCRIPTION']                       = 'Set the job name on the selected player {police, medic, blacksmith. etc}.',

    ['SET_JOB_GRADE_INPUT_TITLE']                       = 'Set Job Grade',
    ['SET_JOB_GRADE_INPUT_DESCRIPTION']                 = 'Set the job grade on the selected player {numbers only}.',

    ['SET_GROUP_INPUT_TITLE']                           = 'Set Group',
    ['SET_GROUP_INPUT_DESCRIPTION']                     = 'Set the group on the selected player {admin, mod, vip, etc.}.',

    ['ADD_ACCOUNT_INPUT_TITLE']                         = "Add Money Account",
    ['ADD_ACCOUNT_INPUT_DESCRIPTION']                   = 'Select the account type to be given on the selected player.',
    ['ADD_ACCOUNT_INPUT_DESCRIPTION2']                  = 'Select the amount to be given on the selected player.',

    ['REMOVE_ACCOUNT_INPUT_TITLE']                      = "Remove Money Account",
    ['REMOVE_ACCOUNT_INPUT_DESCRIPTION']                = 'Select the account type to be removed from the selected player.',
    ['REMOVE_ACCOUNT_INPUT_DESCRIPTION2']               = 'Select the amount to be removed from the selected player.',

    ['BAN_INPUT_TITLE']                                 = "Ban Selected Player (User)",
    ['BAN_INPUT_DESCRIPTION']                           = 'Describe the reason before banning permanently the selected player.',

    ['UNBAN_INPUT_TITLE']                               = "Unban Selected Player (User)",
    ['UNBAN_INPUT_DESCRIPTION']                         = 'Would you like to remove the permanent ban from %s ?',

    ['TELEPORT_COORDS_INPUT_TITLE']                     = "Teleport to the selected coords",
    ['TELEPORT_COORDS_INPUT_DESCRIPTION']               = 'Use "," after every parameter, for example, x,y,z without any spaces in between.',

    ['GIVE_ITEM_AND_WEAPONS_INPUT_DESCRIPTION']         = 'How many would you like to give on the selected player?',

    ['INPUT_ACCEPT_BUTTON']                             = 'ACCEPT',
    ['INPUT_DECLINE_BUTTON']                            = 'CANCEL',

    ['HEALED_SELECTED_PLAYER']                          = "You have succesffully healed the selected player.",
    ['REVIVED_SELECTED_PLAYER']                         = "You have succesffully revived the selected player.",
    ['BROUGHT_SELECTED_PLAYER']                         = "You have succesffully brought the selected player to your location.",
    ['GOTO_SELECTED_PLAYER']                            = "You have been teleported to the selected player location.",
    ['KILLED_SELECTED_PLAYER']                          = "You have succesffully killed (slayed) the selected player.",
    ['FREEZE_TRUE']                                     = "The selected player is now frozen.",
    ['FREEZE_FALSE']                                    = "The selected player is no longer frozen.",
    
    ['WARNING_SENT']                                    = "A warning has been succesffully sent to the selected player.",
    ['WARNINGS_RESET']                                  = "You have successfully reset all the warnings from the selected player.",
    ['SET_GROUP_SELECTED_PLAYER']                       = "You have succesffully set the selected player group to: %s.",
    ['SET_JOB_SELECTED_PLAYER']                         = "You have succesffully set the selected player job to: %s",
    ['SET_JOB_GRADE_SELECTED_PLAYER']                   = "You have succesffully set the selected player job grade to: %s",
    ['ADD_ACCOUNT_SELECTED_PLAYER']                     = "You added %s %s on the selected player.",
    ['REMOVE_ACCOUNT_SELECTED_PLAYER']                  = "You removed %s %s from the selected player.",
    ['BANNED_SELECTED_PLAYER']                          = "You have succesffully banned the selected player.",
    ['BANNED_SELECTED_PLAYER_REACHED_WARNINGS']         = "The selected player has been banned from the server by reaching the maximum warnings.",
    ['BAN_REASON_REACHED_MAXIMUM_WARNINGS_DESCRIPTION'] = "You have reached maximum server warnings.",
    ['BAN_REASON_DESCRIPTION']                          = "You have been banned for the following reason: %s.",

    ['ADDED_ITEM_ON_SELECTED_PLAYER']                   = "You succesffully gave X%s %s.",
    ['ADDED_WEAPON_ON_SELECTED_PLAYER']                 = "You succesffully gave X1 %s.",

    ['GOD_MODE_TRUE']                                   = "The selected player is now in GOD Mode.",
    ['GOD_MODE_FALSE']                                  = "The selected player is no longer in GOD Mode.",

    ['PLAYER_BLIPS_TRUE']                               = "All online players are now visible.",
    ['PLAYER_BLIPS_FALSE']                              = "All online players are no longer visible.",

    ['HEAL_ACTION_DESCRIPTION']                         = "The specified user healed the player with the username: %s",
    ['REVIVED_ACTION_DESCRIPTION']                      = "The specified user revived the player with the username: %s",
    ['BRING_ACTION_DESCRIPTION']                        = "The specified user brought (teleported onself) the player with the username: %s",
    ['GOTO_ACTION_DESCRIPTION']                         = "The specified user teleported on the player's location with the username: %s",
    ['KILL_ACTION_DESCRIPTION']                         = "The specified user killed (slayed) the player with the username: %s",
    ['FREEZE_ACTION_DESCRIPTION']                       = "The specified user froze - unfroze the player with the username: %s",
    ['KICK_ACTION_DESCRIPTION']                         = "The specified user kicked the player with the username: %s and the reason was: %s",
    ['BAN_ACTION_DESCRIPTION']                          = "The specified user banned the player with the username: %s and the reason was: %s",
    ['REMOVE_WARNINGS_ACTION_DESCRIPTION']              = "The specified user removed (cleaned) all the warnings from the player with the username: %s",
    ['WARN_ACTION_DESCRIPTION']                         = "The specified user warned the player with the username: %s and the reason was: %s",
    ['WARN_BAN_ACTION_DESCRIPTION']                     = "The specified user warned the player with the username: %s and got banned for reaching the maximum warnings, warning reason was: %s",
    ['SET_JOB_ACTION_DESCRIPTION']                      = "The specified user changed the player job with the username: %s to job: %s",
    ['SET_JOB_GRADE_ACTION_DESCRIPTION']                = "The specified user changed the player job grade with the username: %s to job grade: %s",
    ['SET_GROUP_ACTION_DESCRIPTION']                    = "The specified user changed the player group with the username: %s to group: %s",
    ['ADD_ACCOUNT_ACTION_DESCRIPTION']                  = "The specified user added %s %s on the player with the username: %s.",
    ['REMOVE_ACCOUNT_ACTION_DESCRIPTION']               = "The specified user removed %s %s from the player account with the username: %s",
    ['ADD_ITEM_ACTION_DESCRIPTION']                     = "The specified user gave X%s %s to the player with the username: %s",
    ['ADD_WEAPON_ACTION_DESCRIPTION']                   = "The specified user gave a %s (Weapon) to the player with the username: %s",
    ['HEAL_ALL_ACTION_DESCRIPTION']                     = "The specified user healed all the players.",
    ['TELEPORT_COORDS_ACTION_DESCRIPTION']              = "The specified user has been teleported to: x: %s, y: %s, z: %s.",
    ['GOD_MODE_ACTION_DESCRIPTION']                     = "The specified user activated - deactivated GOD Mode on the selected player with the username: %s",
    ['UNBANNED_SELECTED_PLAYER']                        = "You have successfully unbanned %s.",
    ['KICKED_SELECTED_PLAYER']                          = "You have succesffully kicked the selected player.",

    ['NOT_PERMITTED']                                   = "~e~You have insufficient permissions.",
    ['CANNOT_CARRY_ITEM']                               = "The selected player cannot carry the specified item quantity.",
    ['CANNOT_CARRY_WEAPON']                             = "The selected player cannot carry the specified weapon",
    ['INVALID_SELECTED_PLAYER_CHARACTER']               = "Invalid selected player character.",
    ['INVALID_QUANTITY_INPUT']                          = "Invalid quantity input",

    ['NOT_ONLINE']                                      = "~e~Player is not online.",
    ['PLAYER_IS_ON_SESSION']                            = "~e~You can't perform this action, the player is on session.",

    ['HEALED_ALL_PLAYERS']                              = "All online players have been healed.",
    ['TARGET_HEALED']                                   = "You have been healed.",
    
}
