_G.UnixLib = {}
local Lib = _G.UnixLib

Lib.Core = require('shared.core')

local function p(...)
    if Config.Debug then
        print('[UnixLib:Server] ', ...)
    end
end

Lib.Core.DetectAll()

function InitializeServerModules()
    p('Initializing server modules...')

    Lib.Inventory = require('server.inventory.main')
    Lib.Inventory:Init()

    Lib.Groups = require('server.groups.main')
    Lib.Groups:Init()

    p('Server modules initialized!')
end

InitializeServerModules()

exports('UnixLib:GetCore', function() return Lib end)
exports('UnixLib:GetLib', function() return Lib end)

Lib.Callback = {}

function Lib.Callback:Register(name, func)
    RegisterServerEvent(('UnixLib:callback:%s'):format(name), func)
end

function Lib.Callback:Trigger(source, name, cb)
    TriggerServerEvent(('UnixLib:callback:%s'):format(name), cb)
end

return Lib
