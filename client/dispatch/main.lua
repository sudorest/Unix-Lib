-- UnixLib Dispatch Module
-- Unified dispatch/police alert API

local Dispatch = {}
Dispatch.__index = Dispatch

function Dispatch:Init()
    local system = UnixLib.Core.GetSystem('Dispatch')
    self.system = system
    
    if system then
        UnixLib.Print('Dispatch: Using ' .. system)
    else
        UnixLib.Print('Dispatch: No system detected')
    end
end

-- Send dispatch alert
function Dispatch:SendAlert(params)
    if not self.system then return end
    
    params = params or {}
    local title = params.title or 'Alert'
    local message = params.message or ''
    local coords = params.coords or GetEntityCoords(PlayerPedId())
    local alertType = params.type or 'generic'
    local sprite = params.sprite or 11
    local color = params.color or 1
    local radius = params.radius or 100
    
    if self.system == 'ps-dispatch' then
        exports['ps-dispatch']:PlaySound()
        exports['ps-dispatch']:CustomAlert({
            title = title,
            message = message,
            coords = coords,
            dispatchType = alertType,
        })
    elseif self.system == 'cd_dispatch' then
        exports.cd_dispatch:AddDispatchPlayer({
            code = alertType,
            sprite = sprite,
            color = color,
            title = title,
            message = message,
            coords = coords,
        })
    elseif self.system == 'qs-dispatch' then
        exports['qs-dispatch']:SendAlert({
            title = title,
            message = message,
            coords = coords,
            type = alertType,
        })
    elseif self.system == 'rcore_dispatch' then
        exports.rcore_dispatch:sendDispatch(title, message, coords)
    elseif self.system == 'core_dispatch' then
        exports.core_dispatch:addCall(coords, {
            code = alertType,
            title = title,
            description = message,
        })
    elseif self.system == 'fea-dispatch' then
        exports['fea-dispatch']:sendDispatch({
            title = title,
            message = message,
            coords = coords,
        })
    elseif self.system == 'origen_police' then
        exports.origen_police:createCall(title, message, coords, alertType)
    end
end

-- Send vehicle alert
function Dispatch:SendVehicleAlert(params)
    params = params or {}
    params.type = params.type or '10-42'
    params.title = params.title or 'Vehicle'
    params.message = params.message or 'Vehicle spotted'
    params.sprite = params.sprite or 524
    self:SendAlert(params)
end

-- Send person alert
function Dispatch:SendPersonAlert(params)
    params = params or {}
    params.type = params.type or '10-10'
    params.title = params.title or 'Person'
    params.message = params.message or 'Person spotted'
    params.sprite = params.sprite or 189
    self:SendAlert(params)
end

-- Check if player is in service
function Dispatch:IsInService()
    local framework = UnixLib.Core.GetFramework()
    
    if framework == 'esx' then
        local playerData = exports.esx:GetPlayerData()
        return playerData.job and playerData.job.name == 'police' and playerData.job.grade >= 1
    elseif framework == 'qbx' or framework == 'qb' then
        local playerData = exports.qbx_core:GetPlayerData()
        return playerData.job and playerData.job.name == 'police' and playerData.job.grade.level >= 1
    elseif framework == 'ox' then
        local player = exports.ox_core:GetPlayer()
        if player then
            local job = player.get('job')
            return job.name == 'police' and job.grade >= 1
        end
    end
    
    return false
end

return Dispatch
