# TPZ-CORE Admin

## Requirements

1. TPZ-Core: https://github.com/TPZ-CORE/tpz_core
2. TPZ-Characters: https://github.com/TPZ-CORE/tpz_characters
3. TPZ-Inventory: https://github.com/TPZ-CORE/tpz_inventory

# Installation

1. When opening the zip file, open `tpz_admin-main` directory folder and inside there will be another directory folder which is called as `tpz_admin`, this directory folder is the one that should be exported to your resources (The folder which contains `fxmanifest.lua`).

2. Add `ensure tpz_admin` after the **REQUIREMENTS** in the resources.cfg or server.cfg, depends where your scripts are located.

## Commands 

- `@param source` : The source is considered as the online Player ID.
- `@param reason` : Requires the reason when kicking, banning or warning the selected player.

| Command                  | Ace Permission                     | Description                                                              |
|--------------------------|------------------------------------|--------------------------------------------------------------------------|
| menu                     | tpzcore.admin.menu                 | Execute this command to open the Admin Menu.                             |
| noclip                   | tpzcore.admin.noclip               | Execute this command for noclip.                                         |
| spectate [source]        | tpzcore.admin.spectate             | Execute this command to spectate the selected player.                    |
| freeze [source]          | tpzcore.admin.freeze               | Execute this command to freeze or unfreeze the selected player.          |
| kick [source] [reason]   | tpzcore.admin.kick                 | Execute this command to kick the selected player from the server.        |
| ban [source] [reason]    | tpzcore.admin.ban                  | Execute this command to ban the selected player from the server.         |
| warn [source] [reason]   | tpzcore.admin.warn                 | Execute this command to warn the selected player from the server.        |
| resetwarnings [source]   | tpzcore.admin.reset_warnings       | Execute this command to reset all the warnings from the selected player. |
| godmode                  | tpzcore.admin.god_mode             | Execute this to enable or disable GOD MODE.                              |
| playerblips              | tpzcore.admin.player_blips         | Execute this command to enable or disable player blips on the map.       |
| announce                 | tpzcore.admin.announcement         | Execute this command to announce anything to all online players.         |
| healall                  | tpzcore.admin.heal_all             | Execute this command to heal all the available online players.           |

- The ace permission: `tpzcore.all` Gives permissioms to all commands and actions (FOR ALL OFFICIAL PUBLISHED FREE SCRIPTS).
- The ace permission: `tpzcore.admin.all` Gives permissions to all commands or actions ONLY for this script.

## Information

- We also provide a DevTools NUI block to be used by players without permissions. The ace permission is: `tpzcore.admin.devtools` or `tpzcore.admin.all`. We also provide the possibility through discord roles and group roles. 
