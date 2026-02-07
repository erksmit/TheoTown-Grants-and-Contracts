
-- This module handles plugin settings.

local Settings = {}

function Settings.init()
    Settings = Util.optStorage(TheoTown.getStorage(), 'Grants & Contracts Settings')

    Settings.DISPLAY_GOALS = Settings.DISPLAY_GOALS == nil and true or Settings.DISPLAY_GOALS
end

function Settings.update()
    return {
        {
            name = TheoTown.translate('$contract_string_display_goals'),
            value = Settings.DISPLAY_GOALS,
            onChange = function(newState) Settings.DISPLAY_GOALS = newState end
        }
    }
end

return Settings
