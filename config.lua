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
        xpRequirement = 10, --xp required to craft
        xpReward = 0, --xp rewarded for crafting
        craftingTime = 5 --time it takes to craft
    },

    { 
        name = "cookedsmallgame", 
        label = "Seasoned Small Game",  
        category = "Food",  
        requiredItems = { 
            {item = "consumable_game", label = "Raw Game", quantity = 2},  
            {item = "salt", label = "Salt", quantity = 1} 
        }, 
        xpRequirement = 10, 
        xpReward = 0, 
        craftingTime = 5 
    },

    { 
        name = "consumable_applepie", 
        label = "Apple Pie", 
        category = "Food",  
        requiredItems = { 
            {item = "apple", label = "Apple", quantity = 1},  
            {item = "sugar", label = "Sugar", quantity = 1},  
            {item = "flour", label = "Flour", quantity = 1}, 
            {item = "eggs", label = "Eggs", quantity = 1}, 
            {item = "water", label = "Water", quantity = 1} 
        }, 
        xpRequirement = 10, 
        xpReward = 0, 
        craftingTime = 5 
    },

    {
    name = "water", 
    label = "Water",  
    category = "Drink",  
    requiredItems = { 
        {item = "wateringcan", label = "Water Jug", quantity = 1}

    }, 
    xpRequirement = 0, 
    xpReward = 1, 
    craftingTime = 5 
},
{
    name = "consumable_raspberrywater", 
    label = "Berry Water",  
    category = "Drink",  
    requiredItems = { 
        {item = "Red_Raspberry", label = "Red Raspberry", quantity = 2},
        {item = "wateringcan", label = "Water Jug", quantity = 1}

    }, 
    xpRequirement = 40, 
    xpReward = 0, 
    craftingTime = 5 


    
    -- Add more recipes here
}
}
    



