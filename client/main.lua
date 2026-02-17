_G.UnixLib = {}
local Lib = _G.UnixLib

Lib.Core = require('shared.core')

local function p(...)
    if Config.Debug then
        print('[UnixLib] ', ...)
    end
end

Citizen.CreateThread(function()
    Wait(1000)
    Lib.Core.DetectAll()
    InitializeModules()
end)

function InitializeModules()
    p('Initializing modules...')

    Lib.Notifications = require('client.notifications.main')
    Lib.Notifications:Init()

    Lib.Target = require('client.target.main')
    Lib.Target:Init()

    Lib.ProgressBar = require('client.progressbar.main')
    Lib.ProgressBar:Init()

    Lib.Menu = require('client.menu.main')
    Lib.Menu:Init()

    Lib.Input = require('client.input.main')
    Lib.Input:Init()

    Lib.TextUI = require('client.textui.main')
    Lib.TextUI:Init()

    Lib.PolyZone = require('client.polyzone.main')
    Lib.PolyZone:Init()

    Lib.VehicleKeys = require('client.vehiclekeys.main')
    Lib.VehicleKeys:Init()

    Lib.Fuel = require('client.fuel.main')
    Lib.Fuel:Init()

    Lib.Clothing = require('client.clothing.main')
    Lib.Clothing:Init()

    Lib.Dispatch = require('client.dispatch.main')
    Lib.Dispatch:Init()

    p('All modules initialized!')
end

exports('UnixLib:GetCore', function() return Lib end)
exports('UnixLib:GetLib', function() return Lib end)
