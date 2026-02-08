
-- This module handles the generation of contract information strings for use in UI. Information contrains goals and rewards.

local Definitions = require('definitions')

local InfoText = {}

local function getStatusString(status)
    if status then return '[✓] '
    else return '[✗] ' end
end

local function getStatusColor(status)
    if status then return {r = 160, g = 160, b = 160}
    else return {r = 255, g = 255, b = 255} end
end

-- The following functions are used in the contract preview window and return text only.
function InfoText.buildingsPreview(goal)
    local draft = Draft.getDraft(goal.id)
    local current = City.countBuildings(draft)
    local target = goal.count

    if target == 0 then
        return getStatusString(current <= target) .. string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target)
    else
        return getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target)
    end

end

function InfoText.roadsPreview(goal)
    local draft = Draft.getDraft(goal.id)
    local current = City.countRoads(draft)
    local target = goal.count

    if target == 0 then
        return getStatusString(current <= target) .. string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target)
    else
        return getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target)
    end
end

function InfoText.populationPreview(goal)
    local level = goal.level
    local current = City.getPeople(level)
    local target = goal.count

    if level then
        return getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_population_with_level'), level + 1, TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false))
    else
        return getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_population_no_level'), TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false))
    end
end

function InfoText.happinessPreview(goal)
    local type = goal.type
    local current = math.ceil(City.getHappiness(Definitions.getHappinessType(goal.type)) * 100 - 0.5)
    local target = goal.value * 100

    if type then
        return getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_happiness_with_type'), type, current, target)
    else
        return getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_happiness_no_type'), current, target)
    end
end

function InfoText.incomePreview(target)
    local current = City.getIncome()

    return getStatusString(current >= target) .. string.format(TheoTown.translate('$contracts_string_condition_income'), TheoTown.formatMoney(current), TheoTown.formatMoney(target))
end

-- The following functions are used in the live goal display and return text
function InfoText.buildingsDisplay(goal)
    local draft = Draft.getDraft(goal.id)
    local current = City.countBuildings(draft)
    local target = goal.count

    if target == 0 then
        local c = current <= target
        return string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target) .. getStatusString(c), getStatusColor(c)
    else
        local c = current >= target
        return string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target) .. getStatusString(c), getStatusColor(c)
    end
end

function InfoText.roadsDisplay(goal)
    local draft = Draft.getDraft(goal.id)
    local current = City.countRoads(draft)
    local target = goal.count

    if target == 0 then
        local c = current <= target
        return string.format(TheoTown.translate('$contracts_string_condition_build_none'), draft:getTitle(), current, target) .. getStatusString(c), getStatusColor(c)
    else
        local c = current >= target
        return string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target) .. getStatusString(c), getStatusColor(c)
    end
end

function InfoText.populationDisplay(goal)
    local level = goal.level
    local current = City.getPeople(level)
    local target = goal.count
    local c = current >= target

    if level then
        return string.format(TheoTown.translate('$contracts_string_condition_population_with_level'), level + 1, TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false)) .. getStatusString(c), getStatusColor(c)
    else
        return string.format(TheoTown.translate('$contracts_string_condition_population_no_level'), TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false)) .. getStatusString(c), getStatusColor(c)
    end
end

function InfoText.happinessDisplay(goal)
    local type = goal.type
    local current = math.ceil(City.getHappiness(Definitions.getHappinessType(goal.type)) * 100 - 0.5)
    local target = goal.value * 100
    local c = current >= target

    if type then
        return string.format(TheoTown.translate('$contracts_string_condition_happiness_with_type'), type, current, target) .. getStatusString(c), getStatusColor(c)
    else
        return string.format(TheoTown.translate('$contracts_string_condition_happiness_no_type'), current, target) .. getStatusString(c), getStatusColor(c)
    end
end

function InfoText.incomeDisplay(target)
    local current = City.getIncome()
    local c = current >= target

    return string.format(TheoTown.translate('$contracts_string_condition_income'), TheoTown.formatMoney(current), TheoTown.formatMoney(target)) .. getStatusString(c), getStatusColor(c)
end

-- Return a complete information string of a contract.
function InfoText.getPreview(def)
    local text = TheoTown.translate('$contracts_string_condition_title')

    if def.goals.buildings then
        for _, goal in pairs(def.goals.buildings) do
            text = text .. InfoText.buildingsPreview(goal)
        end
    end

    if def.goals.roads then
        for _, goal in pairs(def.goals.roads) do
            text = text .. InfoText.roadsPreview(goal)
        end
    end

    if def.goals.population then
        for _, goal in pairs(def.goals.population) do
            text = text .. InfoText.populationPreview(goal)
        end
    end

    if def.goals.happiness then
        for _, goal in pairs(def.goals.happiness) do
            text = text .. InfoText.happinessPreview(goal)
        end
    end

    if def.goals.income then
        text = text .. InfoText.incomePreview(def.goals.income)
    end

    text = text .. string.format(
        TheoTown.translate('$contracts_string_rewards'),
        TheoTown.formatMoney(def.advance),
        TheoTown.formatMoney(def.completion),
        TheoTown.formatMoney(def.cancellation)
    )

    return text
end

-- Returns a list of information headers along with their offsets and colors to be used for the dynamic goal display.
function InfoText.getDisplay(def)
    local list = {}
    local offset = 0

    if def.goals.buildings then
        for _, goal in pairs(def.goals.buildings) do
            local text, color = InfoText.buildingsDisplay(goal)
            table.insert(list, {text = text, color = color, offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.roads then
        for _, goal in pairs(def.goals.roads) do
            local text, color = InfoText.roadsDisplay(goal)
            table.insert(list, {text = text, color = color, offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.population then
        for _, goal in pairs(def.goals.population) do
            local text, color = InfoText.populationDisplay(goal)
            table.insert(list, {text = text, color = color, offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.happiness then
        for _, goal in pairs(def.goals.happiness) do
            local text, color = InfoText.happinessDisplay(goal)
            table.insert(list, {text = text, color = color, offset = offset})
            offset = offset + 15
        end
    end

    if def.goals.income then
        local text, color = InfoText.incomeDisplay(def.goals.income)
        table.insert(list, {text = text, color = color, offset = offset})
    end

    return list
end

return InfoText
