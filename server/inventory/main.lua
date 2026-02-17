-- UnixLib Server Inventory Module
-- Unified inventory API

local Inventory = {}
Inventory.__index = Inventory

function Inventory:Init()
    local system = UnixLib.Core.GetSystem('Inventory')
    self.system = system
    
    if system then
        UnixLib.Print('Inventory: Using ' .. system)
    else
        UnixLib.Print('Inventory: No system detected')
    end
end

-- Add item to player inventory
function Inventory:AddItem(source, item, count, metadata)
    if not self.system then return false end
    
    count = count or 1
    metadata = metadata or {}
    
    if self.system == 'ox_inventory' then
        return exports.ox_inventory:AddItem(source, item, count, metadata)
    elseif self.system == 'qb-inventory' then
        exports['qb-inventory']:AddItem(source, item, count, false, metadata)
    elseif self.system == 'codem-inventory' then
        exports['codem-inventory']:AddItem(source, item, count, metadata)
    elseif self.system == 'mf-inventory' then
        exports['mf-inventory']:AddItem(source, item, count, metadata)
    elseif self.system == 'tgiann-inventory' then
        exports['tgiann-inventory']:AddItem(source, item, count, metadata)
    end
    
    return false
end

-- Remove item from player inventory
function Inventory:RemoveItem(source, item, count, metadata)
    if not self.system then return false end
    
    count = count or 1
    metadata = metadata or {}
    
    if self.system == 'ox_inventory' then
        return exports.ox_inventory:RemoveItem(source, item, count, slot, metadata)
    elseif self.system == 'qb-inventory' then
        exports['qb-inventory']:RemoveItem(source, item, count)
    elseif self.system == 'codem-inventory' then
        exports['codem-inventory']:RemoveItem(source, item, count)
    end
    
    return false
end

-- Get player inventory
function Inventory:GetInventory(source)
    if not self.system then return {} end
    
    if self.system == 'ox_inventory' then
        return exports.ox_inventory:GetInventory(source)
    elseif self.system == 'qb-inventory' then
        return exports['qb-inventory']:GetInventoryItems(source)
    end
    
    return {}
end

-- Get item count
function Inventory:GetItemCount(source, item)
    if not self.system then return 0 end
    
    if self.system == 'ox_inventory' then
        local itemData = exports.ox_inventory:GetItem(source, item)
        return itemData and itemData.count or 0
    elseif self.system == 'qb-inventory' then
        local itemData = exports['qb-inventory']:GetItemByName(source, item)
        return itemData and itemData.amount or 0
    end
    
    return 0
end

-- Check if player has item
function Inventory:HasItem(source, item, count)
    count = count or 1
    return self:GetItemCount(source, item) >= count
end

-- Use item
function Inventory:UseItem(source, item)
    if not self.system then return false end
    
    if self.system == 'ox_inventory' then
        return exports.ox_inventory:UseItem(source, item)
    elseif self.system == 'qb-inventory' then
        exports['qb-core']:UseItem(source, item)
    end
    
    return false
end

-- Get weapon
function Inventory:GetWeapon(source, weapon)
    if not self.system then return nil end
    
    if self.system == 'ox_inventory' then
        return exports.ox_inventory:GetWeapon(source, weapon)
    elseif self.system == 'qb-inventory' then
        return exports['qb-inventory']:GetWeaponByName(source, weapon)
    end
    
    return nil
end

-- Add weapon
function Inventory:AddWeapon(source, weapon, ammo)
    if not self.system then return false end
    
    if self.system == 'ox_inventory' then
        return exports.ox_inventory:AddItem(source, weapon, 1, { ammo = ammo or 0 })
    elseif self.system == 'qb-inventory' then
        exports['qb-inventory']:AddWeapon(source, weapon, ammo)
    end
    
    return false
end

-- Remove weapon
function Inventory:RemoveWeapon(source, weapon)
    if not self.system then return false end
    
    if self.system == 'ox_inventory' then
        exports.ox_inventory:RemoveItem(source, weapon, 1)
    elseif self.system == 'qb-inventory' then
        exports['qb-inventory']:RemoveWeapon(source, weapon)
    end
    
    return true
end

return Inventory
