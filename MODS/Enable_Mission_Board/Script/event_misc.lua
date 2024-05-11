﻿require 'common'
require 'GeneralFunctions'

--TODO: May need to replace this when diff-based modding is enabled
STATUS_SCRIPT = {}

function ITEM_SCRIPT.MissionItemPickup(owner, ownerChar, context, args)
    local mission_num = args.Mission
    local mission = SV.TakenBoard[mission_num]
    if mission.Item == context.Item.Value then
        mission.Completion = COMMON.MISSION_COMPLETE
        SV.TemporaryFlags.MissionCompleted = true
        GAME:WaitFrames(70)
        UI:ResetSpeaker()
        UI:WaitShowDialogue("Yes! You found " .. _DATA:GetMonster(mission.Client):GetColoredName() .. "'s " .. context.Item:GetDungeonName() .. "!")
        --Clear but remember minimap state
        SV.TemporaryFlags.PriorMapSetting = _DUNGEON.ShowMap
        _DUNGEON.ShowMap = _DUNGEON.MinimapState.None

        --Slight pause before asking to warp out 
        GAME:WaitFrames(20)
        GeneralFunctions.AskMissionWarpOut()
    end
end

function ITEM_SCRIPT.OutlawItemPickup(owner, ownerChar, context, args)
    local mission_num = args.Mission
    local mission = SV.TakenBoard[mission_num]
    if mission.Item == context.Item.Value then
        SV.OutlawItemPickedUp = true
    end
end
