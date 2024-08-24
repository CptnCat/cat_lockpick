local framework = Config.Framework

CreateThread(function()
    if framework == 'qb' or framework == 'QB' then 
        local QBCore = exports['qb-core']:GetCoreObject()

        if QBCore then 
            QBCore.Functions.CreateUseableItem(Config.LockPickItem, function(source, item)
                local Player = QBCore.Functions.GetPlayer(source)
                if not Player.Functions.GetItemByName(item.name) then return end

                local closestVehicle, lockstatus = lib.callback.await('cat_lockpick:getClosestVehicle', source)

                if closestVehicle ~= nil then
                    if lockstatus == 2 then
                        local success = lib.callback.await('cat_lockpick:startLockpiking', source, closestVehicle)

                        if Config.RemoveLockpickOnUse == true then
                            if Config.RemoveOnlyOnFailure == true then
                                if not success then
                                    Player.Functions.RemoveItem('lockpick', 1)
                                end
                            else
                                Player.Functions.RemoveItem('lockpick', 1)
                            end
                        end
                    else
                        TriggerClientEvent('QBCore:Notify', source, "The vehicle is unlocked.")
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, "No vehicle nearby.")
                end
            end)
        else
            lib.print.error("Unable to detect framework, make sure Config.Framework is set to the right framework")
        end
    elseif framework == 'esx' or framework == 'ESX' then 
        local ESX = exports.es_extended:getSharedObject()

        if ESX then 
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
        else
            lib.print.error("Unable to detect framework, make sure Config.Framework is set to the right framework")
        end
    else 
        lib.print.error("Unable to detect framework, make sure Config.Framework is set to the right framework")
    end
end)

if Config.VersionCheck then
    lib.versionCheck('CptnCat/cat_lockpick')
end
