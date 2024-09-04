local framework = Config.Framework

CreateThread(function()
    if framework == 'qb' or framework == 'QB' then
        local QBCore = exports['qb-core']:GetCoreObject()
        if not QBCore then return lib.print.error("Unable to detect framework, make sure Config.Framework is set to the right framework") end

        QBCore.Functions.CreateUseableItem(Config.LockPickItem, function(source, item)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            if not Player.Functions.GetItemByName(item.name) then return end

            local closestVehicle, lockstatus = lib.callback.await('cat_lockpick:getClosestVehicle', src)
            if not closestVehicle then return TriggerClientEvent('QBCore:Notify', src, "No vehicle nearby.") end

            if not (lockstatus == 2) then return TriggerClientEvent('QBCore:Notify', src, "The vehicle is unlocked.") end

            local success = lib.callback.await('cat_lockpick:startLockpiking', src, closestVehicle)

            if not Config.RemoveLockpickOnUse then return end

            if not Config.RemoveOnlyOnFailure then return Player.Functions.RemoveItem('lockpick', 1) end

            if not success then return Player.Functions.RemoveItem('lockpick', 1) end
        end)
    elseif framework == 'esx' or framework == 'ESX' then
        local ESX = exports.es_extended:getSharedObject()
        if not ESX then return lib.print.error("Unable to detect framework, make sure Config.Framework is set to the right framework") end

        ESX.RegisterUsableItem(Config.LockPickItem, function(source)
            local src = source
            local xPlayer = ESX.GetPlayerFromId(src)
            local closestVehicle, lockstatus = lib.callback.await('cat_lockpick:getClosestVehicle', src)

            if not closestVehicle then return xPlayer.showNotification("No vehicle nearby.") end

            if not (lockstatus == 2) then return xPlayer.showNotification("The vehicle is unlocked.") end
            local success = lib.callback.await('cat_lockpick:startLockpiking', src, closestVehicle)

            if not Config.RemoveLockpickOnUse then return end

            if not Config.RemoveOnlyOnFailure then return xPlayer.removeInventoryItem('lockpick', 1) end

            if not success then return xPlayer.removeInventoryItem('lockpick', 1) end
        end)
    else
        lib.print.error("Unable to detect framework, make sure Config.Framework is set to the right framework")
    end
end)

if Config.VersionCheck then
    lib.versionCheck('CptnCat/cat_lockpick')
end