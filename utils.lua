_G.UnixLib = _G.UnixLib or {}
local Utils = {}

function Utils.Print(...)
    if Config.Debug then
        print('[UnixLib] ', ...)
    end
end

function Utils.Warning(...)
    print('[UnixLib] WARNING: ', ...)
end

function Utils.Error(...)
    print('[UnixLib] ERROR: ', ...)
end

function Utils.IsRunning(name)
    return GetResourceState(name) == 'started'
end

function Utils.WaitForResource(name, timeout)
    local start = os.time()
    while not Utils.IsRunning(name) do
        Wait(100)
        if os.time() - start > (timeout or 5000) / 1000 then
            return false
        end
    end
    return true
end

function Utils.Export(resource, export, ...)
    local success, result = pcall(exports[resource][export], ...)
    if success then
        return result
    end
    Utils.Warning(string.format('Export %s:%s not available: %s', resource, export, result))
    return nil
end

function Utils.GetPlayer(source)
    if Framework == 'esx' then
        return exports.esx:GetPlayerFromId(source)
    elseif Framework == 'qbx' or Framework == 'qb' then
        return exports.qbx_core:GetPlayer(source)
    elseif Framework == 'ox' then
        return exports.ox_core:GetPlayer(source)
    end
    return nil
end

function Utils.Contains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then return true end
    end
    return false
end

function Utils.Merge(default, override)
    local result = {}
    for k, v in pairs(default) do result[k] = v end
    for k, v in pairs(override or {}) do result[k] = v end
    return result
end

function Utils.GetCoords(entity)
    local c = GetEntityCoords(entity)
    return vector3(c.x, c.y, c.z)
end

function Utils.GetHeading(entity)
    return GetEntityHeading(entity)
end

function Utils.Distance(a, b)
    return #(a - b)
end

function Utils.IsVehicle(entity)
    return IsEntityAVehicle(entity)
end

function Utils.GetPlate(vehicle)
    return string.match(GetVehicleNumberPlateText(vehicle), "^%s*(.-)%s*$")
end

function string.trim(s)
    return s:match("^%s*(.-)%s*$")
end

Utils.NotifyTypes = {
    success = 'success',
    error = 'error',
    info = 'info',
    warning = 'warning',
    primary = 'info',
    [1] = 'success',
    [2] = 'error',
    [3] = 'info',
}

return Utils
