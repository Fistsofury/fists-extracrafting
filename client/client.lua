VORPcore = {}
TriggerEvent("getCore", function(core)
    VORPcore = core
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local playerPed = PlayerPedId()
        local campfire = GetClosestObjectOfType(GetEntityCoords(playerPed), 1.0, GetHashKey("p_campfire05x"), false, false, false)
        
        if campfire ~= 0 then
            if Citizen.InvokeNative(0x83CDB10EA29B370B, campfire) then  
                SetTextScale(0.35, 0.35)
                SetTextColor(255, 255, 255, 255) -- You can change the text color here
                SetTextCentre(true)
                SetTextDropshadow(1, 0, 0, 0, 200) -- You can change the text shadow color here
                SetTextFontForCurrentCommand(6) 
                DisplayText(CreateVarString(10, 'LITERAL_STRING', 'Press G to open crafting menu'), 0.5, 0.8)

                if IsControlJustPressed(0, 0x760A9C6F) then  
                    TriggerEvent('fists_crafting:openCraftingMenu')
                end
            end
        end
    end
end)



RegisterNetEvent('fists_crafting:openCraftingMenu')
AddEventHandler('fists_crafting:openCraftingMenu', function()

    --print("Triggering get recipes")  -- Debug print
    TriggerServerEvent('fists_crafting:getRecipes')
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'fists_crafting:showMenu'})

end)


RegisterNUICallback("fists_crafting:craft", function(data, cb)
    TriggerServerEvent("fists_crafting:craftItem1", data.recipe)
    --print("Craft button clicked")
    cb('ok')
end)

RegisterNetEvent('fists_crafting:playCraftingAnimation')
AddEventHandler('fists_crafting:playCraftingAnimation', function(duration)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CROUCH_INSPECT", 0, true)
    Citizen.Wait(duration * 1000)
    ClearPedTasks(playerPed)
end)


RegisterNetEvent('fists_crafting:receiveRecipes')
AddEventHandler('fists_crafting:receiveRecipes', function(data)

    --print("receiveRecipes triggered")  --  print
    SendNUIMessage({
        type = 'fists_crafting:receiveRecipes',
        recipes = data
    })
end)

RegisterNUICallback('fists_crafting:closeCraftingMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)


--[[RegisterCommand('fists', function(source, args)  -- Temp command for testing, will change to prop at some point
    TriggerEvent('fists_crafting:openCraftingMenu')
end, false)]]

