-- UnixLib Input Module
-- Unified input/dialog API

local Input = {}
Input.__index = Input

function Input:Init()
    local system = UnixLib.Core.GetSystem('Input')
    self.system = system
    self.available = system ~= nil
    
    if self.available then
        UnixLib.Print('Input: Using ' .. system)
    else
        UnixLib.Print('Input: No system detected')
    end
end

-- Show text input
function Input:TextInput(params)
    params = params or {}
    local placeholder = params.placeholder or 'Enter text...'
    local default = params.default or ''
    local title = params.title or 'Input'
    local maxLength = params.maxLength or 255
    
    if self.system == 'ox_lib' then
        local result = exports.ox_lib:inputDialog(title, {
            {
                type = 'input',
                label = placeholder,
                default = default,
                max = maxLength,
            }
        })
        return result and result[1]
    elseif self.system == 'qb-input' then
        local result = exports['qb-input']:ShowOpenTextField({
            {
                label = placeholder,
                name = 'input',
                type = 'text',
                default = default,
                text = '',
            }
        })
        return result and result.input
    elseif self.system == 'ps-ui' then
        return exports['ps-ui']:TextInput(title, placeholder, maxLength, default)
    end
    
    return nil
end

-- Show number input
function Input:NumberInput(params)
    params = params or {}
    local placeholder = params.placeholder or 'Enter number...'
    local default = params.default or 0
    local title = params.title or 'Input'
    
    if self.system == 'ox_lib' then
        local result = exports.ox_lib:inputDialog(title, {
            {
                type = 'number',
                label = placeholder,
                default = tostring(default),
            }
        })
        return result and tonumber(result[1])
    end
    
    return nil
end

-- Show checkbox
function Input:Checkbox(params)
    params = params or {}
    local label = params.label or 'Confirm'
    local title = params.title or 'Confirm'
    
    if self.system == 'ox_lib' then
        return exports.ox_lib:alertDialog({
            header = title,
            content = label,
            centered = true,
        })
    end
    
    return false
end

-- Show choice/input dialog
function Input:Choice(params)
    params = params or {}
    local options = params.options or {}
    local title = params.title or 'Select'
    
    if self.system == 'ox_lib' then
        local choices = {}
        for i, opt in ipairs(options) do
            choices[i] = opt.label or opt
        end
        return exports.ox_lib:selectChoice(title, choices)
    end
    
    return nil
end

return Input
