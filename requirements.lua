
local Storage = require('storage')

local Requirements = {}

local storage

function Requirements.initCity()
    storage = Storage.init()
end

function Requirements.met(def)
    local req = def.requirements
    if not req then return true end

    -- Minimum rank requirement.
    local _, rank = City.getRank()
    if req.rank and rank < req.rank then return false end

    -- Completed contracts requirement.
    if req.contracts_completed then
        for _, contractId in ipairs(req.contracts_completed) do
            if not storage.contracts.completed[contractId] then
                return false
            end
        end
    end

    return true
end

return Requirements
