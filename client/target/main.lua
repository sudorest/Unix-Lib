-- UnixLib Target Module
-- Unified target/interaction API

local Target = {}
Target.__index = Target

function Target:Init()
    local system = UnixLib.Core.GetSystem('Target')
    self.system = system
    self.available = system ~= nil
    
    if self.available then
        UnixLib.Print('Target: Using ' .. system)
    else
        UnixLib.Print('Target: No system detected')
    end
end

-- Add target option
function Target:AddTargetEntity(params)
    if not self.available then return end
    
    params = params or {}
    local entity = params.entity
    local options = params.options or {}
    local label = params.label or 'Interact'
    local icon = params.icon or 'fas fa-hand'
    local event = params.event
    local serverEvent = params.serverEvent
    local job = params.job
    local distance = params.distance or 2.0
    
    local option = {
        label = label,
        icon = icon,
        distance = distance,
    }
    
    if event then
        option.action = function()
            TriggerEvent(event, params.params)
        end
    end
    
    if serverEvent then
        option.action = function()
            TriggerServerEvent(serverEvent, params.params)
        end
    end
    
    if job then
        option.canInteract = function()
            return self:CheckJob(job)
        end
    end
    
    if self.system == 'ox_target' then
        exports.ox_target:addLocalEntity(entity, options)
    elseif self.system == 'qb-target' then
        exports['qb-target']:AddTargetEntity(entity, options)
    elseif self.system == 'qtarget' then
        exports.qtarget:AddEntity({
            entity = entity,
            options = options,
        })
    end
end

-- Add target model
function Target:AddTargetModel(params)
    if not self.available then return end
    
    params = params or {}
    local model = params.model
    local options = params.options or {}
    
    if self.system == 'ox_target' then
        exports.ox_target:addLocalModel(model, options)
    elseif self.system == 'qb-target' then
        exports['qb-target']:AddTargetModel(model, options)
    elseif self.system == 'qtarget' then
        exports.qtarget:AddModel({
            model = model,
            options = options,
        })
    end
end

-- Add target zone
function Target:AddTargetZone(params)
    if not self.available then return end
    
    params = params or {}
    local coords = params.coords
    local length = params.length or 1.0
    local width = params.width or 1.0
    local heading = params.heading or 0.0
    local options = params.options or {}
    
    if self.system == 'ox_target' then
        exports.ox_target:addLocalZone(coords, {
            name = params.name,
            length = length,
            width = width,
            heading = heading,
            debug = Config.Debug,
            options = options,
        })
    elseif self.system == 'qb-target' then
        exports['qb-target']:AddBoxZone(params.name, coords, length, width, {
            name = params.name,
            heading = heading,
            debugPoly = Config.Debug,
            minZ = coords.z - 1.0,
            maxZ = coords.z + 1.0,
        }, options)
    elseif self.system == 'qtarget' then
        exports.qtarget:AddBoxArea({
            name = params.name,
            coords = coords,
            length = length,
            width = width,
            heading = heading,
            debug = Config.Debug,
            options = options,
        })
    end
end

-- Remove target zone
function Target:RemoveZone(name)
    if not self.available then return end
    
    if self.system == 'ox_target' then
        exports.ox_target:removeZone(name)
    elseif self.system == 'qb-target' then
        exports['qb-target']:RemoveZone(name)
    elseif self.system == 'qtarget' then
        exports.qtarget:RemoveArea(name)
    end
end

-- Check job permission
function Target:CheckJob(job)
    local framework = UnixLib.Core.GetFramework()
    
    if framework == 'esx' then
        local playerData = exports.esx:GetPlayerData()
        if type(job) == 'table' then
            for _, j in ipairs(job) do
                if playerData.job.name == j then return true end
            end
        else
            return playerData.job.name == job
        end
    elseif framework == 'qbx' or framework == 'qb' then
        local playerData = exports.qbx_core:GetPlayerData()
        if type(job) == 'table' then
            for _, j in ipairs(job) do
                if playerData.job.name == j then return true end
            end
        else
            return playerData.job.name == job
        end
    elseif framework == 'ox' then
        local player = exports.ox_core:GetPlayer()
        if player then
            local playerJob = player.get('job')
            if type(job) == 'table' then
                for _, j in ipairs(job) do
                    if playerJob.name == j then return true end
                end
            else
                return playerJob.name == job
            end
        end
    end
    
    return false
end

return Target
