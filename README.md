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

| Command                  | Ace Permission                     | Description                                                              | Console / TXAdmin Console Support |
|--------------------------|------------------------------------|--------------------------------------------------------------------------|-----------------------------------|
| noclip                   | tpzcore.admin.noclip               | Execute this command for noclip.                                         | No |
| spectate [source]        | tpzcore.admin.spectate             | Execute this command to spectate the selected player.                    | No |
| spectatecancel     | tpzcore.admin.spectatecancel             | Execute this command to cancel spectating players.                    | No |
| freeze [source]          | tpzcore.admin.freeze               | Execute this command to freeze or unfreeze the selected player.          | Yes |
| kick [source] [reason]   | tpzcore.admin.kick                 | Execute this command to kick the selected player from the server.        | Yes |
| ban [source] [reason]    | tpzcore.admin.ban                  | Execute this command to ban the selected player from the server.         | Yes |
| unban [steamHex]         | tpzcore.admin.unban                | Execute this command to unban the selected user from the server.         | Yes |
| warn [source] [reason]   | tpzcore.admin.warn                 | Execute this command to warn the selected player from the server.        | Yes |
| resetwarnings [source]   | tpzcore.admin.reset_warnings       | Execute this command to reset all the warnings from the selected player. | Yes |
| godmode                  | tpzcore.admin.god_mode             | Execute this to enable or disable GOD MODE.                              | No |
| playerblips              | tpzcore.admin.player_blips         | Execute this command to enable or disable player blips on the map.       | No |
| announce                 | tpzcore.admin.announcement         | Execute this command to announce anything to all online players.         | Yes |
| healall                  | tpzcore.admin.heal_all             | Execute this command to heal all the available online players.           | Yes |

- The ace permission: `tpzcore.all` Gives permissioms to all commands and actions (FOR ALL OFFICIAL PUBLISHED FREE SCRIPTS).
- The ace permission: `tpzcore.admin.all` Gives permissions to all commands or actions ONLY for this script.

## Information

- We also provide a DevTools NUI block to be used by players without permissions. The ace permission is: `tpzcore.admin.devtools` or `tpzcore.admin.all`. We also provide the possibility through discord roles and group roles.

## Screenshots

<img width="1183" height="836" alt="image" src="https://github.com/user-attachments/assets/093f4e43-05e6-49f0-aa41-4458c04e1d2e" />
<img width="1712" height="983" alt="image" src="https://github.com/user-attachments/assets/4e40fdd4-f266-416f-a40e-196e78e44ff7" />
<img width="1719" height="981" alt="image" src="https://github.com/user-attachments/assets/ad94c5df-f88b-4717-ad81-33e6788ac532" />
<img width="1718" height="982" alt="image" src="https://github.com/user-attachments/assets/99299f5e-514e-47d8-b17f-42725ccec47d" />
<img width="1719" height="973" alt="image" src="https://github.com/user-attachments/assets/7d1308b4-41ca-4fcd-9df5-176406868818" />
<img width="1719" height="985" alt="image" src="https://github.com/user-attachments/assets/125db2eb-24f8-490c-becc-1690818d692b" />
<img width="1718" height="987" alt="image" src="https://github.com/user-attachments/assets/c2d1008d-353c-49af-b28f-a88f8e69c4ab" />

## Disclaimer & Credits

- DevTools Block snippet code was found and taken from: https://github.com/qamarq/nui_blocker (Our server event has been modified only, client and html are the same as shared to the community).
