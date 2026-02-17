-- UnixLib Server Groups Module
-- Unified groups/permissions API

local Groups = {}
Groups.__index = Groups

function Groups:Init()
    local framework = UnixLib.Core.GetFramework()
    self.framework = framework
    
    UnixLib.Print('Groups: Using framework ' .. (framework or 'none'))
end

-- Get player data
function Groups:GetPlayerData(source)
    if not self.framework then
        return {}
    end
    
    if self.framework == 'esx' then
        return exports.esx:GetPlayerData(source)
    elseif self.framework == 'qbx' or self.framework == 'qb' then
        return exports.qbx_core:GetPlayerData()
    elseif self.framework == 'ox' then
        local player = exports.ox_core:GetPlayer(source)
        return player and player.get or function() return {} end
    end
    
    return {}
end

-- Get player job
function Groups:GetJob(source)
    if not self.framework then
        return { name = 'none', grade = 0 }
    end
    
    if self.framework == 'esx' then
        local xPlayer = exports.esx:GetPlayerFromId(source)
        return xPlayer and xPlayer.job or { name = 'none', grade = 0 }
    elseif self.framework == 'qbx' or self.framework == 'qb' then
        local player = exports.qbx_core:GetPlayer(source)
        return player and player.PlayerData.job or { name = 'none', grade = 0 }
    elseif self.framework == 'ox' then
        local player = exports.ox_core:GetPlayer(source)
        return player and player.get('job') or { name = 'none', grade = 0 }
    end
    
    return { name = 'none', grade = 0 }
end

-- Get player job grade
function Groups:GetJobGrade(source)
    local job = self:GetJob(source)
    return job.grade or job.grade_level or 0
end

-- Check if player has job
function Groups:HasJob(source, job)
    local playerJob = self:GetJob(source)
    if type(job) == 'table' then
        for _, j in ipairs(job) do
            if playerJob.name == j then return true end
        end
        return false
    end
    return playerJob.name == job
end

-- Check if player has job grade
function Groups:HasJobGrade(source, job, grade)
    local playerJob = self:GetJob(source)
    local jobGrade = self:GetJobGrade(source)
    
    if job and playerJob.name ~= job then
        return false
    end
    
    return jobGrade >= grade
end

-- Get player gang
function Groups:GetGang(source)
    if not self.framework then
        return { name = 'none', grade = 0 }
    end
    
    if self.framework == 'qbx' or self.framework == 'qb' then
        local player = exports.qbx_core:GetPlayer(source)
        return player and player.PlayerData.gang or { name = 'none', grade = 0 }
    elseif self.framework == 'ox' then
        local player = exports.ox_core:GetPlayer(source)
        return player and player.get('group') or { name = 'none', grade = 0 }
    end
    
    return { name = 'none', grade = 0 }
end

-- Check if player has gang
function Groups:HasGang(source, gang)
    local playerGang = self:GetGang(source)
    if type(gang) == 'table' then
        for _, g in ipairs(gang) do
            if playerGang.name == g then return true end
        end
        return false
    end
    return playerGang.name == gang
end

-- Get player money
function Groups:GetMoney(source, account)
    if not self.framework then
        return 0
    end
    
    account = account or 'cash'
    
    if self.framework == 'esx' then
        local xPlayer = exports.esx:GetPlayerFromId(source)
        if xPlayer then
            if account == 'cash' then
                return xPlayer.getMoney()
            elseif account == 'bank' then
                return xPlayer.getAccount('bank').money
            end
        end
    elseif self.framework == 'qbx' or self.framework == 'qb' then
        local player = exports.qbx_core:GetPlayer(source)
        if player then
            if account == 'cash' then
                return player.PlayerData.money.cash
            elseif account == 'bank' then
                return player.PlayerData.money.bank
            end
        end
    elseif self.framework == 'ox' then
        local player = exports.ox_core:GetPlayer(source)
        if player then
            local money = player.get('money')
            return money and money[account] or 0
        end
    end
    
    return 0
end

-- Remove money
function Groups:RemoveMoney(source, amount, account)
    if not self.framework then
        return false
    end
    
    account = account or 'cash'
    
    if self.framework == 'esx' then
        local xPlayer = exports.esx:GetPlayerFromId(source)
        if xPlayer then
            if account == 'cash' then
                return xPlayer.removeMoney(amount)
            elseif account == 'bank' then
                return xPlayer.removeAccountMoney('bank', amount)
            end
        end
    elseif self.framework == 'qbx' or self.framework == 'qb' then
        local player = exports.qbx_core:GetPlayer(source)
        if player then
            return player.removeMoney(amount, account)
        end
    elseif self.framework == 'ox' then
        local player = exports.ox_core:GetPlayer(source)
        if player then
            return player.removeMoney(amount, account)
        end
    end
    
    return false
end

-- Add money
function Groups:AddMoney(source, amount, account)
    if not self.framework then
        return false
    end
    
    account = account or 'cash'
    
    if self.framework == 'esx' then
        local xPlayer = exports.esx:GetPlayerFromId(source)
        if xPlayer then
            if account == 'cash' then
                return xPlayer.addMoney(amount)
            elseif account == 'bank' then
                return xPlayer.addAccountMoney('bank', amount)
            end
        end
    elseif self.framework == 'qbx' or self.framework == 'qb' then
        local player = exports.qbx_core:GetPlayer(source)
        if player then
            return player.addMoney(amount, account)
        end
    elseif self.framework == 'ox' then
        local player = exports.ox_core:GetPlayer(source)
        if player then
            return player.addMoney(amount, account)
        end
    end
    
    return false
end

return Groups
