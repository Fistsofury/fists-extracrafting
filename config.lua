-- config.lua
Config = {}

Config.recipes = {
    --Food
    { 
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

        --add more recipes here
    },
}


