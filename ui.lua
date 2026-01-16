
local Manager = require('manager')

local UI = {}

function UI.addActiveContractRow(parent, state)
    local entry = parent:addCanvas{
        h = 30
    }

    local label = entry:addLabel{
        text = state.def.title,
        width = -80,
        x = 5
    }

    local button = entry:addButton{
        x = -30,
        width = 30,
        icon = Icon.INFO,
        onClick = function() Debug.toast('click!') end
    }

    local active_label = entry:addLabel{
        text = TheoTown.translate('$contracts_string_active')
    }

    active_label:setAlignment(1, 0.5)
    active_label:setPadding(0, 0, 32, 0)
    active_label:setColor(0, 154, 0)
end

function UI.addAvailableContractRow(parent, def)
    local entry = parent:addCanvas{
        h = 30
    }

    local label = entry:addLabel{
        text = def.title,
        width = -80,
        x = 5
    }

    local button = entry:addButton{
        x = -30,
        width = 30,
        icon = Icon.INFO,
        onClick = function() Debug.toast('click!') end
    }
end

function UI.createContractsMenu()
    local contractsMenu = GUI.createDialog{
        icon = Icon.SETTINGS,
        title = TheoTown.translate('$contracts_string_menu_title'),
        height = 300,
        actions = {}
    }

    local listbox = contractsMenu.content:addListBox{
        x = 10,
        y = 10,
        width = -10,
        height = -10
    }

    -- List all available/active contracts.
    for _, state in pairs(Manager.getActive()) do
        UI.addActiveContractRow(listbox, state)
    end

    for _, def in pairs(Manager.getAvailable()) do
        UI.addAvailableContractRow(listbox, def)
    end
end

function UI.addSidebarButton()
    if not City.isReadonly() and not City.isSandbox() then
        local sidebar = GUI.get('sidebarLine')
        local size = sidebar:getFirstPart():getChild(2):getWidth()
        local button = sidebar:getFirstPart():addButton{
            width = size,
            height = size,
            icon = Icon.SETTINGS,
            frameDefault = Icon.NP_BLUE_BUTTON,
            frameDown = Icon.NP_BLUE_BUTTON_PRESSED,
            onClick = function() UI.createContractsMenu() end
        }
    end
end

return UI
