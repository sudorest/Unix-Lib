_G.UnixLib = _G.UnixLib or {}

local function isRunning(name)
    return GetResourceState(name) == 'started'
end

local function detect(resources)
    for _, resource in ipairs(resources) do
        if isRunning(resource) then
            return resource
        end
    end
    return nil
end

local function framework()
    if isRunning('ox_core') then return 'ox'
    elseif isRunning('qbx_core') or isRunning('qbx-core') then return 'qbx'
    elseif isRunning('es_extended') or isRunning('esx') then return 'esx' end
    return nil
end

local function sql()
    if isRunning('oxmysql') then return 'oxmysql'
    elseif isRunning('mysql-async') then return 'mysql-async'
    elseif isRunning('ghmattimysql') then return 'ghmattimysql' end
    return nil
end

local Detected = {
    Framework = nil,
    SQL = nil,
    Inventory = nil,
    Notifications = nil,
    Target = nil,
    ProgressBar = nil,
    Menu = nil,
    Input = nil,
    TextUI = nil,
    PolyZone = nil,
    WeatherSync = nil,
    Dispatch = nil,
    VehicleKeys = nil,
    Fuel = nil,
    Clothing = nil,
}

local resources = {
    Inventory = { 'ox_inventory', 'qb-inventory', 'codem-inventory', 'tgiann-inventory', 'mf-inventory' },
    Notifications = { 'ox_lib', 'qb-core', 'es_extended', 'okok', 'ps-ui', 'mythic' },
    Target = { 'ox_target', 'qb-target', 'qtarget' },
    ProgressBar = { 'ox_lib', 'qb-core' },
    Menu = { 'ox_lib', 'qb-menu', 'nh-context', 'esx_menu_default', 'esx_context' },
    Input = { 'ox_lib', 'qb-input', 'ps-ui' },
    TextUI = { 'ox_lib', 'okokTextUI', 'qb-core' },
    PolyZone = { 'ox_lib', 'PolyZone' },
    WeatherSync = { 'cd_easytime', 'qb-weathersync', 'renewed-weathersync' },
    Dispatch = { 'ps-dispatch', 'cd_dispatch', 'qs-dispatch', 'rcore_dispatch', 'core_dispatch', 'fea-dispatch', 'origen_police' },
    VehicleKeys = { 'okokGarage', 'qs-vehiclekeys', 'qb-vehiclekeys', 'wasabi_carlock', 'cd_garage', 'mk_vehiclekeys' },
    Fuel = { 'ox_fuel', 'LegacyFuel', 'ps-fuel', 'cdn-fuel', 'lj-fuel', 'renewed-fuel' },
    Clothing = { 'fivem-appearance', 'illenium-appearance', 'qb-clothing', 'esx_skin', 'ox_appearance', 'codem-appearance' },
}

function UnixLib.DetectAll()
    local function p(fmt, v)
        if Config.Debug then
            print('[UnixLib] ' .. string.format(fmt, v or 'None'))
        end
    end

    Detected.Framework = framework()
    p('Framework: %s', Detected.Framework)

    Detected.SQL = sql()
    p('SQL: %s', Detected.SQL)

    for key, list in pairs(resources) do
        Detected[key] = detect(list)
        p('%s: %s', Detected[key])
    end

    return Detected
end

function UnixLib.GetSystem(system)
    return Detected[system]
end

function UnixLib.HasSystem(system)
    return Detected[system] ~= nil
end

function UnixLib.GetAllDetected()
    return Detected
end

function UnixLib.GetFramework()
    return Detected.Framework
end

return UnixLib
