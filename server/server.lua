local VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
    print("VORPcore set:", VORPcore)
end)
--[[
    Still to do
        add a canCarry check
        add animation per crafting time
        remove all debugs
        
]]
VorpInv = exports.vorp_inventory:vorp_inventoryApi() --still needed?

function CraftItem(source, recipe)
 --[[   if not VORPcore then
        print("VORPcore is not initialized")
        return
    end]]

    local User = VORPcore.getUser(source)
    --[[if not User then
        print("User not found")
        return
    end]]

    local Character = User.getUsedCharacter
    --[[if not Character then
        print("Character not found")
        return
    end]]

    local identifier = Character.identifier
    --[[if not identifier then
        print("Character identifier not found")
        return
    end]]

    local charidentifier = Character.charIdentifier

    --print("User identifier:", identifier)
    --print("User charidentifier:", charidentifier)

    if not recipe then
        TriggerClientEvent("vorp:TipRight", source, "This recipe doesn't exist.", 5000)
        return
    end

    exports.oxmysql:fetch('SELECT xp FROM crafting_xp WHERE charidentifier = ? AND category = ?', {charidentifier, recipe.category}, function(result)
        if #result == 0 then
            exports.oxmysql:execute('INSERT INTO crafting_xp (charidentifier, category, xp) VALUES (?, ?, 0)', {charidentifier, recipe.category})
        else
            local xp = result[1].xp
            if xp < recipe.xpRequirement then
                TriggerClientEvent("vorp:TipRight", source, "You don't have enough XP to craft this item.", 5000)
                return
            end
        end

        local missingItems = {}
        for _, ingredientInfo in pairs(recipe.requiredItems) do
            local ingredient = ingredientInfo.item
            local quantity = tonumber(ingredientInfo.quantity)
            local playerItemCount = VorpInv.getItemCount(source, ingredient)
            
            if playerItemCount < quantity then
                table.insert(missingItems, ingredientInfo.label)  
            end
        end

        if #missingItems > 0 then
            local missingItemsStr = table.concat(missingItems, ", ")
            TriggerClientEvent("vorp:TipRight", source, "You are missing the following ingredients: " .. missingItemsStr, 5000)
            return
        end

        -- Add a delay for the crafting time
        Citizen.Wait(recipe.craftingTime * 1000)

        for _, ingredientInfo in pairs(recipe.requiredItems) do
            local ingredient = ingredientInfo.item
            local quantity = tonumber(ingredientInfo.quantity)
            VorpInv.subItem(source, ingredient, quantity)
            print("Item taken", ingredient, quantity)
        end

        VorpInv.addItem(source, recipe.name, 1)
        print("Item Added", recipe.name)
        exports.oxmysql:execute('UPDATE crafting_xp SET xp = xp + ? WHERE charidentifier = ? AND category = ?', {recipe.xpReward, charidentifier, recipe.category})
        TriggerClientEvent("vorp:TipRight", source, "You have crafted a " .. recipe.label .. ".", 5000)  
    end)
end



RegisterServerEvent('fists_crafting:startCraftingAnimation')
AddEventHandler('fists_crafting:startCraftingAnimation', function(duration)
    local _source = source
    TriggerClientEvent('playCraftingAnimation', _source, duration)
end)



RegisterServerEvent("fists_crafting:craftItem1")
AddEventHandler("fists_crafting:craftItem1", function(itemName)
    local _source = source

    local recipe = nil
    for _, r in pairs(Config.recipes) do
        if r.name == itemName then
            recipe = r
            break
        end
    end

    if recipe then
        CraftItem(_source, recipe)
    else
        print("Recipe not found:", itemName)
    end
end)


RegisterNetEvent('fists_crafting:getRecipes')
AddEventHandler('fists_crafting:getRecipes', function()
    --print(" get recipes triggered")  --  print
    local _source = source
    local recipesToSend = Config.recipes

    TriggerClientEvent('fists_crafting:receiveRecipes', source, recipesToSend)
end)

--[[RegisterNetEvent('fists_crafting:openCraftingMenu2') -- Categories in test
AddEventHandler('fists_crafting:openCraftingMenu2', function()
    local categories = {}
    for _, recipe in ipairs(Config.recipes) do
        if not categories[recipe.category] then
            categories[recipe.category] = true
        end
    end
    TriggerClientEvent('fists_crafting:receiveCategories', source, categories)
end)]]
