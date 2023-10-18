Config = {}

Config.recipes = {
    -- Item, requirements, Category, Crafting Time
    { item_name = "Bread", Ingredients = { wheat = 2, butter = 1 }, category = "Food", experience = 1, Xp = 0, craftingTime = 5 },
    { item_name = "Bread", Ingredients = { wheat = 2, butter = 1 }, category = "Food", experience = 2, Xp = 10, craftingTime = 5 },
    { item_name = "Water", Ingredients = { water_bucket = 2, butter = 1 }, category = "Drink", experience = 1, Xp = 0, craftingTime = 3 },
    { item_name = "berry_juice", Ingredients = { water_bucket = 2, berries = 1 }, category = "Drink", experience = 2, Xp = 25, craftingTime = 3 },
}

-- Define additional categories or job-specific recipes if needed
Config.Cooks = {
    { item_name = "AdvancedBread", Ingredients = { wheat = 3, butter = 1, cheese = 1 }, category = "Food", experience = 3, Xp = 100, craftingTime = 7 },
}

Config.Doctors = {
    { item_name = "AdvancedBread", Ingredients = { wheat = 3, butter = 1, cheese = 1 }, category = "Medicine", experience = 3, Xp = 100, craftingTime=7 },
}
