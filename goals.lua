
local Definitions = require('definitions')

local Goals = {}

Goals.handlers = {}

function Goals.registerHandler(type, handler)
    Goals.handlers[type] = handler
end

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
                if current < goal.count then
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
                if current < goal.count then
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

return Goals
