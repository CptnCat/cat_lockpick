Config = {}
Config.VersionCheck = true
Config.Framework = 'esx' -- Supports ESX & QB

Config.UseT3Minigame = true -- If you don't want to use the minigame from t3development, just set it to false

Config.LockPickItem = 'lockpick' -- Specify the item name for the lockpick
Config.RemoveLockpickOnUse = true -- Should the lockpick be removed after use?
Config.RemoveOnlyOnFailure = false -- Should the lockpick be removed only when the minigame fails? (Config.RemoveLockpickOnUse must be enabled)

Config.EnableAlarm = true -- Should the alarm be triggered when lockpicking?
Config.AlarmTimer = 15 -- (in seconds) - How long should the alarm last after starting the lockpicking?

Config.Dispatch = {
    dispatchSystem = '', -- put the right string inside here: 'lbphone', 'roadphone', 'emergencydispatch' to disable just leave it ''  
    alertJob = 'police', -- the job that get's alerted
    title = 'Car Theft', -- title of dispatch
    message = 'A car is being lockpicked!' -- message of dispatch
}
