
local Manager = require('manager')
local InfoText = require('infotext')

local UI = {}

function UI.createCompletionDialog(state)
    local def = state.def

    local dialog = GUI.createDialog{
        icon = Icon.INFO,
        title = TheoTown.translate('$contracts_string_completed_title'),
        text = string.format(TheoTown.translate('$contracts_string_completed_text'), def.title, TheoTown.formatMoney(def.completion)),
        actions = {
            {
                icon = Icon.OK,
                text = Translation.control_ok
            }
        }
    }
end

function UI.createContractPreview(menu, def, state)
    local buttons = {}

    -- If possible, add accept button.
    if not state and Manager.canAccept() then
        table.insert(
            buttons,
            {
                icon = Icon.OK,
                text = TheoTown.translate('$contracts_string_accept'),
                golden = true,
                onClick = function()
                    Manager.accept(def.id)
                    menu.close()
                    UI.createContractsMenu()
                end
            }
        )
    end

    -- If possible, add cancel button.
    if state and state.status == 'active' then
        table.insert(
            buttons,
            {
                icon = Icon.CANCEL,
                text = TheoTown.translate('$contracts_string_cancel_button'),
                onClick = function()
                    -- Create cancellation confirmation dialog.
                    if Manager.canCancel(state) then
                        local dialog = GUI.createDialog{
                            icon = Icon.INFO,
                            title = TheoTown.translate('$contracts_string_cancel_title'),
                            text = string.format(TheoTown.translate('$contracts_string_cancel_text'), TheoTown.formatMoney(def.advance), TheoTown.formatMoney(def.cancellation)),
                            actions = {
                                {
                                    icon = Icon.OK,
                                    text = TheoTown.translate('$contracts_string_cancel_ok'),
                                    onClick = function()
                                        Manager.cancel(state)
                                        menu.close()
                                        UI.createContractsMenu()
                                    end
                                },
                                {
                                    icon = Icon.CANCEL,
                                    text = TheoTown.translate('$contracts_string_cancel_no')
                                }
                            }
                        }
                    -- Create insufficient money dialog.
                    else
                        local dialog = GUI.createDialog{
                            icon = Icon.INFO,
                            title = TheoTown.translate('$contracts_string_no_money_title'),
                            text = string.format(TheoTown.translate('$contracts_string_no_money_text'), TheoTown.formatMoney(def.advance), TheoTown.formatMoney(def.cancellation)),
                            actions = {
                                icon = Icon.OK,
                                text = Translation.control_ok
                            }
                        }
                    end
                end
            }
        )
    end

    -- Create the preview dialog.
    local preview = GUI.createDialog{
        icon = Icon.SETTINGS,
        title = def.title,
        text = def.text .. InfoText.get(def),
        height = 300,
        actions = buttons
    }

    -- Add a warning if max contract count has been reached.
    if not (state and state.status == 'active') and not Manager.canAccept() then
        local warning = preview.controls:addLabel{
            text = string.format(TheoTown.translate('$contracts_string_max_contract_count'), Manager.getMaxActive())
        }

        warning:setColor(154, 0, 0)
        warning:setAlignment(0, 0.5)
    end
end

function UI.addActiveContractRow(menu, parent, state)
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
        onClick = function() UI.createContractPreview(menu, state.def, state) end
    }

    local active_label = entry:addLabel{
        text = TheoTown.translate('$contracts_string_active')
    }

    active_label:setAlignment(1, 0.5)
    active_label:setPadding(0, 0, 32, 0)
    active_label:setColor(0, 154, 0)
end

function UI.addAvailableContractRow(menu, parent, def)
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
        onClick = function() UI.createContractPreview(menu, def) end
    }

    if Manager.canAccept() then
        local available_label = entry:addLabel{
            text = TheoTown.translate('$contracts_string_available')
        }

        available_label:setAlignment(1, 0.5)
        available_label:setPadding(0, 0, 32, 0)
        available_label:setColor(150, 150, 150)
    else
        label:setColor(150, 150, 150)
    end
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
        UI.addActiveContractRow(contractsMenu, listbox, state)
    end

    for _, def in pairs(Manager.getAvailable()) do
        UI.addAvailableContractRow(contractsMenu, listbox, def)
    end

    -- Add an active contract counter.
    local counter = contractsMenu.controls:addLabel{
        text = string.format(TheoTown.translate('$contracts_string_counter'), #Manager.getActive(), Manager.getMaxActive(), #Manager.getAvailable())
    }

    counter:setAlignment(0.5, 0)

    if #Manager.getActive() >= Manager.getMaxActive() then
        counter:setColor(154, 0, 0)
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

function UI.init()
    table.insert(Manager.onCompleted, UI.createCompletionDialog)
end

return UI
