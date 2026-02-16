
-- This module handles plugin settings.

local Settings = {}

local storage

function Settings.init()
    storage = Util.optStorage(TheoTown.getStorage(), '$contracts_settings_storage_00')

    if storage.DISPLAY_GOALS == nil then storage.DISPLAY_GOALS = true end
    if storage.DISPLAY_ISSUER == nil then storage.DISPLAY_ISSUER = true end
end

function Settings.update()
    return {
        {
            name = TheoTown.translate('$contracts_string_display_goals'),
            value = storage.DISPLAY_GOALS,
            onChange = function(newState)
                storage.DISPLAY_GOALS = newState
            end
        },
        {
            name = TheoTown.translate('$contracts_string_display_issuer'),
            value = storage.DISPLAY_ISSUER,
            onChange = function(newState)
                storage.DISPLAY_ISSUER = newState
            end
        }
    }
end

function Settings.getDisplayGoals()
    return storage.DISPLAY_GOALS
end

function Settings.getDisplayIssuer()
    return storage.DISPLAY_ISSUER
end

return Settings
