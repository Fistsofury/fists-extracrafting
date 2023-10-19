VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

-- Crafting function
function CraftItem(source, item)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter

    -- Check if the player has a job-specific recipe or use a general recipe
    local recipe = Config.recipes[item]

    -- Check if the recipe exists
    if not recipe then
        TriggerClientEvent("vorp:TipRight", source, "This recipe doesn't exist.", 5000)
        return
    end

    -- Check if the player has enough XP and the necessary ingredients in their inventory...
    
    exports.oxmysql:fetch('SELECT xp FROM crafting_xp WHERE charidentifier = ? AND category = ?', {User.identifier, recipe.category}, function(result)
        if #result == 0 then
            -- Player does not exist in the table, create them with an XP value of 0
            exports.oxmysql:execute('INSERT INTO crafting_xp (charidentifier, category, xp) VALUES (?, ?, 0)', {User.identifier, recipe.category})
        elseif result[1].xp < recipe.xpRequired then
            TriggerClientEvent("vorp:TipRight", source, "You don't have enough XP to craft this item.", 5000)
            return
        end

        -- player has the necessary ingredients
        
        for ingredient, quantity in pairs(recipe.ingredients) do
            if not Character.inventory:canCarryItem(ingredient, quantity) then
                TriggerClientEvent("vorp:TipRight", source, "You don't have the necessary ingredients.", 5000)
                return
            end
        end

        -- remove ingredients from the player's inventory and add the crafted item

        for ingredient, quantity in pairs(recipe.ingredients) do
            Character.inventory:subItem(ingredient, quantity)
        end
        
        Character.inventory:addItem(item, 1)

        

        -- Add XP to the player's job category in the database...

        exports.oxmysql:execute('UPDATE crafting_xp SET xp = xp + ? WHERE charidentifier = ? AND category = ?', {recipe.xp, User.identifier, recipe.category})

        -- Send a success message to the player...

        TriggerClientEvent("vorp:TipRight", source, "You have crafted a " .. item .. ".", 5000)
    end)
end

-- Event handler for crafting items...

RegisterServerEvent("vorp:craftItem")
AddEventHandler("vorp:craftItem", function(item)
    local _source = source

    CraftItem(_source, item)
end)

-- Event handler for getting recipes
RegisterServerEvent('getRecipes')
AddEventHandler('getRecipes', function()
    local _source = source
    -- Send the recipes to the client
    print("Sending recipes")
    TriggerClientEvent('receiveRecipes', _source, Config.recipes)

end)

RegisterNetEvent('getCraftingRecipes')
AddEventHandler('getCraftingRecipes', function()
    -- Fetch player's job (as an example; integrate with your job system)
    local playerJob = getPlayerJob(source)  -- Assuming a function exists for this

    local recipesToSend = Config.recipes
    if playerJob == "Cook" then
        recipesToSend = recipesToSend + Config.Cooks
    elseif playerJob == "Doctor" then
        recipesToSend = recipesToSend + Config.Doctors
    end

    TriggerClientEvent('receiveCraftingRecipes', source, recipesToSend)
end)
