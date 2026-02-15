
-- This module handles contract requirement checks. All requirements must be fulfilled for the contract to become available.

local Storage = require('storage')
local Definitions = require('definitions')

local Requirements = {}

local storage

function Requirements.initCity()
    storage = Storage.init()
end

-- Check whether all requirements have been met. Returns a status string: available, no_rank, no_contracts, locked.
function Requirements.status(def)
    local req = def.requirements
    if not req then return 'available' end

    -- Monthly income requirement. Logic is inverted for negative income.
    local income = City.getIncome()
    if req.income then
        if req.income >= 0 then
            if income < req.income then return 'locked' end
        elseif req.income < 0 then
            if income >= req.income then return 'locked' end
        end
    end

    -- Money at hand requirement. Logic is inverted for negative money.
    local money = City.getMoney()
    if req.money then
        if req.money >= 0 then
            if money < req.money then return 'locked' end
        elseif req.money < 0 then
            if money >= req.money then return 'locked' end
        end
    end

    -- Minimum rank requirement.
    local _, rank = City.getRank()
    if req.rank and rank < req.rank then
        if req.rank - 1 == rank then return 'no_rank'
        else return 'locked' end
    end

    -- Completed contracts requirement.
    if req.contracts_completed then
        local missing = 0

        for _, contractId in ipairs(req.contracts_completed) do
            if not storage.contracts.completed[contractId] then
                missing = missing + 1

                if missing > 1 then return 'locked' end
            end
        end

        if missing == 1 then return 'no_contracts' end
    end

    return 'available'
end

return Requirements
