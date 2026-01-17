
local Definitions = require('definitions')
local Storage = require('storage')
local Manager = require('manager')
local Requirements = require('requirements')
local UI = require('ui')

local storage

UI.init()

function script:lateInit()
    Definitions.load()
end

function script:enterCity()
    storage = Storage.init()
    Manager.initCity()
    Requirements.initCity()
end

function script:buildCityGUI()
    UI.addSidebarButton()
end

function script:nextDay()
    for _, state in pairs(storage.contracts.active) do
        if state.needsDailyCheck or state._dirty then
            state._dirty = nil
            Manager.checkCompletion(state)
        end
    end
end
