-- config.lua
Config = {}

Config.recipes = {
    { name = "consumable_breakfast", category = "Food", requiredItems = { {item = "meat", quantity = 2}, {item = "salt", quantity = 1} }, xpRequirement = 10, xpReward = 0, craftingTime = 5 },
    { name = "Water", category = "Drink", requiredItems = { {item = "water_bucket", quantity = 2}, {item = "butter", quantity = 1} }, xpRequirement = 0, xpReward = 0, craftingTime = 3 },
    { name = "berry_juice", category = "Drink", requiredItems = { {item = "water_bucket", quantity = 2}, {item = "berries", quantity = 1} }, xpRequirement = 10, xpReward = 25, craftingTime = 3 }
}
