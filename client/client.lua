VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)

RegisterNetEvent('openCraftingMenu')
AddEventHandler('openCraftingMenu', function()

    print("Triggering get recipes")  -- Debug print
    TriggerServerEvent('getRecipes')
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'showMenu'})

end)

RegisterNetEvent('craftItem')
AddEventHandler('craftItem', function(item)
    TriggerServerEvent('vorp:craftItem', item)
    print("Item Set:", item)
    local recipe = Config.recipes[item]
    if not recipe then
        VORP.ShowNotification("This recipe doesn't exist!")
        return
    end
    VORP.ShowNotification("Crafting " .. item .. "...")
    Citizen.Wait(recipe.craftingTime * 1000) -- times 1000 to get seconds
    VORP.ShowNotification("Finished crafting " .. item .. "!")
end)


RegisterNetEvent('crafting:startCraftingAnimation')
AddEventHandler('crafting:startCraftingAnimation', function()
    TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CROUCH_INSPECT', 0, true)
    Citizen.Wait(Config.craftingTime * 1000)
    ClearPedTasks(PlayerPedId())
end)

RegisterNUICallback("craft", function(data, cb)
    TriggerServerEvent("vorp:craftItem", data.recipe)
    cb('ok')
end)

RegisterNetEvent('receiveRecipes')
AddEventHandler('receiveRecipes', function(data)

    print("receiveRecipes triggered")  --  print
    SendNUIMessage({
        type = 'receiveRecipes',
        recipes = data
    })
end)

RegisterNUICallback('closeCraftingMenu', function()
    SetNuiFocus(false, false)  -- Removes focus from NUI
end)


RegisterCommand('fists', function(source, args)  -- Temp command for testing, will change to prop at some point
    TriggerEvent('openCraftingMenu')
end, false)

