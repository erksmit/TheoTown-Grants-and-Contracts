
-- This module handles contract goal logic like checks and listeners.

local Definitions = require('definitions')

local Goals = {}

Goals.handlers = {}

-- Handlers contain init and check behavior for every goal type.
function Goals.registerHandler(type, handler)
    Goals.handlers[type] = handler
end

-- Check all goals of a contract.
function Goals.checkAll(state)
    for goalType, goals in pairs(state.def.goals) do
        local handler = Goals.handlers[goalType]
        if handler and handler.check then
            if not handler.check(state, goals) then
                return false
            end
        end
    end
    return true
end

-- Return the ID of the first unmet actionable goal (building or road).
function Goals.getNextAction(def)
    if def.goals.buildings then
        for _, goal in ipairs(def.goals.buildings) do
            local draft = Draft.getDraft(goal.id)
            if draft and City.countBuildings(draft) < goal.count then return goal.id end
        end
    end

    if def.goals.roads then
        for _, goal in ipairs(def.goals.roads) do
            local draft = Draft.getDraft(goal.id)
            if draft and City.countRoads(draft) < goal.count then return goal.id end
        end
    end

    return nil
end

Goals.registerHandler(
    "buildings",
    {
        init = function(state, goals)
            for _, goal in ipairs(goals) do
                local draft = Draft.getDraft(goal.id)
                if draft then
                    local listener = City.addBuildingListener{
                        draft = draft,
                        added = function()
                            if state.status ~= 'active' then return end
                            state._dirty = true
                        end,
                        removed = function()
                            state._dirty = true
                        end
                    }
                end
            end
        end,

        check = function(state, goals)
            for _, goal in ipairs(goals) do
                local draft = Draft.getDraft(goal.id)
                if not draft then return false end

                local current = City.countBuildings(draft)
                if goal.count == 0 then
                    if current ~= 0 then
                        return false
                    end
                elseif current < goal.count then
                    return false
                end
            end
            return true
        end
    }
)

Goals.registerHandler(
    "roads",
    {
        init = function(state, goals)
            for _, goal in ipairs(goals) do
                local draft = Draft.getDraft(goal.id)
                if draft then
                    local listener = City.addRoadListener{
                        draft = draft,
                        added = function()
                            if state.status ~= 'active' then return end
                            state._dirty = true
                        end,
                        removed = function()
                            state._dirty = true
                        end
                    }
                end
            end
        end,

        check = function(state, goals)
            for _, goal in ipairs(goals) do
                local draft = Draft.getDraft(goal.id)
                if not draft then return false end

                local current = City.countRoads(draft)
                if goal.count == 0 then
                    if current ~= 0 then
                        return false
                    end
                elseif current < goal.count then
                    return false
                end
            end
            return true
        end
    }
)

Goals.registerHandler(
    "population",
    {
        init = function(state, goals)
            state.needsDailyCheck = true
        end,

        check = function(state, goals)
            for _, goal in ipairs(goals) do
                if City.getPeople(goal.level) < goal.count then return false end
            end
            return true
        end
    }
)

Goals.registerHandler(
    "happiness",
    {
        init = function(state, goals)
            state.needsDailyCheck = true
        end,

        check = function(state, goals)
            for _, goal in ipairs(goals) do
                if math.ceil(City.getHappiness(Definitions.getHappinessType(goal.type)) * 100 - 0.5) < (goal.value * 100) then return false end
            end
            return true
        end
    }
)

Goals.registerHandler(
    "income",
    {
        init = function(state, goals)
            state.needsDailyCheck = true
        end,

        check = function(state, goal)
            return City.getIncome() >= goal
        end
    }
)

Goals.registerHandler(
    "money",
    {
        init = function(state, goals)
            state.needsDailyCheck = true
        end,

        check = function(state, goal)
            return City.getMoney() >= goal
        end
    }
)

return Goals
