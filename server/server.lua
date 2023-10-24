VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi() --still needed?

function CraftItem(source, item)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter

    local recipe = Config.recipes[item]

    if not recipe then
        TriggerClientEvent("vorp:TipRight", source, "This recipe doesn't exist.", 5000)
        return
    end

    
    
    exports.oxmysql:fetch('SELECT xp FROM crafting_xp WHERE charidentifier = ? AND category = ?', {User.identifier, recipe.category}, function(result) -- xp check, not being used yet
        if #result == 0 then
            exports.oxmysql:execute('INSERT INTO crafting_xp (charidentifier, category, xp) VALUES (?, ?, 0)', {User.identifier, recipe.category})--  player not exist then create in table?
        elseif result[1].xp < recipe.xpRequired then
            TriggerClientEvent("vorp:TipRight", source, "You don't have enough XP to craft this item.", 5000)
            return
        end
        
        for ingredient, quantity in pairs(recipe.ingredients) do
            if not Character.inventory:canCarryItem(ingredient, quantity) then
                TriggerClientEvent("vorp:TipRight", source, "You don't have the necessary ingredients.", 5000)
                return
            end
        end


        for ingredient, quantity in pairs(recipe.ingredients) do
            Character.inventory:subItem(ingredient, quantity)
        end
        
        Character.inventory:addItem(item, 1)


        exports.oxmysql:execute('UPDATE crafting_xp SET xp = xp + ? WHERE charidentifier = ? AND category = ?', {recipe.xp, User.identifier, recipe.category}) -- XP stuff still in testing


        TriggerClientEvent("vorp:TipRight", source, "You have crafted a " .. item .. ".", 5000)
    end)
end


RegisterServerEvent("vorp:craftItem")
AddEventHandler("vorp:craftItem", function(item)
    local _source = source

    CraftItem(_source, item)
end)

RegisterNetEvent('getRecipes')
AddEventHandler('getRecipes', function()
    print(" get recipes triggered")  --  print
    local _source = source
    local recipesToSend = Config.recipes

    TriggerClientEvent('receiveRecipes', source, recipesToSend)
end)

RegisterNetEvent('openCraftingMenu2') -- Categories in test
AddEventHandler('openCraftingMenu2', function()
    local categories = {}
    for _, recipe in ipairs(Config.recipes) do
        if not categories[recipe.category] then
            categories[recipe.category] = true
        end
    end
    TriggerClientEvent('receiveCategories', source, categories)
end)
