-- UnixLib Locales Module
-- Internationalization support

local Locales = {}
Locales.__index = Locales

local currentLocale = 'en'
local translations = {}

-- Load locale file
function Locales:Load(locale)
    local file = LoadResourceFile(GetCurrentResourceName(), ('locales/%s.json'):format(locale))
    if file then
        translations = json.decode(file)
        currentLocale = locale
        UnixLib.Print('Locale loaded: ' .. locale)
        return true
    else
        UnixLib.Warning('Locale not found: ' .. locale)
        return false
    end
end

-- Get translation
function Locales:Get(key, replacements)
    local text = translations[key] or key
    
    if replacements then
        for k, v in pairs(replacements) do
            text = text:gsub(('{%s}'):format(k), v)
        end
    end
    
    return text
end

-- Set locale
function Locales:Set(locale)
    return self:Load(locale)
end

-- Get current locale
function Locales:GetCurrent()
    return currentLocale
end

-- Get all translations
function Locales:GetAll()
    return translations
end

-- Initialize with config locale
function Locales:Init()
    local locale = Config.Language or 'en'
    self:Load(locale)
end

return Locales
