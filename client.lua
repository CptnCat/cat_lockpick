lib.callback.register('cat_lockpick:getClosestVehicle', function()
    local closestVehicle = lib.getClosestVehicle(GetEntityCoords(cache.ped), 2.0)
    if not closestVehicle then return nil end

    local lock = GetVehicleDoorLockStatus(closestVehicle)
    return closestVehicle, lock
end)

lib.callback.register('cat_lockpick:startLockpiking', function(vehicle)
    if Config.EnableAlarm then
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, Config.AlarmTimer * 1000)
        StartVehicleAlarm(vehicle)
    end

    local success = exports["t3_lockpick"]:startLockpick("lockpick", nil, nil)
    if not success then return success end

    SetVehicleDoorsLocked(vehicle, 1)
    SetVehicleDoorsLockedForAllPlayers(vehicle, false)
    SetVehicleNeedsToBeHotwired(vehicle, true)
    IsVehicleNeedsToBeHotwired(vehicle)
    TaskEnterVehicle(cache.ped, vehicle, 5.0, -1, 1.0, 1, 0)

    return success
end)