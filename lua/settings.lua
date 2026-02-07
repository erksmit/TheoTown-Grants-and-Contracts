
-- This module handles plugin settings.

local Settings = {}

local storage

function Settings.init()
    storage = Util.optStorage(TheoTown.getStorage(), '$contracts_settings_storage_00')

    if storage.DISPLAY_GOALS == nil then storage.DISPLAY_GOALS = true end
end

function Settings.get()
    return {
        {
            name = TheoTown.translate('$contract_string_display_goals'),
            value = storage.DISPLAY_GOALS,
            onChange = function(newState)
                storage.DISPLAY_GOALS = newState
                Settings.DISPLAY_GOALS = newState
            end
        }
    }
end

return Settings
