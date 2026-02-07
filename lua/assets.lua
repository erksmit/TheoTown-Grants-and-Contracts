
-- This module handles assets like sounds or graphics.

local Assets = {}

Assets.FRAMES = {}
Assets.SOUNDS = {}

function Assets.init()
    Assets.FRAMES.GOAL_BACKGROUND = Draft.getDraft('$contracts_goal_display_background_00'):getFrame(1)

    Assets.SOUNDS.SIGN = Draft.getDraft('$contracts_sound_sign_00')
    Assets.SOUNDS.COMPLETE = Draft.getDraft('$contracts_sound_complete_00')
    Assets.SOUNDS.CANCEL = Draft.getDraft('$contracts_sound_cancel_00')
end

return Assets
