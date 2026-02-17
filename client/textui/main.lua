-- UnixLib TextUI Module
-- Unified TextUI/TextDraw API

local TextUI = {}
TextUI.__index = TextUI

function TextUI:Init()
    local system = UnixLib.Core.GetSystem('TextUI')
    self.system = system
    self.visible = false
    
    if system then
        UnixLib.Print('TextUI: Using ' .. system)
    else
        UnixLib.Print('TextUI: No system detected')
    end
end

-- Show TextUI
function TextUI:Show(params)
    if not self.system then return end
    
    params = params or {}
    local message = params.message or ''
    local type = params.type or 'info'
    
    if self.system == 'ox_lib' then
        exports.ox_lib:showTextUI(message)
    elseif self.system == 'okokTextUI' then
        exports.okokTextUI:DrawTextUI(message, type)
    elseif self.system == 'qb-core' then
        exports['qb-core']:DrawText(message, type)
    end
    
    self.visible = true
end

-- Hide TextUI
function TextUI:Hide()
    if not self.system then return end
    
    if self.system == 'ox_lib' then
        exports.ox_lib:hideTextUI()
    elseif self.system == 'okokTextUI' then
        exports.okokTextUI:ClearTextUI()
    elseif self.system == 'qb-core' then
        exports['qb-core']:HideText()
    end
    
    self.visible = false
end

-- Toggle TextUI
function TextUI:Toggle(params)
    if self.visible then
        self:Hide()
    else
        self:Show(params)
    end
end

return TextUI
