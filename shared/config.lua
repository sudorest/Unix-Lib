-- UnixLib Configuration
-- This library auto-detects frameworks and systems, so manual configuration is optional

Config = Config or {}

-- Debug mode - enables verbose logging
Config.Debug = false

-- Language for locales (auto-detected if not set)
Config.Language = 'en'

-- Manual framework override (leave nil for auto-detect)
-- Options: 'esx', 'qbx', 'ox', nil
Config.Framework = nil

-- Manual SQL connector override (leave nil for auto-detect)
-- Options: 'oxmysql', 'mysql-async', 'ghmattimysql', nil
Config.SQLConnector = nil

-- Enable/disable specific modules (auto-detected if nil)
Config.Modules = {
    Framework = nil,     -- nil = auto-detect
    Inventory = nil,
    Notifications = nil,
    Target = nil,
    ProgressBar = nil,
    Menu = nil,
    Input = nil,
    TextUI = nil,
    PolyZone = nil,
    WeatherSync = nil,
    Dispatch = nil,
    VehicleKeys = nil,
    Fuel = nil,
    Clothing = nil,
    Interaction = nil,
}

-- Module preferences (used when multiple options available)
Config.Preferences = {
    Notifications = { 'ox_lib', 'qb', 'esx', 'okok', 'ps-ui', 'mythic' },
    Target = { 'ox_target', 'qb-target', 'qtarget' },
    ProgressBar = { 'ox_lib', 'qb' },
    Menu = { 'ox_lib', 'qb', 'nh-context', 'esx_context' },
    PolyZone = { 'ox_lib', 'polyzone' },
    VehicleKeys = { 'okokGarage', 'qs-vehiclekeys', 'qb-vehiclekeys', 'wasabi_carlock' },
    Fuel = { 'ox_fuel', 'LegacyFuel', 'ps-fuel', 'cdn-fuel' },
    Clothing = { 'fivem-appearance', 'illenium-appearance', 'qb-clothing', 'esx_skin' },
}

-- Global settings
Config.Locale = {
    Fallback = 'en',
    Path = 'locales/%s.json',
}

-- Auto-detection settings
Config.AutoDetect = {
    Enabled = true,
    Timeout = 5000, -- ms to wait for resources to start
    RetryInterval = 1000, -- ms between retries
}
