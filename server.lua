ESX.RegisterUsableItem(Config.LockPickItem, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local closestVehicle, lockstatus = lib.callback.await('cat_lockpick:getClosestVehicle', source)

    if closestVehicle ~= nil then
        if lockstatus == 2 then
            local success = lib.callback.await('cat_lockpick:startLockpiking', source, closestVehicle)

            if Config.RemoveLockpickOnUse == true then
                if Config.RemoveOnlyOnFailure == true then
                    if not success then
                        xPlayer.removeInventoryItem('lockpick', 1)
                    end
                else
                    xPlayer.removeInventoryItem('lockpick', 1)
                end
            end
        else
            xPlayer.showNotification("The vehicle is unlocked.")
        end
    else
        xPlayer.showNotification("No vehicle nearby.")
    end
end)

if Config.VersionCheck then
    lib.versionCheck('CptnCat/cat_lockpcik')
end