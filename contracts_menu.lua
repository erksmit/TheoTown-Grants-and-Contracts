
-- DOCUMENTATION

-- Available contract goal type arrays:
-- "buildings" (array of objects) - building ID "id" and optional building count "count"
-- "roads" (array of objects) - road ID "id" and optional road count "count"
-- "happiness" (array of objects) - happiness type name "type" and minimum happiness level "value" (between 0 and 1)
-- "population" (array of objects) - inhabitant count "count" and optional wealth level "level" (0, 1, or 2)
-- "income" (integer) - minimum combined city income

-- Available contract requirement types:
-- "rank" (integer) - minimum city rank (starting with 0)
-- "contracts completed" (array) - IDs of completed contracts
-- (UNIMPLEMENTED) "balance min" (integer) - minimum money available at hand
-- (UNIMPLEMENTED) "balance max" (integer) - maximum money available at hand
-- (UNIMPLEMENTED) "income min" (integer) - minimum combined city income
-- (UNIMPLEMENTED) "income max" (integer) - maximum combined city income

-- See util.json for predefined contracts.


-- Maximum number of contracts that can be active simultaneously.
local MAX_CONTRACT_COUNT = 2

-- Stuff. Pay it no mind.
local createContractsMenu
local contractsMenu
local checkGoals
local addListener

-- Contract data of active contracts that require daily condition checks (happiness, population requirements...).
local check_daily = {}

-- Contract data from JSON meta table, eg. name, text, rewards, etc.; indexed by contract ID.
local contracts_data = {}

function script:lateInit()
    Draft.getDrafts():forEach(function(draft)
        local meta = draft:getMeta()
        if meta ~= nil then
            if meta['tags'] ~= nil then
                if meta['tags']['contract'] ~= nil then
                    contracts_data[meta['contract id']] = meta
                end
            end
        end
    end)
end

-- Store active and completed contract IDs in the city.
local storage

function script:enterCity()
    storage = Util.optStorage(City.getStorage(), '$kulche_contracts_script_storage_00')

    -- Initialize arrays if they didn't exist before.
    if storage.activeContracts == nil then
        storage.activeContracts = {}
        storage.completedContracts = {}
    end

    -- Read building listeners of all active contracts.
    for _, contract_id in pairs(storage.activeContracts) do
        addListener(contracts_data[contract_id])
    end
end

-- Returns a table that contains unmet requirements of a specified contract. If the returned 'unmet' table is empty, the contract is available.
local function contractUnmetRequirements(contract)
    local requirements = contract['requirements']
    local unmet = {}

    -- Rank requirement.
    if requirements['rank'] ~= nil then
        local _, rank = City.getRank()
        if rank < requirements['rank'] then
            table.insert(unmet, { type = "rank", required = requirements['rank'], current = rank })
        end
    end

    -- Completed contracts requirement.
    if requirements['contracts completed'] ~= nil then
        for _, contract_id in pairs(requirements['contracts completed']) do
            if not Array(storage.completedContracts):contains(contract_id) then
                table.insert(unmet, { type = "contracts completed", id = contract_id })
            end
        end
    end

    return unmet
end

-- Helper function to check whether a contract requires daily checks.
local function needCheckDaily(contract)
    local goals = contract['goals']

    if goals['happiness'] ~= nil or goals['population'] ~= nil or goals['income'] ~= nil then return true end

    return false
end

-- Helper function to return internal happiness type fields instead of string names.
local function getHappinessType(name)
    local types = {
        ['education'] = City.HAPPINESS_EDUCATION,
        ['environment'] = City.HAPPINESS_ENVIRONMENT,
        ['fire department'] = City.HAPPINESS_FIREDEPARTMENT,
        ['free time'] = City.HAPPINESS_FREETIME,
        ['general'] = City.HAPPINESS_GENERAL,
        ['health'] = City.HAPPINESS_HEALTH,
        ['level'] = City.HAPPINESS_LEVEL,
        ['park'] = City.HAPPINESS_PARK,
        ['police'] = City.HAPPINESS_POLICE,
        ['religion'] = City.HAPPINESS_RELIGION,
        ['sport'] = City.HAPPINESS_SPORT,
        ['supply'] = City.HAPPINESS_SUPPLY,
        ['taxes'] = City.HAPPINESS_TAXES,
        ['transport'] = City.HAPPINESS_TRANSPORT,
        ['waste'] = City.HAPPINESS_WASTE,
        ['zone'] = City.HAPPINESS_ZONE
    }

    return types[name]
