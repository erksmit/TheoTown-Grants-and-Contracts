
-- This is the core of the plugin that holds the other modules together.

local Definitions = require('definitions')
local Storage = require('storage')
local Manager = require('manager')
local Requirements = require('requirements')
local UI = require('ui')
local Assets = require('assets')
local Settings = require('settings')

local storage

UI.init()

function script:init()
    Assets.init()
    Settings.init()
end

function script:lateInit()
    Definitions.load()
end

function script:settings()
    return Settings.update()
end

function script:enterCity()
    storage = Storage.init()
    Manager.initCity()
    Requirements.initCity()
end

function script:buildCityGUI()
    UI.addSidebarButton()

    if Settings.getDisplayGoals() then UI.addProgressDisplay() end
end

-- Perform daily checks for the contracts that require them.
function script:nextDay()
    for _, state in pairs(storage.contracts.active) do
        if state.needsDailyCheck or state._dirty then
            state._dirty = nil
            Manager.checkCompletion(state)
        end
    end
end
