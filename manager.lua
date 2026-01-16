
local Definitions = require('definitions')
local Storage = require('storage')
local Requirements = require('requirements')

local Manager = {}
local storage

local MAX_CONTRACT_COUNT = 2

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
        listeners = {}
    }
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

function Manager.accept(id)
    if Manager.isActive(id) then return end
    if Manager.countActiveContracts() >= MAX_CONTRACT_COUNT then return end

    local def = Definitions.get(id)
    if not def then return end
    if not Requirements.met(def) then return end

    storage.contracts.active[id] = Manager.createContractState(def)

    City.earnMoney(def.advance)
end

function Manager.complete(state)
    if state.status == "completed" then return end
    state.status = "completed"

    storage.contracts.active[state.id] = nil
    storage.contracts.completed[state.id] = true

    City.earnMoney(state.def.completion)
end

function Manager.cancel(state)
    if not Manager.isActive(state.id) then return end

    storage.contracts.active[state.id] = nil

    City.spendMoney(state.def.advance + state.def.cancellation)
end

return Manager
