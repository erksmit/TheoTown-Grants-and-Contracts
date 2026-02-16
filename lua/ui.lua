
-- This module handles all things UI related. No significant logic happens here.

local Manager = require('manager')
local InfoText = require('infotext')
local Assets = require('assets')

local UI = {}

-- Create the notification that pops up after a contract is completed.
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

-- Create the preview dialog for a select contract.
function UI.createContractPreview(menu, def, state, status)
    local buttons = {}

    -- If possible, add accept button.
    if not state and not status and Manager.canAccept() then
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

    -- Add control buttons for active contract.
    if state and state.status == 'active' then

        -- Find building button.
        local missing_id = Manager.getNextAction(state.def)
        if missing_id then
            table.insert(
                buttons,
                {
                    icon = Icon.EYE,
                    text = TheoTown.translate('$contracts_string_find'),
                    onClick = function()
                        menu.close()
                        City.createDraftDrawer(missing_id).select()
                    end
                }
            )
        end

        -- Cancel button.
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
        icon = def.issuer.icon,
        title = def.title,
        text = def.text .. InfoText.getPreview(def),
        height = 300,
        actions = buttons
    }


    -- Add a warning if a contract is almost available.
    if status then
        local text

        if status == 'no_rank' then text = TheoTown.translate('$contracts_string_rank_low') end
        if status == 'no_contracts' then text = TheoTown.translate('$contracts_string_required_contracts_missing') end

        local warning = preview.controls:addLabel{
            text = text
        }

        warning:setColor(154, 0, 0)
        warning:setAlignment(0, 0.5)

    -- Add a warning if max contract count has been reached.
    elseif not (state and state.status == 'active') and not Manager.canAccept() then
        local warning = preview.controls:addLabel{
            text = string.format(TheoTown.translate('$contracts_string_max_contract_count'), Manager.getMaxActive())
        }

        warning:setColor(154, 0, 0)
        warning:setAlignment(0, 0.5)
    end
end

-- Add active contracts to the top of the list.
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

    -- Add a green 'active' label next to the contract.
    local active_label = entry:addLabel{
        text = TheoTown.translate('$contracts_string_active')
    }

    active_label:setAlignment(1, 0.5)
    active_label:setPadding(0, 0, 32, 0)
    active_label:setColor(0, 154, 0)
end

-- Add available contracts to the middle of the list.
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

    -- Add a gray 'available' label next to the contract (also if max contract count has been reached).
    local available_label = entry:addLabel{
        text = TheoTown.translate('$contracts_string_available')
    }

    available_label:setAlignment(1, 0.5)
    available_label:setPadding(0, 0, 32, 0)
    available_label:setColor(150, 150, 150)

    -- Gray out the contract if max contract count has been reached.
    if not Manager.canAccept() then
        label:setColor(150, 150, 150)
    end
end

-- Add almost available contracts to the bottom of the list.
function UI.addAlmostAvailableContractRow(menu, parent, def, status)
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
        onClick = function() UI.createContractPreview(menu, def, nil, status) end
    }

    -- Add a gray 'locked' label next to the contract.
    local locked_label = entry:addLabel{
        text = TheoTown.translate('$contracts_string_locked')
    }

    locked_label:setAlignment(1, 0.5)
    locked_label:setPadding(0, 0, 32, 0)
    locked_label:setColor(150, 150, 150)

    -- Gray out the contract.
    label:setColor(150, 150, 150)
end

-- Create the base contract browser dialog.
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

    local isEmpty = true

    -- List all active/available/almost available contracts.
    for _, state in pairs(Manager.getActive()) do
        UI.addActiveContractRow(contractsMenu, listbox, state)
        isEmpty = false
    end

    for _, def in pairs(Manager.getAvailable()) do
        UI.addAvailableContractRow(contractsMenu, listbox, def)
        isEmpty = false
    end

    for _, entry in pairs(Manager.getAlmostAvailable()) do
        UI.addAlmostAvailableContractRow(contractsMenu, listbox, entry.def, entry.status)
        isEmpty = false
    end

    -- Add an info text if no contracts are available.
    if isEmpty then
        local label = listbox:addTextFrame{
            text = TheoTown.translate('$contracts_string_not_available')
        }

        label:setAlignment(0.5, 0.5)
        label:setColor(150, 150, 150)
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

-- Add the button to the sidebar.
function UI.addSidebarButton()
    if not City.isReadonly() and not City.isSandbox() and not DSA.isInMoon() then
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

local function getProgressHeight()
    local states = Manager.getActive()
    if not states or #states == 0 then return 0 end

    local lines = 0

    for _, state in ipairs(states) do
        local display = InfoText.getDisplay(state.def)
        lines = lines + #display
    end

    return lines * 15
end

-- Display active contract status on the screen (relative to the minimap).
function UI.addProgressDisplay()
    local minimap = GUI.get('cmdMinimap')
    local minimapX, minimapY = minimap:getAbsoluteX(), minimap:getAbsoluteY()
    local minimapW = minimap:getWidth()

    local canvas = GUI.getRoot():addCanvas{
        w = 0,
        h = 0,
        x = minimapX + minimapW,
        y = minimapY,
        onDraw = function(self, x, y, w, h)

            -- Draw the gradient background.
            local progressW = 180
            local progressH = getProgressHeight()

            Drawing.drawImageRect(Assets.FRAMES.GOAL_BACKGROUND, x - progressW, y - progressH, progressW, progressH)

            -- Draw goal information.
            local states = Manager.getActive()
            if not states then return end

            local offset = 0

            for _, state in ipairs(states) do
                local display = InfoText.getDisplay(state.def)

                for _, entry in ipairs(display) do
                    Drawing.setColor(entry.color.r, entry.color.g, entry.color.b)
                    Drawing.drawText(entry.text, x + w, y - entry.offset - offset + h, nil, 1, 1)
                end

                offset = offset + (#display * 15)
            end
        end
    }

    canvas:setChildIndex(1) -- Put the display under the minimap.
    canvas:setTouchThrough(true)
end

function UI.init()
    table.insert(Manager.onCompleted, UI.createCompletionDialog)
end

return UI
