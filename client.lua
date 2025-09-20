lib.callback.register('cat_lockpick:getClosestVehicle', function()
    local closestVehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), 2.0)

    if closestVehicle ~= nil then
        local lock = GetVehicleDoorLockStatus(closestVehicle)
        return closestVehicle, lock
    else
        return nil
    end
end)

function alertPolice()
    local coords = GetEntityCoords(PlayerPedId())
    
    if Config.Dispatch.system = '' then
        return
    elseif Config.Dispatch.system = 'roadphone' then
        local position = {x = coords.x, y = coords.y, z = coords.z - 1}
        TriggerServerEvent('roadphone:sendDispatch', GetPlayerServerId(PlayerId()), Config.Dispatch.message, Config.Dispatch.alertJob, position, false)
    elseif Config.Dispatch.system = 'emergencydispatch' then
    end
end

lib.callback.register('cat_lockpick:startLockpicking', function(vehicle)
    if Config.EnableAlarm == true then
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, Config.AlarmTimer * 1000)
        StartVehicleAlarm(vehicle)
    end

    alertPolice()

    local success = false
    if Config.UseT3Minigame then
        local success = exports["t3_lockpick"]:startLockpick("lockpick", nil, nil)

        if success then
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            SetVehicleNeedsToBeHotwired(vehicle, true)
            IsVehicleNeedsToBeHotwired(vehicle)
            TaskEnterVehicle(PlayerPedId(), vehicle, 5.0, -1, 1.0, 1, 0)
        end
    else
        success = true
        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        SetVehicleNeedsToBeHotwired(vehicle, true)
        IsVehicleNeedsToBeHotwired(vehicle)
        TaskEnterVehicle(PlayerPedId(), vehicle, 5.0, -1, 1.0, 1, 0)
    end

    return success
end)

