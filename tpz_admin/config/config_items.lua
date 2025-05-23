Items = {}

-- The following option @Items.ItemsList is used for displaying and giving ONLY items or weapons
-- which belong to the list below.

-- The reason is because a server, can have a huge database of items and its using only the 30% of them.
-- (!) You can create as many categories you want, there is no limitation.

-- By default, i have added as many items and categories as possible.

Items.ItemsListCategories = {
    'ALL', -- By default, displaying all the items - (DO NOT REMOVE OR CHANGE ITS POSITION, RENAME ONLY) !!
    'FOOD',
    'CONSUMABLES',
    'ORES',
    'TOOLS',
    'AMMUNITION', 
    'WEAPONS', 
}

Items.ItemsList = {

    ------------------------------------------------------------------------
    -- ORES CATEGORY
    ------------------------------------------------------------------------

    { Name = 'diamond',       Label = 'Diamonds',            Category = 'ORES' },
    { Name = 'platinum',      Label = 'Platinum',            Category = 'ORES' },

    { Name = 'goldcoin',      Label = 'Gold Coins',          Category = 'ORES' },
    { Name = 'goldbar',       Label = 'Gold Bars',           Category = 'ORES' },
    { Name = 'goldnugget',    Label = 'Gold Nuggets',        Category = 'ORES' },
    { Name = 'goldfragment',  Label = 'Gold Fragments',      Category = 'ORES' },
    { Name = 'goldbracelet',  Label = 'Gold Bracelet',       Category = 'ORES' },
    { Name = 'goldnecklace',  Label = 'Gold Necklace',       Category = 'ORES' },
    { Name = 'goldring',      Label = 'Gold Ring',           Category = 'ORES' },
    { Name = 'goldtooth',     Label = 'Gold Tooth',          Category = 'ORES' },

    { Name = 'silver',        Label = 'Silver',              Category = 'ORES' },

    { Name = 'iron',          Label = 'Iron Ingots',         Category = 'ORES' },
    { Name = 'ironbar',       Label = 'Iron Bars',           Category = 'ORES' },

    { Name = 'copper',        Label = 'Copper',              Category = 'ORES' },
    { Name = 'salt',          Label = 'Salt',                Category = 'ORES' },
    { Name = 'coal',          Label = 'Coal',                Category = 'ORES' },
    { Name = 'clay',          Label = 'Clay',                Category = 'ORES' },
    { Name = 'sulfur',        Label = 'Sulfur',              Category = 'ORES' },

    { Name = 'rock',          Label = 'Rocks',               Category = 'ORES' },

    ------------------------------------------------------------------------
    -- TOOLS CATEGORY
    ------------------------------------------------------------------------

    { Name = "pickaxe",       Label = 'Pickaxe',             Category = 'TOOLS' },
    { Name = "shovel",        Label = 'Shovel',              Category = 'TOOLS' },
    { Name = "hoe",           Label = 'Hoe',                 Category = 'TOOLS' },
    { Name = "hatchet",       Label = 'Hatchet',             Category = 'TOOLS' },
    { Name = "goldpan",       Label = 'Gold Pan',            Category = 'TOOLS' },
    { Name = "hardlockpick",  Label = 'Advanced Lockpick',   Category = 'TOOLS' },
    { Name = "lockpick",      Label = 'Lockpick',            Category = 'TOOLS' },

    ------------------------------------------------------------------------
    -- CONSUMABLES CATEGORY
    ------------------------------------------------------------------------
    { Name = "consumable_water_bottle",      Label = 'Water Bottle',        Category = 'CONSUMABLES' },
    { Name = "consumable_coffee",            Label = 'Coffee',              Category = 'CONSUMABLES' },
    { Name = "consumable_rum",               Label = 'Rum',                 Category = 'CONSUMABLES' },
    { Name = "consumable_beer",              Label = 'Beer',                Category = 'CONSUMABLES' },
    { Name = "consumable_wine",              Label = 'Wine',                Category = 'CONSUMABLES' },
    { Name = "consumable_vodka",             Label = 'Vodka',               Category = 'CONSUMABLES' },
    { Name = "consumable_tequila",           Label = 'Tequila',             Category = 'CONSUMABLES' },
    { Name = "consumable_whiskey",           Label = 'Whiskey',             Category = 'CONSUMABLES' },
    { Name = "consumable_scotch_whiskey",    Label = 'Scotch Whiskey',      Category = 'CONSUMABLES' },
    { Name = "consumable_champagne",         Label = 'Champagne',           Category = 'CONSUMABLES' },
    { Name = "consumable_moonshine",         Label = 'Moonshine',           Category = 'CONSUMABLES' },
    { Name = "consumable_moonshine_beer",    Label = 'Moonshine Beer',      Category = 'CONSUMABLES' },
    { Name = "consumable_moonshine_wine",    Label = 'Moonshine Wine',      Category = 'CONSUMABLES' },
    { Name = "consumable_moonshine_rum",     Label = 'Moonshine Rum',       Category = 'CONSUMABLES' },
    { Name = "consumable_moonshine_tequila", Label = 'Moonshine Tequila',   Category = 'CONSUMABLES' },
    { Name = "consumable_moonshine_whiskey", Label = 'Moonshine Whiskey',   Category = 'CONSUMABLES' },
    { Name = "consumable_saltybottle",       Label = 'Salted Water Bottle', Category = 'CONSUMABLES' },
    { Name = "consumable_milk_bottle",       Label = 'Milk Bottle',         Category = 'CONSUMABLES' },
    { Name = "consumable_antibiotics",       Label = 'Antibiotics',         Category = 'CONSUMABLES' },
    { Name = "consumable_herbal_tea",        Label = 'Natives Herbal Tea',  Category = 'CONSUMABLES' },
    { Name = "consumable_wolfspirit",        Label = 'Wolf Spirit',         Category = 'CONSUMABLES' },
    { Name = "consumable_bearspirit",        Label = 'Bear Spirit',         Category = 'CONSUMABLES' },

    ------------------------------------------------------------------------
    -- FOOD CATEGORY
    ------------------------------------------------------------------------

    --{ Label = 'Bear Spirit',         Category = 'FOOD' },

    { Name = "potato",                    Label = 'Potato',              Category = 'FOOD' },
    { Name = "Parasol_Mushroom",          Label = 'Parasol Mushroom',    Category = 'FOOD' },
    { Name = "consumable_tomato",         Label = 'Tomato',              Category = 'FOOD' },
    { Name = "Wild_Carrot",               Label = 'Wild Carrot',         Category = 'FOOD' },
    { Name = "onion",                     Label = 'Onion',               Category = 'FOOD' },
    { Name = "corn",                      Label = 'Corn',                Category = 'FOOD' },
    { Name = "Crows_Garlic",              Label = 'Garlic',              Category = 'FOOD' },

    { Name = "consumable_pear",           Label = 'Pear',                Category = 'FOOD' },
    { Name = "consumable_strawberry",     Label = 'Strawberry',          Category = 'FOOD' },
    { Name = "consumable_grapes",         Label = 'Grapes',              Category = 'FOOD' },
    { Name = "apple",                     Label = 'Apple',               Category = 'FOOD' },
    { Name = "consumable_watermelon",     Label = 'Watermelon',          Category = 'FOOD' },
    { Name = "consumable_coconut",        Label = 'Coconut',             Category = 'FOOD' },

    ------------------------------------------------------------------------
    -- AMMUNITION CATEGORY
    ------------------------------------------------------------------------

    { Name = "ammoarrmownormal",          Label = 'Arrow Normal',              Category = 'AMMUNITION' },
    { Name = "ammoarrowdynamite",         Label = 'Arrow Dynamite',            Category = 'AMMUNITION' },
    { Name = "ammoarrowfire" ,            Label = 'Arrow Fire',                Category = 'AMMUNITION' },
    { Name = "ammoarrowimproved",         Label = 'Arrow Improved',            Category = 'AMMUNITION' },
    { Name = "ammoarrownormal",           Label = 'Arrow Normal',              Category = 'AMMUNITION' },
    { Name = "ammoarrowpoison",           Label = 'Arrow Poison',              Category = 'AMMUNITION' },
    { Name = "ammoarrowsmallgame",        Label = 'Arrow Small Game',          Category = 'AMMUNITION' },

    { Name = "ammopistolexplosive",       Label = 'Pistol Ammo Explosive',     Category = 'AMMUNITION' },
    { Name = "ammopistolexpress",         Label = 'Pistol Ammo Express',       Category = 'AMMUNITION' },
    { Name = "ammopistolnormal",          Label = 'Pistol Ammo Normal',        Category = 'AMMUNITION' },
    { Name = "ammopistolsplitpoint",      Label = 'Pistol Ammo Splitpoint',    Category = 'AMMUNITION' },
    { Name = "ammopistolvelocity",        Label = 'Pistol Ammo Velocity',      Category = 'AMMUNITION' },

    { Name = "ammorepeaterexplosive",     Label = 'Repeater Ammo Explosive',   Category = 'AMMUNITION' },
    { Name = "ammorepeaterexpress",       Label = 'Repeater Ammo Express',     Category = 'AMMUNITION' },
    { Name = "ammorepeaternormal",        Label = 'Repeater Ammo Normal',      Category = 'AMMUNITION' },
    { Name = "ammorepeatersplitpoint",    Label = 'Repeater Ammo Splitpoint',  Category = 'AMMUNITION' },
    { Name = "ammorepeatervelocity",      Label = 'Repeater Ammo Velocity',    Category = 'AMMUNITION' },

    { Name = "ammorevolverexplosive",     Label = 'Revolver Ammo Explosive',   Category = 'AMMUNITION' },
    { Name = "ammorevolverexpress",       Label = 'Revolver Ammo Express',     Category = 'AMMUNITION' },
    { Name = "ammorevolvernormal",        Label = 'Revolver Ammo Normal',      Category = 'AMMUNITION' },
    { Name = "ammorevolversplitpoint",    Label = 'Revolver Ammo Splitpoint',  Category = 'AMMUNITION' },
    { Name = "ammorevolvervelocity",      Label = 'Revolver Ammo Velocity',    Category = 'AMMUNITION' },

    { Name = "ammorifleexplosive",        Label = 'Rifle Ammo Explosive',      Category = 'AMMUNITION' },
    { Name = "ammorifleexpress",          Label = 'Rifle Ammo Express',        Category = 'AMMUNITION' },
    { Name = "ammoriflenormal",           Label = 'Rifle Ammo Normal',         Category = 'AMMUNITION' },
    { Name = "ammoriflesplitpoint",       Label = 'Rifle Ammo Splitpoint',     Category = 'AMMUNITION' },
    { Name = "ammoriflevelocity",         Label = 'Rifle Ammo Velocity',       Category = 'AMMUNITION' },

    { Name = "ammoshotgunexplosive",      Label = 'Shotgun Ammo Explosive',    Category = 'AMMUNITION' },
    { Name = "ammoshotgunincendiary",     Label = 'Shotgun Ammo Incendiary',   Category = 'AMMUNITION' },
    { Name = "ammoshotgunnormal",         Label = 'Shotgun Ammo Normal',       Category = 'AMMUNITION' },
    { Name = "ammoshotgunslug",           Label = 'Shotgun Ammo Slug',         Category = 'AMMUNITION' },

    { Name = "ammovarmint",               Label = 'Varmint Ammo',              Category = 'AMMUNITION' },
    { Name = "ammovarminttranq",          Label = 'Varmint Tranquilizer Ammo', Category = 'AMMUNITION' },

    { Name = "ammovoldynamite",           Label = 'Volatile Dynamite Ammo',    Category = 'AMMUNITION' },
    { Name = "ammovolmolotov",            Label = 'Volatile Molotov Ammo',     Category = 'AMMUNITION' },

    { Name = "ammotomahawk",              Label = 'Tomahawk Ammo',             Category = 'AMMUNITION' },
    { Name = "ammobolahawk",              Label = 'Bola Ammo Hawk',            Category = 'AMMUNITION' },
    { Name = "ammobolainterwired",        Label = 'Bola Ammo Interwired',      Category = 'AMMUNITION' },
    { Name = "ammobolaironspiked",        Label = 'Bola Ammo Ironspiked',      Category = 'AMMUNITION' },
    { Name = "ammobolla",                 Label = 'Bola Ammo',                 Category = 'AMMUNITION' },
    { Name = "ammomolotov",               Label = 'Molotov Ammo Spirit',       Category = 'AMMUNITION' },
    { Name = "ammoknives",                Label = 'Knives Ammo',               Category = 'AMMUNITION' },
    { Name = "ammoelephant",              Label = 'Elephant Rifle Ammo',       Category = 'AMMUNITION' },
    { Name = "ammodynamite",              Label = 'Dynamite Ammo',             Category = 'AMMUNITION' },

    ------------------------------------------------------------------------
    -- WEAPONS CATEGORY ( ! WEAPONS MUST HAVE UPPERCASE LETTERS ! )
    ------------------------------------------------------------------------

    { Name = "WEAPON_MELEE_KNIFE",                Label = 'Knife',                       Category = 'WEAPONS' },
    { Name = "WEAPON_MELEE_KNIFE_HORROR",         Label = 'Horror Knife',                Category = 'WEAPONS' },
    { Name = "WEAPON_MELEE_KNIFE_RUSTIC",         Label = 'Rustic Knife',                Category = 'WEAPONS' },
    { Name = "WEAPON_MELEE_KNIFE_JAWBONE",        Label = 'Jawbone Knife',               Category = 'WEAPONS' },
    { Name = "WEAPON_MELEE_MACHETE",              Label = 'Machete',                     Category = 'WEAPONS' },
  
    { Name = "WEAPON_BOW",                        Label = 'Bow',                         Category = 'WEAPONS' },
    { Name = "WEAPON_BOW_IMPROVED",               Label = 'Improved Bow',                Category = 'WEAPONS' },
   
    { Name = "WEAPON_RIFLE_VARMINT",              Label = 'Varmint Rifle',               Category = 'WEAPONS' },
    { Name = "WEAPON_RIFLE_SPRINGFIELD",          Label = 'Springfield Rifle',           Category = 'WEAPONS' },
    { Name = "WEAPON_RIFLE_BOLTACTION",           Label = 'Bolt-Action Rifle',           Category = 'WEAPONS' },
  
    { Name = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK",   Label = 'Rollingblock Sniper Rifle',   Category = 'WEAPONS' },
    { Name = "WEAPON_SNIPERRIFLE_CARCANO",        Label = 'Carcano Sniper Rifle',        Category = 'WEAPONS' },
    
    { Name = "WEAPON_REPEATER_WINCHESTER",        Label = 'Winchester Repeater',         Category = 'WEAPONS' },
    { Name = "WEAPON_REPEATER_HENRY",             Label = 'Henry Repeater',              Category = 'WEAPONS' },
    { Name = "WEAPON_REPEATER_EVANS",             Label = 'Evans Repeater',              Category = 'WEAPONS' },
    { Name = "WEAPON_REPEATER_CARBINE",           Label = 'Carbine Repeater',            Category = 'WEAPONS' },
    
    { Name = "WEAPON_PISTOL_SEMIAUTO",            Label = 'Semi-Auto Pistol',            Category = 'WEAPONS' },
    { Name = "WEAPON_PISTOL_VOLCANIC",            Label = 'Volcanic Pistol',             Category = 'WEAPONS' },
    { Name = "WEAPON_PISTOL_M1899",               Label = 'M1899 Pistol',                Category = 'WEAPONS' },
    
    { Name = "WEAPON_REVOLVER_DOUBLEACTION",      Label = 'Double-Action Revolver',      Category = 'WEAPONS' },
    { Name = "WEAPON_REVOLVER_CATTLEMAN",         Label = 'Cattleman Revolver',          Category = 'WEAPONS' },
    { Name = "WEAPON_REVOLVER_NAVY",              Label = 'Navy Revolver',               Category = 'WEAPONS' },

    { Name = "WEAPON_SHOTGUN_SEMIAUTO",           Label = 'Semi-Auto Shotgun',           Category = 'WEAPONS' },
    { Name = "WEAPON_SHOTGUN_SAWEDOFF",           Label = 'Sawedoff Shotgun',            Category = 'WEAPONS' },
    { Name = "WEAPON_SHOTGUN_REPEATING",          Label = 'Repeating Shotgun',           Category = 'WEAPONS' },
    { Name = "WEAPON_SHOTGUN_PUMP",               Label = 'Pump Shotgun',                Category = 'WEAPONS' },
    { Name = "WEAPON_SHOTGUN_DOUBLEBARREL",       Label = 'Double-Barrel Shotgun',       Category = 'WEAPONS' },
    
    { Name = "WEAPON_THROWN_TOMAHAWK",            Label = 'Thrown Tomahawk',             Category = 'WEAPONS' },
    { Name = "WEAPON_THROWN_THROWING_KNIVES",     Label = 'Throwing Knives',             Category = 'WEAPONS' },
   
    { Name = "WEAPON_LASSO",                      Label = 'Lasso',                       Category = 'WEAPONS' },
    

    ------------------------------------------------------------------------
    -- ALL (NO CATEGORY)
    ------------------------------------------------------------------------

    { Name = "weapon_stock",          Label = 'Weapon Stock',        Category = 'N/A' },
    { Name = "weapon_barrel",         Label = 'Weapon Barrel',       Category = 'N/A' },
    { Name = "weapon_screws",         Label = 'Weapon Screws',       Category = 'N/A' },
    { Name = "weapon_spring",         Label = 'Weapon Spring',       Category = 'N/A' },
    { Name = "weapon_trigger",        Label = 'Weapon Trigger',      Category = 'N/A' },
    { Name = "weapon_cylinder",       Label = 'Weapon Cylinder',     Category = 'N/A' },


    { Name = "trap_bird",             Label = 'Bird Trap',           Category = 'N/A' },
    { Name = "trap_crab",             Label = 'Crab Trap',           Category = 'N/A' },
    { Name = "trap_fish",             Label = 'Fish Trap',           Category = 'N/A' },
    { Name = "trap_reptile",          Label = 'Reptiles Trap',       Category = 'N/A' },
    { Name = "trap_smallanimal",      Label = 'Small Animals Trap',  Category = 'N/A' },

    { Name = "mydog_whistle",         Label = 'Dog Whistle',         Category = 'N/A' },
    { Name = "pipe",                  Label = 'Pipe',                Category = 'N/A' },
    { Name = "cigar",                 Label = 'Cigar',               Category = 'N/A' },
    { Name = "cigarette",             Label = 'Cigarette',           Category = 'N/A' },
    { Name = "cigarettepack",         Label = 'Cigarettes Pack',     Category = 'N/A' },
    { Name = "joint",                 Label = 'Joint',               Category = 'N/A' },
    { Name = "drug_joint",            Label = 'Joint',               Category = 'N/A' },
    { Name = "pipepeace",             Label = 'Pipe Of Peace',       Category = 'N/A' },
    { Name = "pen",                   Label = 'Pen',                 Category = 'N/A' },
    { Name = "paper",                 Label = 'Paper',               Category = 'N/A' },
    { Name = "campfire",              Label = 'Campfire',            Category = 'N/A' },
}