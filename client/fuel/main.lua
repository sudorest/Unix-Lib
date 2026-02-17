-- UnixLib Fuel Module
-- Unified fuel API

local Fuel = {}
Fuel.__index = Fuel

function Fuel:Init()
    local system = UnixLib.Core.GetSystem('Fuel')
    self.system = system
    
    if system then
        UnixLib.Print('Fuel: Using ' .. system)
    else
        UnixLib.Print('Fuel: No system detected - using native GTA fuel')
    end
end

-- Get vehicle fuel level
function Fuel:GetFuel(vehicle)
    if not self.system then
        return GetVehicleFuelLevel(vehicle)
    end
    
    if self.system == 'ox_fuel' then
        return exports.ox_fuel:GetFuel(vehicle)
    elseif self.system == 'LegacyFuel' then
        return exports.LegacyFuel:GetFuel(vehicle)
    elseif self.system == 'ps-fuel' then
        return exports['ps-fuel']:GetFuel(vehicle)
    elseif self.system == 'cdn-fuel' then
        return exports['cdn-fuel']:GetFuel(vehicle)
    elseif self.system == 'lj-fuel' then
        return exports['lj-fuel']:GetFuel(vehicle)
    elseif self.system == 'renewed-fuel' then
        return exports['renewed-fuel']:GetFuel(vehicle)
    end
    
    return GetVehicleFuelLevel(vehicle)
end

-- Set vehicle fuel level
function Fuel:SetFuel(vehicle, amount)
    if not self.system then
        SetVehicleFuelLevel(vehicle, amount)
        return
    end
    
    if self.system == 'ox_fuel' then
        exports.ox_fuel:SetFuel(vehicle, amount)
    elseif self.system == 'LegacyFuel' then
        exports.LegacyFuel:SetFuel(vehicle, amount)
    elseif self.system == 'ps-fuel' then
        exports['ps-fuel']:SetFuel(vehicle, amount)
    elseif self.system == 'cdn-fuel' then
        exports['cdn-fuel']:SetFuel(vehicle, amount)
    elseif self.system == 'lj-fuel' then
        exports['lj-fuel']:SetFuel(vehicle, amount)
    elseif self.system == 'renewed-fuel' then
        exports['renewed-fuel']:SetFuel(vehicle, amount)
    end
end

-- Is fuel enabled
function Fuel:IsFuelEnabled()
    return self.system ~= nil
end

return Fuel