end

-- Will be called after contract completion.
local function completeContract(contract)
    City.earnMoney(contract['completion'])
    table.remove(storage.activeContracts, Array(storage.activeContracts):find(contract['contract id']))
    table.insert(storage.completedContracts, contract['contract id'])
    Array(check_daily):remove(contract)

    local dialog = GUI.createDialog{
        icon = Icon.INFO,
        title = TheoTown.translate('$contracts_string_completed_title'),
        text = string.format(TheoTown.translate('$contracts_string_completed_text'), contract['title'] or TheoTown.translate(contract['title id']), TheoTown.formatMoney(contract['completion'])),
        actions = {
            {
                icon = Icon.OK,
                text = Translation.control_ok
            }
        }
    }
end

-- Generate contract goals text to be displayed in contract preview window, and an ID table of all placeable drafts from contract goals (buildings and roads).
local function generateGoals(contract)
    local text = TheoTown.translate('$contracts_string_condition_title')
    local ids = {}
    local goals = contract['goals']

    -- 'Have x buildings of ID y in city' goal type.
    if goals['buildings'] ~= nil then
        for _, building in pairs(goals['buildings']) do
            local building_draft = Draft.getDraft(building['id'])
            local current = City.countBuildings(building_draft)
            local target = building['count'] or 1

            if current < target then
                text = text..'[✗] '
                table.insert(ids, building['id'])
            else text = text..'[✓] ' end
            text = text..string.format(TheoTown.translate('$contracts_string_condition_build'), building_draft:getTitle(), current, target)
        end
    end

    -- 'Have x roads of ID y in city' goal type.
    if goals['roads'] ~= nil then
        for _, road in pairs(goals['roads']) do
            local road_draft = Draft.getDraft(road['id'])
            local current = City.countRoads(road_draft)
            local target = road['count'] or 1

            if current < target then
                text = text..'[✗] '
                table.insert(ids, road['id'])
            else text = text..'[✓] ' end
            text = text..string.format(TheoTown.translate('$contracts_string_condition_build'), road_draft:getTitle(), current, target)
        end
    end

    -- 'Reach over x happiness of type y' goal type.
    if goals['happiness'] ~= nil then
        for _, happiness in pairs(goals['happiness']) do
            local happiness_name = happiness['type']
            local current = math.ceil(City.getHappiness(getHappinessType(happiness_name)) * 100 - 0.5)
            local target = happiness['value'] * 100

            if current < target then text = text..'[✗] ' else text = text..'[✓] ' end
            text = text..string.format(TheoTown.translate('$contracts_string_condition_happiness'), happiness_name, current, target)
        end
    end

    -- 'Reach over x population of level y' goal type.
    if goals['population'] ~= nil then
        for _, population in pairs(goals['population']) do
            local population_level = population['level']
            local target = population['count']

            if population_level == nil then
                local current = City.getPeople()
                
                if current < target then text = text..'[✗] ' else text = text..'[✓] ' end
                text = text..string.format(TheoTown.translate('$contracts_string_condition_population_no_level'), current, target)
            else
                local current = City.getPeople(population_level)
                
                if current < target then text = text..'[✗] ' else text = text..'[✓] ' end
                text = text..string.format(TheoTown.translate('$contracts_string_condition_population_with_level'), population_level + 1, current, target)
            end
        end
    end

    -- 'Reach x income' goal type.
    if goals['income'] ~= nil then
        local current = TheoTown.formatMoney(City.getIncome())
        local target = TheoTown.formatMoney(goals['income'])

        if current < target then text = text..'[✗] ' else text = text..'[✓] ' end
        text = text..string.format(TheoTown.translate('$contracts_string_condition_income'), current, target)
    end
    
    return text, ids
