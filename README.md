# fists-extracrafting
fists-extracrafting

# Configurable recipes
- Config to add more recipes

# Config.lua explained
    { 
        name = "consumable_breakfast", -- db item name
        label = "Breakfast",  --Label that you want to appear on the menu
        category = "Food",  --what Category, changable to whatever you want
        requiredItems = { 
            {item = "meat", label = "Meat", quantity = 2},  
            {item = "salt", label = "Salt", quantity = 1} 
        }, 
        xpRequirement = 10, --Amount of xp needed to craft
        xpReward = 0, --Amount of xp awarded for a succesful craft
        craftingTime = 5 -- time in seconds it takes to craft
    },

# XP based crafting script
- XP is based on Category example if you craft breakfast you will only earn xp in the Food Category, and XP earnt & XP required can be configured in the config.

# Crafting recipes - Credits
- existing recipes have been taken from Vorp-crafting https://github.com/VORPCORE/vorp_crafting