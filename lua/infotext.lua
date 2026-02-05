
-- This module handles the generation of contract information strings for use in UI. Information contrains goals and rewards.

local Definitions = require('definitions')

local InfoText = {}

local function getStatusString(status)
    if status then return '[✓] '
    else return '[✗] ' end
end

-- For the following function: pos is the position of the status box. It can be either 0 for left, or 1 for right.
function InfoText.buildings(goal, pos)
    local draft = Draft.getDraft(goal.id)
    local current = City.countBuildings(draft)
    local target = goal.count
    local text = ''

    if target == 0 then
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target) .. getStatusString(current <= target)
        else text = getStatusString(current <= target) .. string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target) end
    else
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target) .. getStatusString(current >= target)
        else text = getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target) end
    end

    return text
end

function InfoText.roads(goal, pos)
    local draft = Draft.getDraft(goal.id)
    local current = City.countRoads(draft)
    local target = goal.count
    local text = ''

    if target == 0 then
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target) .. getStatusString(current <= target)
        else text = getStatusString(current <= target) .. string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target) end
    else
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target) .. getStatusString(current >= target)
        else text = getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target) end
    end

    return text
end

function InfoText.population(goal, pos)
    local level = goal.level
    local current = City.getPeople(level)
    local target = goal.count
    local text = ''

    if level then
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_population_with_level'), level + 1, TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false)) .. getStatusString(current >= target)
        else text = getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_population_with_level'), level + 1, TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false)) end
    else
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_population_no_level'), TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false)) .. getStatusString(current >= target)
        else text = getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_population_no_level'), TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false)) end
    end

    return text
end

function InfoText.happiness(goal, pos)
    local type = goal.type
    local current = math.ceil(City.getHappiness(Definitions.getHappinessType(goal.type)) * 100 - 0.5)
    local target = goal.value * 100
    local text = ''

    if type then
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_happiness_with_type'), type, current, target) .. getStatusString(current >= target)
        else text = getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_happiness_with_type'), type, current, target) end
    else
        if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_happiness_no_type'), current, target) .. getStatusString(current >= target)
        else text = getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_happiness_no_type'), current, target) end
    end

    return text
end

function InfoText.income(target, pos)
    local current = City.getIncome()
    local text = ''

    if pos == 1 then text = string.format(TheoTown.translate('$contracts_string_condition_income'), TheoTown.formatMoney(current), TheoTown.formatMoney(target)) .. getStatusString(current >= target)
    else text = getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_income'), TheoTown.formatMoney(current), TheoTown.formatMoney(target)) end

    return text
end

-- Return a complete information string of a contract.
function InfoText.get(def)
    local text = TheoTown.translate('$contracts_string_condition_title')

    if def.goals.buildings then
        for _, goal in pairs(def.goals.buildings) do
            text = text .. InfoText.buildings(goal, 0)
        end
    end

    if def.goals.roads then
        for _, goal in pairs(def.goals.roads) do
            text = text .. InfoText.roads(goal, 0)
        end
    end

    if def.goals.population then
        for _, goal in pairs(def.goals.population) do
            text = text .. InfoText.population(goal, 0)
        end
    end

    if def.goals.happiness then
        for _, goal in pairs(def.goals.happiness) do
            text = text .. InfoText.happiness(goal, 0)
        end
    end

    if def.goals.income then
        text = text .. InfoText.income(def.goals.income, 0)
    end

    text = text .. string.format(
        TheoTown.translate('$contracts_string_rewards'),
        TheoTown.formatMoney(def.advance),
        TheoTown.formatMoney(def.completion),
        TheoTown.formatMoney(def.cancellation)
    )

    return text
end

-- Returns a list of information headers along with their offsets to be used for the dynamic goal display.
function InfoText.getDisplay(def)
    local list = {}
    local offset = 0

    if def.goals.buildings then
        for _, goal in pairs(def.goals.buildings) do
            table.insert(list, {text = InfoText.buildings(goal, 1), offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.roads then
        for _, goal in pairs(def.goals.roads) do
            table.insert(list, {text = InfoText.roads(goal, 1), offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.population then
        for _, goal in pairs(def.goals.population) do
            table.insert(list, {text = InfoText.population(goal, 1), offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.happiness then
        for _, goal in pairs(def.goals.happiness) do
            table.insert(list, {text = InfoText.happiness(goal, 1), offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.income then
        table.insert(list, {text = InfoText.income(def.goals.income, 1), offset = offset})
    end

    return list
end

return InfoText
