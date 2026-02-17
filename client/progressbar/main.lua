-- UnixLib ProgressBar Module
-- Unified progressbar API

local ProgressBar = {}
ProgressBar.__index = ProgressBar

function ProgressBar:Init()
    local system = UnixLib.Core.GetSystem('ProgressBar')
    self.system = system
    self.available = system ~= nil
    
    if self.available then
        UnixLib.Print('ProgressBar: Using ' .. system)
    else
        UnixLib.Print('ProgressBar: No system detected')
    end
end

-- Show progress bar
function ProgressBar:Show(params)
    if not self.available then
        -- Fallback to simple native progress
        return self:ShowNative(params)
    end
    
    params = params or {}
    local label = params.label or 'Loading...'
    local duration = params.duration or 2000
    local canCancel = params.canCancel or false
    
    if self.system == 'ox_lib' then
        exports.ox_lib:progressBar({
            label = label,
            duration = duration,
            canCancel = canCancel,
            disable = params.disable,
            position = 'bottom',
        })
    elseif self.system == 'qb-core' then
        exports['qb-core']:ProgressBar(label, duration, canCancel, params.useWhileDead, params.canCancel)
    end
end

-- Async progress bar (returns promise-like result)
function ProgressBar:ShowAsync(params)
    return promise.new(function(resolve)
        local result = self:Show(params)
        Wait(params.duration or 2000)
        resolve(true)
    end)
end

-- Simple fallback using native GTA
function ProgressBar:ShowNative(params)
    params = params or {}
    local label = params.label or 'Loading...'
    local duration = params.duration or 2000
    
    local scaleform = RequestScaleformMovie('MIDSIZED_MESSAGE')
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    
    BeginScaleformMovieMethod(scaleform, 'SHOW_MIDSIZED_MESSAGE')
    ScaleformMovieMethodAddParamTextureNameString(label)
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()
    
    local startTime = GetGameTimer()
    while GetGameTimer() - startTime < duration do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        Wait(0)
    end
    
    SetScaleformMovieAsNoLongerNeeded(scaleform)
end

return ProgressBar
