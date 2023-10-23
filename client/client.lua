VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)


-- Event handler for opening the crafting menu
RegisterNetEvent('openCraftingMenu')
AddEventHandler('openCraftingMenu', function()
        print("Triggering get recipes")  -- Debug print
        TriggerServerEvent('getRecipes')
        SetNuiFocus(true, true)
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

RegisterNetEvent('receiveRecipes')
AddEventHandler('receiveRecipes', function(data)
    -- Send the received recipes data to the NUI/HTML interface
    SendNUIMessage({
        type = 'receiveRecipes',
        recipes = data
    })
end)

RegisterNUICallback('closeCraftingMenu', function()
    SetNuiFocus(false, false)  -- Removes focus from NUI
end)


RegisterCommand('fists', function(source, args)
    -- Trigger the event to open the crafting menu
    TriggerEvent('openCraftingMenu')
end, false)

