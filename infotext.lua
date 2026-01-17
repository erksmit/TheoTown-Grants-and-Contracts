
local Goals = require('goals')
local Definitions = require('definitions')

local InfoText = {}

function InfoText.buildings(goal)
    local draft = Draft.getDraft(goal.id)
    local current = City.countBuildings(draft)
    local target = goal.count
    local text = ''

    if current < target then text = text .. '[✗] '
    else text = text .. '[✓] ' end

    text = text .. string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target)

    return text
end

function InfoText.roads(goal)
    local draft = Draft.getDraft(goal.id)
    local current = City.countRoads(draft)
    local target = goal.count
    local text = ''

    if current < target then text = text .. '[✗] '
    else text = text .. '[✓] ' end

    text = text .. string.format(TheoTown.translate('$contracts_string_condition_build'), draft:getTitle(), current, target)

    return text
end

function InfoText.population(goal)
    local level = goal.level
    local current = City.getPeople(level)
    local target = goal.count
    local text = ''

    if current < target then text = text .. '[✗] '
    else text = text .. '[✓] ' end

    if level then text = text .. string.format(TheoTown.translate('$contracts_string_condition_population_with_level'), level + 1, TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false))
    else text = text .. string.format(TheoTown.translate('$contracts_string_condition_population_no_level'), TheoTown.formatNumber(current, false, false), TheoTown.formatNumber(target, false, false)) end

    return text
end

function InfoText.happiness(goal)
    local type = goal.type
    local current = math.ceil(City.getHappiness(Definitions.getHappinessType(goal.type)) * 100 - 0.5)
    local target = goal.value * 100
    local text = ''

    if current < target then text = text .. '[✗] '
    else text = text .. '[✓] ' end

    if type then text = text .. string.format(TheoTown.translate('$contracts_string_condition_happiness_with_type'), type, current, target)
    else text = text .. string.format(TheoTown.translate('$contracts_string_condition_happiness_no_type'), current, target) end

    return text
end

function InfoText.income(target)
    local current = City.getIncome()
    local text = ''

    if current < target then text = text .. '[✗] '
    else text = text .. '[✓] ' end

    text = text .. string.format(TheoTown.translate('$contracts_string_condition_income'), current, target)

    return text
end

function InfoText.get(def)
    local text = TheoTown.translate('$contracts_string_condition_title')

    if def.goals.buildings then
        for _, goal in pairs(def.goals.buildings) do
            text = text .. InfoText.buildings(goal)
        end
    end

    if def.goals.roads then
        for _, goal in pairs(def.goals.roads) do
            text = text .. InfoText.roads(goal)
        end
    end

    if def.goals.population then
        for _, goal in pairs(def.goals.population) do
            text = text .. InfoText.population(goal)
        end
    end

    if def.goals.happiness then
        for _, goal in pairs(def.goals.happiness) do
            text = text .. InfoText.happiness(goal)
        end
    end

    if def.goals.income then
        text = text .. InfoText.income(def.goals.income)
    end

    text = text .. string.format(
        TheoTown.translate('$contracts_string_rewards'),
        TheoTown.formatMoney(def.advance),
        TheoTown.formatMoney(def.completion),
        TheoTown.formatMoney(def.cancellation)
    )

    return text
end

return InfoText
