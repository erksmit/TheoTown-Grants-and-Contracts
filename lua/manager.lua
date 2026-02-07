
-- This module handles communication between the UI and the internal logic. All action calls should go through the manager.

local Definitions = require('definitions')
local Storage = require('storage')
local Requirements = require('requirements')
local Goals = require('goals')
local Assets = require('assets')

local Manager = {}
local storage

Manager.onCompleted = {}
Manager.onCancelled = {}

local MAX_CONTRACT_COUNT = 2

-- Returns true if contract is currently active.
function Manager.isActive(id)
    return storage.contracts.active[id] ~= nil
end

-- Returns the count of all currently active contracts.
function Manager.countActiveContracts()
    local n = 0

    for _ in pairs(storage.contracts.active) do
        n = n + 1
    end

    return n
end

-- Creates a contract state. A state is a shorthand contract object used for operating on active contracts.
function Manager.createContractState(def)
    return {
        id = def.id,
        def = def,
        status = "active", -- active, completed
        listeners = {},
        needsDailyCheck = false
    }
end

-- Returns the constant. Useful for other modules.
function Manager.getMaxActive()
    return MAX_CONTRACT_COUNT
end

-- Return the ID of the first unmet actionable goal (building or road).
function Manager.getNextAction(def)
    return Goals.getNextAction(def)
end

-- Returns a table of all active contract states.
function Manager.getActive()
    if not storage or not storage.contracts then
        return {}
    end

    local list = {}

    for _, state in pairs(storage.contracts.active) do
        table.insert(list, state)
    end

    return list
end

-- Returns a table of all available contract definitions.
function Manager.getAvailable()
    if not storage or not storage.contracts then
        return {}
    end

    local list = {}

    for id, def in pairs(Definitions.getAll()) do
        if not storage.contracts.active[id]
        and not storage.contracts.completed[id]
        and Requirements.status(def) == 'available' then
            table.insert(list, def)
        end
    end

    return list
end

-- Returns a table of all almost available contract definitions, along with a reason.
function Manager.getAlmostAvailable()
    local list = {}

    for id, def in pairs(Definitions.getAll()) do
        if not storage.contracts.active[id]
        and not storage.contracts.completed[id] then
            local s = Requirements.status(def)
            if s == 'no_rank' or s == 'no_contracts' then
                table.insert(list, {
                    def = def,
                    status = s
                })
            end
        end
    end

    return list
end

-- Check whether more contracts can be accepted. Only MAX_CONTRACT_COUNT contracts can be active at a time.
function Manager.canAccept()
    if Manager.countActiveContracts() < MAX_CONTRACT_COUNT then return true end
    return false
end

-- Check whether the player has enough money to cancel a contract.
function Manager.canCancel(state)
    if City.getMoney() >= (state.def.advance + state.def.cancellation) then return true end
    return false
end

-- Complete an acive contract.
function Manager.complete(state)
    if state.status == "completed" then return end
    state.status = "completed"

    storage.contracts.active[state.id] = nil
    storage.contracts.completed[state.id] = true

    TheoTown.playSound(Assets.SOUNDS.COMPLETE)
    City.earnMoney(state.def.completion)

    Manager._emit(Manager.onCompleted, state)
end

-- Check goals and complete a contract, if goals are met.
function Manager.checkCompletion(state)
    if state.status ~= 'active' then return end
    if Goals.checkAll(state) then
        Manager.complete(state)
    end
end

-- Accept a contract and make it active.
function Manager.accept(id)
    if Manager.isActive(id) then return end
    if not Manager.canAccept() then return end

    local def = Definitions.get(id)
    if not def then return end
    if Requirements.status(def) ~= 'available' then return end

    local state = Manager.createContractState(def)
    storage.contracts.active[id] = state

    for goalType, goals in pairs(def.goals) do
        local handler = Goals.handlers[goalType]
        if handler and handler.init then
            handler.init(state, goals)
        end
    end

    TheoTown.playSound(Assets.SOUNDS.ACCEPT)
    City.earnMoney(def.advance)

    -- Listeners don't get updated until something is actually built. This line checks if goals are met just as the contract is signed.
    Manager.checkCompletion(state)
end

-- Cancel an active contract.
function Manager.cancel(state)
    if not Manager.isActive(state.id) then return end

    storage.contracts.active[state.id] = nil

    TheoTown.playSound(Assets.SOUNDS.CANCEL)
    City.spendMoney(state.def.advance + state.def.cancellation)
end

-- Necessary to avoid circular dependencies.
function Manager._emit(list, state)
    for _, fn in ipairs(list) do
        fn(state)
    end
end

-- Reinitialize listeners when loading a city.
function Manager.reinitGoals(state)
    for goalType, goals in pairs(state.def.goals) do
        local handler = Goals.handlers[goalType]
        if handler and handler.init then
            handler.init(state, goals)
        end
    end
end

function Manager.initCity()
    storage = Storage.init()

    -- Reinitialize listeners when loading a city.
    for _, state in pairs(storage.contracts.active) do
        state.status = 'active'
        state._dirty = nil -- reset transient flags
        state.needsDailyCheck = state.needsDailyCheck or false

        Manager.reinitGoals(state)

        -- Check immediately in case goals were already met.
        Manager.checkCompletion(state)
    end
end

return Manager
