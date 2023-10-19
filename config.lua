-- config.lua
Config = {}

Config.recipes = {
    -- Example structure:
    -- { name = "ItemName", requiredItems = { {item = "ingredient", quantity = 2}, ... }, xpRequirement = 0, xpReward = 10, craftingTime = 5 },
    { name = "Bread", requiredItems = { {item = "wheat", quantity = 2}, {item = "butter", quantity = 1} }, xpRequirement = 0, xpReward = 10, craftingTime = 5 },
    { name = "Water", requiredItems = { {item = "water_bucket", quantity = 2}, {item = "butter", quantity = 1} }, xpRequirement = 0, xpReward = 0, craftingTime = 3 },
    { name = "berry_juice", requiredItems = { {item = "water_bucket", quantity = 2}, {item = "berries", quantity = 1} }, xpRequirement = 10, xpReward = 25, craftingTime = 3 }
}

Config.Cooks = {
    { name = "AdvancedBread", requiredItems = { {item = "wheat", quantity = 3}, {item = "butter", quantity = 1}, {item = "cheese", quantity = 1} }, xpRequirement = 50, xpReward = 100, craftingTime = 7 }
}

Config.Doctors = {
    { name = "AdvancedMedicine", requiredItems = { {item = "herb", quantity = 3}, {item = "water", quantity = 1} }, xpRequirement = 100, xpReward = 200, craftingTime = 10 }
}
