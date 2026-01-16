
local Definitions = require('definitions')
local Storage = require('storage')
local Manager = require('manager')
local Requirements = require('requirements')
local UI = require('ui')


function script:lateInit()
    Definitions.load()
end

function script:enterCity()
    Storage.init()
    Manager.initCity()
    Requirements.initCity()
end

function script:buildCityGUI()
    UI.addSidebarButton()
end
