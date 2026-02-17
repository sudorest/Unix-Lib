-- UnixLib Clothing Module
-- Unified clothing/appearance API

local Clothing = {}
Clothing.__index = Clothing

function Clothing:Init()
    local system = UnixLib.Core.GetSystem('Clothing')
    self.system = system
    
    if system then
        UnixLib.Print('Clothing: Using ' .. system)
    else
        UnixLib.Print('Clothing: No system detected')
    end
end

-- Open clothing menu
function Clothing:Open()
    if not self.system then return end
    
    if self.system == 'fivem-appearance' then
        exports['fivem-appearance']:startPlayerFading()
        exports['fivem-appearance']:openMenu()
    elseif self.system == 'illenium-appearance' then
        exports['illenium-appearance']:OpenClothingShopMenu()
    elseif self.system == 'qb-clothing' then
        exports['qb-clothing']:OpenMenu()
    elseif self.system == 'esx_skin' then
        exports.esx_skin:openMenu()
    elseif self.system == 'ox_appearance' then
        exports.ox_appearance:open()
    elseif self.system == 'codem-appearance' then
        exports['codem-appearance']:open()
    end
end

-- Save appearance
function Clothing:Save(appearance)
    if not self.system then return end
    
    if self.system == 'fivem-appearance' then
        exports['fivem-appearance']:setPlayerAppearance(appearance)
    elseif self.system == 'illenium-appearance' then
        exports['illenium-appearance']:SaveAppearance(appearance)
    elseif self.system == 'qb-clothing' then
        exports['qb-clothing']:Save(appearance)
    elseif self.system == 'ox_appearance' then
        exports.ox_appearance:setPlayerAppearance(appearance)
    elseif self.system == 'codem-appearance' then
        exports['codem-appearance']:setPlayerAppearance(appearance)
    end
end

-- Get appearance
function Clothing:Get()
    if not self.system then return nil end
    
    if self.system == 'fivem-appearance' then
        return exports['fivem-appearance']:getPlayerAppearance()
    elseif self.system == 'illenium-appearance' then
        return exports['illenium-appearance']:GetCurrentAppearance()
    elseif self.system == 'ox_appearance' then
        return exports.ox_appearance:getPlayerAppearance()
    elseif self.system == 'codem-appearance' then
        return exports['codem-appearance']:getPlayerAppearance()
    end
    
    return nil
end

-- Open ped selector
function Clothing:OpenPedMenu()
    if not self.system then return end
    
    if self.system == 'fivem-appearance' then
        exports['fivem-appearance']:startPlayerFading()
        exports['fivem-appearance']:openMenu({
            peds = true,
            components = false,
            props = false,
        })
    elseif self.system == 'illenium-appearance' then
        exports['illenium-appearance']:OpenPedsMenu()
    elseif self.system == 'ox_appearance' then
        exports.ox_appearance:open('peds')
    end
end

-- Set ped component (clothing item)
function Clothing:SetComponent(component, drawable, texture)
    if not self.system then return end
    
    if self.system == 'illenium-appearance' then
        exports['illenium-appearance']:setPedComponent(PlayerPedId(), component, drawable, texture)
    elseif self.system == 'fivem-appearance' then
        local appearance = exports['fivem-appearance']:getPlayerAppearance()
        if appearance and appearance.components then
            appearance.components[component] = { drawable = drawable, texture = texture }
            exports['fivem-appearance']:setPlayerAppearance(appearance)
        end
    elseif self.system == 'ox_appearance' then
        exports.ox_appearance:setPlayerComponent(component, drawable, texture)
    elseif self.system == 'codem-appearance' then
        exports['codem-appearance']:setPlayerComponent(component, drawable, texture)
    elseif self.system == 'qb-clothing' then
        exports['qb-clothing']:SetComponent(component, drawable, texture)
    end
end

-- Get component data
function Clothing:GetComponent(component)
    if not self.system then return nil end
    
    if self.system == 'illenium-appearance' then
        local pedAppearance = exports['illenium-appearance']:getPedAppearance(PlayerPedId())
        return pedAppearance.components[component]
    elseif self.system == 'fivem-appearance' then
        local appearance = exports['fivem-appearance']:getPlayerAppearance()
        return appearance and appearance.components and appearance.components[component]
    elseif self.system == 'ox_appearance' then
        return exports.ox_appearance:getPlayerComponent(component)
    elseif self.system == 'codem-appearance' then
        return exports['codem-appearance']:getPlayerComponent(component)
    end
    
    return nil
end

return Clothing
