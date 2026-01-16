
local Manager = require('manager')

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
            local listeners = {}

            for _, goal in ipairs(goals) do
                local draft = Draft.getDraft(goal.id)
                if draft then
                    local listener = City.addBuildingListener{
                        draft = draft,
                        added = function()
                            if state.status ~= 'active' then return end
                            if Goals.checkAll(state) then
                                Manager.complete(state)
                            end
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

return Goals
