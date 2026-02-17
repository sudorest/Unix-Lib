-- UnixLib Notifications Module
-- Unified notification API across all notification systems

local Notifications = {}
Notifications.__index = Notifications

function Notifications:Init()
    local system = UnixLib.Core.GetSystem('Notifications')
    self.system = system
    self.available = system ~= nil
    
    if self.available then
        UnixLib.Print('Notifications: Using ' .. system)
    else
        UnixLib.Print('Notifications: No system detected, using fallback')
    end
end

-- Main notify function
function Notifications:Notify(params)
    params = params or {}
    local title = params.title or ''
    local message = params.message or ''
    local type = params.type or 'info'
    local duration = params.duration or 3000
    
    if not self.available then
        -- Fallback to native GTA notification
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandThefeedPostTicker(true, true)
        return
    end
    
    -- ox_lib
    if self.system == 'ox_lib' then
        exports.ox_lib:notify({
            title = title,
            description = message,
            type = type,
            duration = duration,
        })
    -- qb-core
    elseif self.system == 'qb-core' then
        exports['qb-core']:Notify(message, type, duration)
    -- es_extended
    elseif self.system == 'es_extended' then
        exports.esx:ShowNotification(message)
    -- okok
    elseif self.system == 'okok' then
        exports.okokNotify:Notify(title, message, type)
    -- ps-ui
    elseif self.system == 'ps-ui' then
        exports['ps-ui']:Notify(message, type)
    -- mythic
    elseif self.system == 'mythic' then
        exports['mythic_notify']:DoHudText(type, message)
    end
end

-- Convenience methods
function Notifications:Success(message, title, duration)
    self:Notify({ title = title, message = message, type = 'success', duration = duration })
end

function Notifications:Error(message, title, duration)
    self:Notify({ title = title, message = message, type = 'error', duration = duration })
end

function Notifications:Info(message, title, duration)
    self:Notify({ title = title, message = message, type = 'info', duration = duration })
end

function Notifications:Warning(message, title, duration)
    self:Notify({ title = title, message = message, type = 'warning', duration = duration })
end

return Notifications