end

-- Create preview dialog for the selected contract.
local function createContractPreview(menu, contract_id, contract, almost_available)
    local goals_text, missing_buildings = generateGoals(contract)
    -- Dynamically create action buttons depending on contract state (active or inactive).
    local buttons = Array()
    if not almost_available then
        if Array(storage.activeContracts):contains(contract_id) then
            if missing_buildings[1] ~= nil then
                buttons:add(
                    {
                        icon = Icon.EYE,
                        text = TheoTown.translate('$contracts_string_find'),
                        onClick = function()
                            menu.close()
                            City.createDraftDrawer(missing_buildings[1]).select()
                        end
                    }
                )
            end
            buttons:add(
                {
                    icon = Icon.CANCEL,
                    text = TheoTown.translate('$contracts_string_cancel_button'),
                    onClick = function()
                        if City.getMoney() >= contract['cancellation'] then
                            local dialog = GUI.createDialog{
                                icon = Icon.INFO,
                                title = TheoTown.translate('$contracts_string_cancel_title'),
                                text = string.format(TheoTown.translate('$contracts_string_cancel_text'), TheoTown.formatMoney(contract['advance']), TheoTown.formatMoney(contract['cancellation'])),
                                actions = {
                                    {
                                        icon = Icon.OK,
                                        text = TheoTown.translate('$contracts_string_cancel_ok'),
                                        onClick = function()
                                            City.spendMoney(contract['advance'] + contract['cancellation'])
                                            menu.close()
                                            table.remove(storage.activeContracts, Array(storage.activeContracts):find(contract_id))
                                            Array(check_daily):remove(contract)
                                            
                                            -- Reopen the contracts menu to reflect changes.
                                            createContractsMenu()
                                        end
                                    },
                                    {
                                        icon = Icon.CANCEL,
                                        text = TheoTown.translate('$contracts_string_cancel_no')
                                    }
                                }
                            }
                        else
                            local dialog = GUI.createDialog{
                                icon = Icon.INFO,
                                title = TheoTown.translate('$contracts_string_no_money_title'),
                                text = string.format(TheoTown.translate('$contracts_string_no_money_text'), TheoTown.formatMoney(contract['advance']), TheoTown.formatMoney(contract['cancellation'])),
                                actions = {
                                    icon = Icon.OK,
                                    text = Translation.control_ok
                                }
                            }
                        end
                    end
                }
            )
        else
            -- If contract is not already active, check if it's possible to take any more contracts.
            if #storage.activeContracts < MAX_CONTRACT_COUNT then
                buttons:add(
                    {
                        icon = Icon.OK,
                        text = TheoTown.translate('$contracts_string_accept'),
                        golden = true,
                        onClick = function()
                            TheoTown.playSound('$contracts_sound_sign_00')
                            City.earnMoney(contract['advance'])
                            menu.close()
                            table.insert(storage.activeContracts, contract_id)

                            -- Begin contract goal checks.
                            addListener(contract)
                            checkGoals(contract)

                            if needCheckDaily(contract) then table.insert(check_daily, contract) end
                                            
                            -- Reopen the contracts menu to reflect changes.
                            createContractsMenu()
                        end
                    }
                )
            end
        end
    end

    -- Create the actual preview dialog.
    local preview = GUI.createDialog{
        icon = Icon.SETTINGS,
        title = contract['title'] or TheoTown.translate(contract['title id']),
        text = (contract['text'] or TheoTown.translate(contract['text id']))..'\n\n'..goals_text..string.format(TheoTown.translate('$contracts_string_rewards'), TheoTown.formatMoney(contract['advance']), TheoTown.formatMoney(contract['completion']), TheoTown.formatMoney(contract['cancellation'])),
        height = 300,
        actions = buttons
    }

    -- Add warning text if city rank is too low to accept contract or maximum contract count has already been reached.
    if not Array(storage.activeContracts):contains(contract_id) then
        local warning

        if almost_available then
            warning = preview.controls:addLabel{
                text = TheoTown.translate('$contracts_string_rank_low')
            }
        elseif #storage.activeContracts == MAX_CONTRACT_COUNT then
            warning = preview.controls:addLabel{
                text = string.format(TheoTown.translate('$contracts_string_max_contract_count'), MAX_CONTRACT_COUNT)
            }
        end
        warning:setColor(154, 0, 0)
        warning:setAlignment(0, 0.5)
    end
