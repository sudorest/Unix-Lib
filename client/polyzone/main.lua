-- UnixLib PolyZone Module
-- Unified zone API (uses ox_lib or PolyZone)

local PolyZone = {}
PolyZone.__index = PolyZone

function PolyZone:Init()
    local system = UnixLib.Core.GetSystem('PolyZone')
    self.system = system
    
    if system then
        UnixLib.Print('PolyZone: Using ' .. system)
    else
        UnixLib.Print('PolyZone: No system detected')
    end
end

-- Create circle zone
function PolyZone:CreateCircleZone(params)
    params = params or {}
    local name = params.name or 'zone'
    local coords = params.coords
    local radius = params.radius or 2.0
    
    if self.system == 'ox_lib' then
        return exports.ox_lib:registerZone(coords, {
            name = name,
            radius = radius,
            debug = Config.Debug,
            onEnter = params.onEnter,
            onExit = params.onExit,
            inside = params.inside,
        })
    elseif self.system == 'PolyZone' then
        return exports.PolyZone:CircleZone(coords, radius, {
            name = name,
            debugGrid = Config.Debug,
        })
    end
    
    return nil
end

-- Create box zone
function PolyZone:CreateBoxZone(params)
    params = params or {}
    local name = params.name or 'zone'
    local coords = params.coords
    local length = params.length or 2.0
    local width = params.width or 2.0
    local heading = params.heading or 0.0
    
    if self.system == 'ox_lib' then
        return exports.ox_lib:registerZone(coords, {
            name = name,
            radius = math.max(length, width),
            useZ = true,
            debug = Config.Debug,
            onEnter = params.onEnter,
            onExit = params.onExit,
            inside = params.inside,
        })
    elseif self.system == 'PolyZone' then
        return exports.PolyZone:BoxZone(coords, vector3(length, width, 10), {
            name = name,
            heading = heading,
            debugGrid = Config.Debug,
        })
    end
    
    return nil
end

-- Create combo zone (multiple zones)
function PolyZone:CreateComboZone(params)
    params = params or {}
    local zones = params.zones or {}
    
    if self.system == 'ox_lib' then
        return exports.ox_lib:registerZone(zones, {
            name = params.name,
            debug = Config.Debug,
            onEnter = params.onEnter,
            onExit = params.onExit,
            inside = params.inside,
        })
    elseif self.system == 'PolyZone' then
        return exports.PolyZone:ComboZone(zones, {
            name = params.name,
            debugGrid = Config.Debug,
        })
    end
    
    return nil
end

-- Remove zone
function PolyZone:RemoveZone(zone)
    if not zone then return end
    
    if self.system == 'ox_lib' then
        exports.ox_lib:removeZone(zone)
    elseif self.system == 'PolyZone' then
        exports.PolyZone:RemoveZone(zone)
    end
end

-- Check if in zone
function PolyZone:IsInsideZone(zone)
    if not zone then return false end
    
    if self.system == 'ox_lib' then
        return exports.ox_lib:isInZone(zone)
    elseif self.system == 'PolyZone' then
        return zone:isPointInside(GetEntityCoords(PlayerPedId()))
    end
    
    return false
end

return PolyZone
