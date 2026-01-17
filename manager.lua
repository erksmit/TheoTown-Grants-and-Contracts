
local Definitions = require('definitions')
local Storage = require('storage')
local Requirements = require('requirements')
local Goals = require('goals')

local Manager = {}
local storage

Manager.onCompleted = {}
Manager.onCancelled = {}

local MAX_CONTRACT_COUNT = 2
local SOUNDS = {
    ACCEPT = '$contracts_sound_sign_00',
    COMPLETE = '$contracts_sound_complete_00',
    CANCEL = '$contracts_sound_cancel_00'
}

function Manager.initCity()
    storage = Storage.init()
end

function Manager.isActive(id)
    return storage.contracts.active[id] ~= nil
end

function Manager.countActiveContracts()
    local n = 0

    for _ in pairs(storage.contracts.active) do
        n = n + 1
    end

    return n
end

function Manager.createContractState(def)
    return {
        id = def.id,
        def = def,
        status = "active", -- active, completed
        listeners = {},
        needsDailyCheck = false
    }
end

function Manager.getMaxActive()
    return MAX_CONTRACT_COUNT
end

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

function Manager.getAvailable()
    if not storage or not storage.contracts then
        return {}
    end

    local list = {}

    for id, def in pairs(Definitions.getAll()) do
        if not storage.contracts.active[id]
        and not storage.contracts.completed[id]
        and Requirements.met(def) then
            table.insert(list, def)
        end
    end

    return list
end

function Manager.canAccept()
    if Manager.countActiveContracts() < MAX_CONTRACT_COUNT then return true end
    return false
end

function Manager.canCancel(state)
    if City.getMoney() >= state.def.cancellation then return true end
    return false
end

function Manager.complete(state)
    if state.status == "completed" then return end
    state.status = "completed"

    storage.contracts.active[state.id] = nil
    storage.contracts.completed[state.id] = true

    TheoTown.playSound(SOUNDS.COMPLETE)
    City.earnMoney(state.def.completion)

    Manager._emit(Manager.onCompleted, state)
end

function Manager.checkCompletion(state)
    if state.status ~= 'active' then return end
    if Goals.checkAll(state) then
        Manager.complete(state)
    end
end

function Manager.accept(id)
    if Manager.isActive(id) then return end
    if not Manager.canAccept() then return end

    local def = Definitions.get(id)
    if not def then return end
    if not Requirements.met(def) then return end

    local state = Manager.createContractState(def)
    storage.contracts.active[id] = state

    for goalType, goals in pairs(def.goals) do
        local handler = Goals.handlers[goalType]
        if handler and handler.init then
            handler.init(state, goals)
        end
    end

    TheoTown.playSound(SOUNDS.ACCEPT)
    City.earnMoney(def.advance)

    Manager.checkCompletion(state)
end

function Manager.cancel(state)
    if not Manager.isActive(state.id) then return end

    storage.contracts.active[state.id] = nil

    TheoTown.playSound(SOUNDS.CANCEL)
    City.spendMoney(state.def.advance + state.def.cancellation)
end

function Manager._emit(list, state)
    for _, fn in ipairs(list) do
        fn(state)
    end
end

return Manager
