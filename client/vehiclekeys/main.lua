-- UnixLib VehicleKeys Module
-- Unified vehicle keys API

local VehicleKeys = {}
VehicleKeys.__index = VehicleKeys

function VehicleKeys:Init()
    local system = UnixLib.Core.GetSystem('VehicleKeys')
    self.system = system
    
    if system then
        UnixLib.Print('VehicleKeys: Using ' .. system)
    else
        UnixLib.Print('VehicleKeys: No system detected')
    end
end

-- Give keys to vehicle
function VehicleKeys:GiveKeys(vehicle)
    if not self.system then return end
    
    local plate = GetVehicleNumberPlateText(vehicle)
    plate = plate:gsub('%s*$', '')
    
    if self.system == 'okokGarage' then
        exports.okokGarage:GiveKeys(plate)
    elseif self.system == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:GiveKeys(PlayerPedId(), plate)
    elseif self.system == 'qb-vehiclekeys' then
        exports['qb-vehiclekeys']:GiveKeys(vehicle)
    elseif self.system == 'wasabi_carlock' then
        exports.wasabi_carlock:RegisterVehicle(plate)
    elseif self.system == 'cd_garage' then
        exports.cd_garage:GiveKeys(plate)
    end
end

-- Remove keys from vehicle
function VehicleKeys:RemoveKeys(plate)
    if not self.system then return end
    
    plate = plate:gsub('%s*$', '')
    
    if self.system == 'okokGarage' then
        exports.okokGarage:RemoveKeys(plate)
    elseif self.system == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:RemoveKeys(PlayerPedId(), plate)
    elseif self.system == 'wasabi_carlock' then
        exports.wasabi_carlock:UnregisterVehicle(plate)
    end
end

-- Check if player has keys
function VehicleKeys:HasKeys(vehicle)
    if not self.system then return true end -- Default to true if no system
    
    local plate = GetVehicleNumberPlateText(vehicle)
    plate = plate:gsub('%s*$', '')
    
    if self.system == 'okokGarage' then
        return exports.okokGarage:HasKeys(plate)
    elseif self.system == 'qs-vehiclekeys' then
        return exports['qs-vehiclekeys']:HasKeys(PlayerPedId(), plate)
    elseif self.system == 'qb-vehiclekeys' then
        return exports['qb-vehiclekeys']:HasKey(plate)
    elseif self.system == 'wasabi_carlock' then
        return exports.wasabi_carlock:HasKey(plate)
    end
    
    return true
end

-- Lock vehicle
function VehicleKeys:LockVehicle(vehicle)
    if not self.system then
        SetVehicleDoorsLocked(vehicle, 2)
        return
    end
    
    if self.system == 'okokGarage' then
        exports.okokGarage:LockVehicle(vehicle)
    elseif self.system == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:LockVehicle(plate)
    elseif self.system == 'wasabi_carlock' then
        exports.wasabi_carlock:LockVehicle(plate)
    end
end

-- Unlock vehicle
function VehicleKeys:UnlockVehicle(vehicle)
    if not self.system then
        SetVehicleDoorsLocked(vehicle, 0)
        return
    end
    
    if self.system == 'okokGarage' then
        exports.okokGarage:UnlockVehicle(vehicle)
    elseif self.system == 'qs-vehiclekeys' then
        exports['qs-vehiclekeys']:UnlockVehicle(plate)
    elseif self.system == 'wasabi_carlock' then
        exports.wasabi_carlock:UnlockVehicle(plate)
    end
end

return VehicleKeys
