-- UnixLib Menu Module
-- Unified menu API

local Menu = {}
Menu.__index = Menu

function Menu:Init()
    local system = UnixLib.Core.GetSystem('Menu')
    self.system = system
    self.available = system ~= nil
    self.currentMenu = nil
    
    if self.available then
        UnixLib.Print('Menu: Using ' .. system)
    else
        UnixLib.Print('Menu: No system detected')
    end
end

-- Open menu
function Menu:Open(params)
    if not self.available then return end
    
    params = params or {}
    local title = params.title or 'Menu'
    local options = params.options or {}
    
    if self.system == 'ox_lib' then
        exports.ox_lib:registerContext(options)
        exports.ox_lib:showContext(options.id)
    elseif self.system == 'qb-menu' then
        exports['qb-menu']:openMenu(options)
    elseif self.system == 'nh-context' then
        exports['nh-context']:CreateMenu(options)
    elseif self.system == 'esx_menu_default' then
        exports.esx_menu_default:display(options)
    elseif self.system == 'esx_context' then
        exports.esx_context:openMenu(options)
    end
end

-- Close menu
function Menu:Close()
    if not self.available then return end
    
    if self.system == 'ox_lib' then
        exports.ox_lib:hideContext()
    elseif self.system == 'qb-menu' then
        exports['qb-menu']:closeMenu()
    elseif self.system == 'nh-context' then
        exports['nh-context']:CloseMenu()
    elseif self.system == 'esx_menu_default' then
        exports.esx_menu_default:closeMenu()
    elseif self.system == 'esx_context' then
        exports.esx_context:closeMenu()
    end
end

-- Create menu option
function Menu:CreateOption(params)
    params = params or {}
    local label = params.label or 'Option'
    local description = params.description or ''
    local icon = params.icon
    local event = params.event
    local serverEvent = params.serverEvent
    local input = params.input
    
    local option = {
        label = label,
        description = description,
        icon = icon,
    }
    
    if event then
        option.action = function()
            TriggerEvent(event, params.params)
        end
    elseif serverEvent then
        option.action = function()
            TriggerServerEvent(serverEvent, params.params)
        end
    elseif input then
        option.action = function()
            self:ShowInput(input)
        end
    end
    
    return option
end

-- Helper to create ox_lib context
function Menu:CreateContext(params)
    params = params or {}
    return {
        id = params.id or 'menu',
        title = params.title or 'Menu',
        options = params.options or {},
        menu = params.menu,
    }
end

return Menu
