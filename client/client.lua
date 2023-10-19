VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)


-- Event handler for opening the crafting menu
RegisterNetEvent('openCraftingMenu')
AddEventHandler('openCraftingMenu', function()
    -- Get the player's current coordinates
 --   local playerCoords = GetEntityCoords(PlayerPedId())

    -- Get the coordinates of the nearest campfire
   -- local campfire = VORP.Game.GetClosestObject("p_campfire01x", playerCoords.x, playerCoords.y, playerCoords.z)

    -- Check if the player is near a campfire
  --  if (campfire) then
        -- Request the recipes from the server
        print("Triggering get recipes")  -- Debug print
        TriggerServerEvent('getRecipes')
        SetNuiFocus(true, true)
 --   else
        -- Send a message to the player that they need to be near a campfire to craft
  --      VORP.ShowNotification("You need to be near a campfire to craft!")

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

