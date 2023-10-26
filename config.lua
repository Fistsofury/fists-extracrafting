-- config.lua
Config = {}

Config.recipes = {
    -- Food
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

    { 
        name = "cookedsmallgame", -- db item name
        label = "Seasoned Small Game",  --Label that you want to appear on the menu
        category = "Food",  --what Category, changable to whatever you want
        requiredItems = { 
            {item = "consumable_game", label = "Raw Game", quantity = 2},  
            {item = "salt", label = "Salt", quantity = 1} 
        }, 
        xpRequirement = 10, --Amount of xp needed to craft
        xpReward = 0, --Amount of xp awarded for a succesful craft
        craftingTime = 5 -- time in seconds it takes to craft
    },

    { 
        name = "consumable_applepie", -- db item name
        label = "Apple Pie",  --Label that you want to appear on the menu
        category = "Food",  --what Category, changable to whatever you want
        requiredItems = { 
            {item = "apple", label = "Apple", quantity = 1},  
            {item = "sugar", label = "Sugar", quantity = 1},  
            {item = "flour", label = "Flour", quantity = 1}, 
            {item = "eggs", label = "Eggs", quantity = 1}, 
            {item = "water", label = "Water", quantity = 1} 
        }, 
        xpRequirement = 10, --Amount of xp needed to craft
        xpReward = 0, --Amount of xp awarded for a succesful craft
        craftingTime = 5 -- time in seconds it takes to craft
    },

    {
    name = "water", -- db item name
    label = "Water",  --Label that you want to appear on the menu
    category = "Drink",  --what Category, changable to whatever you want
    requiredItems = { 
        {item = "wateringcan", label = "Water Jug", quantity = 1}

    }, 
    xpRequirement = 0, --Amount of xp needed to craft
    xpReward = 1, --Amount of xp awarded for a succesful craft
    craftingTime = 5 -- time in seconds it takes to craft
},
{
    name = "consumable_raspberrywater", -- db item name
    label = "Berry Water",  --Label that you want to appear on the menu
    category = "Drink",  --what Category, changable to whatever you want
    requiredItems = { 
        {item = "Red_Raspberry", label = "Red Raspberry", quantity = 2},
        {item = "wateringcan", label = "Water Jug", quantity = 1}

    }, 
    xpRequirement = 40, --Amount of xp needed to craft
    xpReward = 0, --Amount of xp awarded for a succesful craft
    craftingTime = 5 -- time in seconds it takes to craft
},


    
    -- Add more recipes here
}

    



