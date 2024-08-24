lib.callback.register('cat_lockpick:getClosestVehicle', function()
    local closestVehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), 2.0)

    if closestVehicle ~= nil then
        local lock = GetVehicleDoorLockStatus(closestVehicle)
        return closestVehicle, lock
    else
        return nil
    end
end)

lib.callback.register('cat_lockpick:startLockpiking', function(vehicle)
    if Config.EnableAlarm == true then
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, Config.AlarmTimer * 1000)
        StartVehicleAlarm(vehicle)
    end

    local success = exports["t3_lockpick"]:startLockpick("lockpick", nil, nil)

    if success then
        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        SetVehicleNeedsToBeHotwired(vehicle, true)
        IsVehicleNeedsToBeHotwired(vehicle)
        TaskEnterVehicle(PlayerPedId(), vehicle, 5.0, -1, 1.0, 1, 0)
    end

    return success
end)