-- Event handler for opening the crafting menu
RegisterNetEvent('openCraftingMenu')
AddEventHandler('openCraftingMenu', function()

    local playerCoords = GetEntityCoords(PlayerPedId())
    local campfire = GetClosestObjectOfType(playerCoords[0], playerCoords[1], playerCoords[2], 5.0, GetHashKey("p_campfire01x"), false, false, false)


    if (campfire) then
        -- Request the recipes from the server
        TriggerServerEvent('getRecipes')
    else
        -- Send a message to the player that they need to be near a campfire to craft
        VORP.ShowNotification("You need to be near a campfire to craft!")
    end
end)
    


-- Event handler for crafting an item
RegisterNetEvent('craftItem')
AddEventHandler('craftItem', function(item)
    -- Trigger the server event to craft the item
    TriggerServerEvent('vorp:craftItem', item)

    -- Get the recipe from the config file
    local recipe = Config.recipes[item]

    -- Check if the recipe exists
    if not recipe then
        VORP.ShowNotification("This recipe doesn't exist!")
        return
    end

    -- Show a notification to the player that crafting has started
    VORP.ShowNotification("Crafting " .. item .. "...")

    -- Wait for the crafting time to elapse
    Citizen.Wait(recipe.craftingTime * 1000)

    -- Show a notification to the player that crafting has finished
    VORP.ShowNotification("Finished crafting " .. item .. "!")
end)
