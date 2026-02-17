# UnixLib

A universal FiveM library that auto-detects and abstracts common framework and resource integrations, providing a unified API across ox_core, qbx_core, qb-core, ESX, and more.

## Features

- **Auto-Detection** - Automatically detects your framework and resources
- **Unified APIs** - Single interface for notifications, progress bars, target, menus, and more
- **Framework Abstraction** - Write once, work on any framework
- **Fallback Support** - Native GTA fallbacks when no system is available

## Requirements

- FiveM server with Lua 5.4 support
- At least one supported framework: ox_core, qbx_core, qb-core, or ESX
- Optional: any supported resource listed below

## Installation

1. Download the latest release
2. Extract to your resources folder
3. Add `ensure unix_lib` to your server.cfg before other Unix resources
4. UnixLib will auto-detect all supported systems

## Supported Systems

### Frameworks
- ox_core
- qbx_core / qbx-core
- qb-core
- es_extended / esx

### SQL
- oxmysql
- mysql-async
- ghmattimysql

### Inventory
- ox_inventory
- qb-inventory
- codem-inventory
- tgiann-inventory
- mf-inventory

### Notifications
- ox_lib
- qb-core
- es_extended
- okokNotify
- ps-ui
- mythic_notify

### Target
- ox_target
- qb-target
- qtarget

### Progress Bar
- ox_lib
- qb-core

### Menu
- ox_lib
- qb-menu
- nh-context
- esx_menu_default
- esx_context

### Input
- ox_lib
- qb-input
- ps-ui

### TextUI
- ox_lib
- okokTextUI
- qb-core

### PolyZone
- ox_lib
- PolyZone

### Weather Sync
- cd_easytime
- qb-weathersync
- renewed-weathersync

### Dispatch
- ps-dispatch
- cd_dispatch
- qs-dispatch
- rcore_dispatch
- core_dispatch
- fea-dispatch
- origen_police

### Vehicle Keys
- okokGarage
- qs-vehiclekeys
- qb-vehiclekeys
- wasabi_carlock
- cd_garage
- mk_vehiclekeys

### Fuel
- ox_fuel
- LegacyFuel
- ps-fuel
- cdn-fuel
- lj-fuel
- renewed-fuel

### Clothing
- fivem-appearance
- illenium-appearance
- qb-clothing
- esx_skin
- ox_appearance
- codem-appearance

## Usage

### Initialization

```lua
-- UnixLib auto-initializes when the resource starts
-- Access detected systems via UnixLib.Core
```

### Checking Detected Systems

```lua
-- Get the detected framework
local framework = UnixLib.Core.GetFramework() -- 'ox', 'qbx', 'qb', or 'esx'

-- Check if a system is available
local hasTarget = UnixLib.Core.HasSystem('Target') -- true/false

-- Get all detected systems
local detected = UnixLib.Core.GetAllDetected()
```

### Notifications

```lua
UnixLib.Notifications:Notify({
    title = 'Title',
    message = 'Hello World',
    type = 'success', -- or 'error', 'info', 'warning'
    duration = 3000
})

-- Convenience methods
UnixLib.Notifications:Success('Operation complete!')
UnixLib.Notifications:Error('Something went wrong')
UnixLib.Notifications:Info('Here is some info')
UnixLib.Notifications:Warning('Be careful!')
```

### Progress Bar

```lua
-- Show progress bar
UnixLib.ProgressBar:Show({
    label = 'Processing...',
    duration = 2000,
    canCancel = false,
    disable = { car = true, move = true },
    useWhileDead = false
})

-- Async version
UnixLib.ProgressBar:ShowAsync({
    label = 'Loading...',
    duration = 3000
})
```

### Target

```lua
-- Add entity target
UnixLib.Target:AddTargetEntity({
    entity = entity,
    label = 'Interact',
    icon = 'fas fa-hand',
    event = 'myResource:event',
    job = 'police', -- optional job restriction
    distance = 2.0
})

-- Add model target
UnixLib.Target:AddTargetModel({
    model = `prop_box_01`,
    options = {
        {
            label = 'Open Box',
            icon = 'fas fa-box',
            event = 'myResource:openBox'
        }
    }
})

-- Add zone target
UnixLib.Target:AddTargetZone({
    name = 'myZone',
    coords = vector3(0, 0, 0),
    length = 2.0,
    width = 2.0,
    heading = 0.0,
    options = {
        {
            label = 'Enter',
            icon = 'fas fa-door-open',
            event = 'myResource:enter'
        }
    }
})

-- Remove zone
UnixLib.Target:RemoveZone('myZone')
```

### Menu

```lua
UnixLib.Menu:Open({
    header = 'Menu Title',
    items = {
        {
            title = 'Option 1',
            description = 'Description here',
            event = 'myResource:option1'
        },
        {
            title = 'Option 2',
            icon = 'fas fa-cog',
            event = 'myResource:option2',
            params = { id = 123 }
        }
    }
})
```

### TextUI

```lua
UnixLib.TextUI:Show({
    message = 'Press E to interact',
    icon = 'fas fa-hand'
})

UnixLib.TextUI:Hide()
```

### Input

```lua
UnixLib.Input:Open({
    type = 'text', -- 'text', 'number', 'password'
    label = 'Enter Name',
    default = 'John Doe',
    required = true
}, function(value)
    print('Input:', value)
end)
```

## Configuration

Edit `shared/config.lua`:

```lua
Config = Config or {}

Config.Debug = false -- Enable debug output
Config.Locale = 'en' -- Default locale
```

## Events

UnixLib emits events when systems are detected:

```lua
RegisterNetEvent('unix_lib:loaded', function(detected)
    print('UnixLib loaded with framework:', detected.Framework)
end)
```

## License

See LICENSE file for details.