end

-- Create the main contracts browser dialog.
createContractsMenu = function()
    -- Menu dialog.
    contractsMenu = GUI.createDialog{
        icon = Icon.SETTINGS,
        title = TheoTown.translate('$contracts_string_menu_title'),
        height = 300,
        actions = {}
    }

    -- Available contract list.
    local listbox = contractsMenu.content:addListBox{
        x = 10,
        y = 10,
        width = -10,
        height = -10
    }

    -- Create lookup table for active contracts.
    local active_lookup = {}
    for _, key in ipairs(storage.activeContracts) do
        active_lookup[key] = true
    end

    -- Extract contract IDs from data.
    local ids = {}
    for id in pairs(contracts_data) do
        table.insert(ids, id)
    end

    -- Sort contracts so that active ones come first.
    table.sort(ids, function(a, b)
        local a_in_active = active_lookup[a] and 1 or 0
        local b_in_active = active_lookup[b] and 1 or 0

        if a_in_active ~= b_in_active then
            return a_in_active > b_in_active
        end
    end)

    local availaible_contract_count = 0
    local almost_available = {}

    -- List all available contracts.
    for _, contract_id in ipairs(ids) do
        local contract = contracts_data[contract_id]    

        if not Array(storage.completedContracts):contains(contract_id) then
            local unmet = contractUnmetRequirements(contract)

            if #unmet == 0 then
                availaible_contract_count = availaible_contract_count + 1
                local entry = listbox:addCanvas{
                    h = 30
                }
                local label = entry:addLabel{
                    text = contract['title'] or TheoTown.translate(contract['title id']),
                    width = -80,
                    x = 5
                }
                local button = entry:addButton{
                    x = -30,
                    width = 30,
                    icon = Icon.INFO,
                    onClick = function() createContractPreview(contractsMenu, contract_id, contract, false) end
                }
                if Array(storage.activeContracts):contains(contract_id) then
                    local active_label = entry:addLabel{
                        text = TheoTown.translate('$contracts_string_active')
                    }
                    active_label:setAlignment(1, 0.5)
                    active_label:setPadding(0, 0, 32, 0)
                    active_label:setColor(0, 154, 0)
                elseif #storage.activeContracts >= MAX_CONTRACT_COUNT then
                    label:setColor(150, 150, 150)
                else
                    local available_label = entry:addLabel{
                        text = TheoTown.translate('$contracts_string_available')
                    }
                    available_label:setAlignment(1, 0.5)
                    available_label:setPadding(0, 0, 32, 0)
                    available_label:setColor(150, 150, 150)
                end
            else
                if #unmet == 1 and unmet[1].type == "rank" then
                    if unmet[1].required - unmet[1].current == 1 then
                        table.insert(almost_available, contract_id)
                    end
                end
            end
        end
    end

    -- List contracts that are almost available (city rank is 1 rank lower than requirement) at the bottom of the list.
    for _, contract_id in ipairs(almost_available) do
        local contract = contracts_data[contract_id]
        local entry = listbox:addCanvas{
            h = 30
        }
        local label = entry:addLabel{
            text = contract['title'] or TheoTown.translate(contract['title id']),
            width = -80,
            x = 5
        }
        label:setColor(150, 150, 150)
        local button = entry:addButton{
            x = -30,
            width = 30,
            icon = Icon.INFO,
            onClick = function() createContractPreview(contractsMenu, contract_id, contract, true) end
        }
        local available_label = entry:addLabel{
            text = TheoTown.translate('$contracts_string_locked')
        }
        available_label:setAlignment(1, 0.5)
        available_label:setPadding(0, 0, 32, 0)
        available_label:setColor(150, 150, 150)
    end


    -- Add a notification when there are no contracts available.
    if availaible_contract_count == 0 then
        local notification = listbox:addTextFrame{
            text = TheoTown.translate('$contracts_string_not_available')
        }
        notification:setAlignment(0.5, 0.5)
        notification:setColor(150, 150, 150)
    end

    -- Add an active contract counter.
    local counter = contractsMenu.controls:addLabel{
        text = string.format(TheoTown.translate('$contracts_string_counter'), #storage.activeContracts, MAX_CONTRACT_COUNT, availaible_contract_count - #storage.activeContracts)
    }

    counter:setAlignment(0.5, 0)

    if #storage.activeContracts == MAX_CONTRACT_COUNT then
        counter:setColor(154, 0, 0)
    end
end

-- Add contracts button to the sidebar.
function script:buildCityGUI()
    if not City.isReadonly() and not City.isSandbox() then
        local sidebar = GUI.get('sidebarLine')
        local size = sidebar:getFirstPart():getChild(2):getWidth()
        local button = sidebar:getFirstPart():addButton{
            width = size,
            height = size,
            icon = Icon.SETTINGS,
            frameDefault = Icon.NP_BLUE_BUTTON,
            frameDown = Icon.NP_BLUE_BUTTON_PRESSED,
            onClick = function() createContractsMenu() end
        }
    end
end

-- Check if goals of a specific contract are fulfilled and complete said contract if they are.
checkGoals = function(contract)
    local goals = contract['goals']

    -- 'Have buildings in city' goal type.
    if goals['buildings'] ~= nil then
        for _, building in pairs(goals['buildings']) do
            local building_draft = Draft.getDraft(building['id'])
            if City.countBuildings(building_draft) < (building['count'] or 1) then return end
        end
    end

    -- 'Have roads in city' goal type.
    if goals['roads'] ~= nil then
        for _, road in pairs(goals['roads']) do
            local road_draft = Draft.getDraft(road['id'])
            if City.countRoads(road_draft) < (road['count'] or 1) then return end
        end
    end

    -- 'Reach over x happiness of type y' goal type.
    if goals['happiness'] ~= nil then
        for _, happiness in pairs(goals['happiness']) do
            local happiness_name = happiness['type']
            if City.getHappiness(getHappinessType(happiness_name)) < happiness['value'] then return end
        end
    end

    -- 'Reach over x population of level y' goal type.
    if goals['population'] ~= nil then
        for _, population in pairs(goals['population']) do
            local population_level = population['level']
            if City.getPeople(population_level) < population['count'] then return end
        end
    end

    -- 'Reach x income' goal type.
    if goals['income'] ~= nil then
        if City.getIncome() < goals['income'] then return end
    end

    -- If no incomplete goals have been found, complete the contract.
    completeContract(contract)
end

-- Add building listeners to every building related to a specific contract (if contract conditions require).
addListener = function(contract)
    local goals = contract['goals']

    if goals['buildings'] ~= nil then
        for _, building in pairs(goals['buildings']) do
            local building_draft = Draft.getDraft(building['id'])
            City.addBuildingListener{
                draft = building_draft,
                added = function() checkGoals(contract) end
            }
        end
    end

    if goals['roads'] ~= nil then
        for _, road in pairs(goals['roads']) do
            local road_draft = Draft.getDraft(road['id'])
            City.addRoadListener{
                draft = road_draft,
                added = function() checkGoals(contract) end
            }
        end
    end
end

-- Run daily checks.
function script:nextDay()
    if #check_daily ~= 0 then
        for _, contract in pairs(check_daily) do
            checkGoals(contract)
        end
    end
end
