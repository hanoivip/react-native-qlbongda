local QuestConditionConfig = {}

QuestConditionConfig.Type = {
    GoalCount = 1,
    Win = 2,
    TeamGoalDifferenceCount = 3,
    TeamAssistCount = 4,
    TeamSaveSuccessCount = 5,
    LoseBallCount = 6,
    GoalPositionCount = 7,
    GoalWayCount = 8,
    SpecificPositionPlayerGoalCount = 9,
    SpecificPositionPlayerAssistCount = 10,
    SpecificBaseIdPlayerGoalCount = 11,
    SpecificBaseIdPlayerAssistCount = 12,
    SkillCount = 13,
    ShootSkillGoalCount = 14,
    PassSkillGoalCount = 15,
    AboveShootDistanceGoalCount = 16,
    BelowShootDistanceGoalCount = 17,
    AbovePassTimesGoalCount = 18,
    BelowPassTimesGoalCount = 19,
    AbovePassDistanceCount = 20,
    BelowPassDistanceCount = 21,
    CardCount = 22,
    FreeKickGoalCount = 23,
    SomeTypeSkillCount = 24,
    PassAndShootSkillGoalCount = 25,
    StarterNationCount = 26,
    StarterLeagueCount = 27,
    DribbleOperateCount = 28,
    Under23Count = 29,
    ForeignersCount = 30,
    ClubCount = 31,
    DribbleAndShootSkillGoalCount = 32,
}

QuestConditionConfig.GoalPositionType = {
    LeftTop = 1,
    LeftBottom = 2,
    RightTop = 3,
    RightBottom = 4,
}

QuestConditionConfig.GoalWayType = {
    header = 1,--头球
    volleyShoot = 2,--凌空
    centerDirectFreeKick = 3,--任意球
    catchCornerKick = 4,--接角球
    penaltyKick = 5,--点球
    catchWingDirectFreeKick = 6,--接任意球
}

QuestConditionConfig.CardType = {
    Red = 1,
    Yellow = 2,
}

QuestConditionConfig.CheckFunc = {
    [QuestConditionConfig.Type.GoalCount] = function(match, questCondition)
        local result = match.playerTeam.score >= questCondition.targetCount
        return result, match.playerTeam.score, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.Win] = function(match, questCondition)
        local result = match.playerTeam.score > match.opponentTeam.score
        return result, result and 1 or 0
    end,
    [QuestConditionConfig.Type.TeamGoalDifferenceCount] = function(match, questCondition)
        local playerTeamGoalDifference = match.playerTeam.score - match.opponentTeam.score
        local result = playerTeamGoalDifference >= questCondition.targetCount
        return result, playerTeamGoalDifference, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.TeamAssistCount] = function(match, questCondition)
        local result = match.playerTeam.assistCount >= questCondition.targetCount
        return result, match.playerTeam.assistCount, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.TeamSaveSuccessCount] = function(match, questCondition)
        local result = match.playerTeam.saveSuccessCount >= questCondition.targetCount
        return result, match.playerTeam.saveSuccessCount, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.LoseBallCount] = function(match, questCondition)
        local result = match.opponentTeam.score <= questCondition.targetCount
        return result, match.opponentTeam.score, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.GoalPositionCount] = function(match, questCondition)
        local result = match.playerTeam:getGoalPositionCount(questCondition.goalPositionType) >= questCondition.targetCount
        return result, match.playerTeam:getGoalPositionCount(questCondition.goalPositionType), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.GoalWayCount] = function(match, questCondition)
        local result = match.playerTeam.goalCountByGoalWay[questCondition.goalWayType] >= questCondition.targetCount
        return result, match.playerTeam.goalCountByGoalWay[questCondition.goalWayType], questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.SpecificPositionPlayerGoalCount] = function(match, questCondition)
        local result = match.playerTeam.statisticsByPosition[questCondition.position].goal >= questCondition.targetCount
        return result, match.playerTeam.statisticsByPosition[questCondition.position].goal, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.SpecificPositionPlayerAssistCount] = function(match, questCondition)
        local result = match.playerTeam.statisticsByPosition[questCondition.position].assist >= questCondition.targetCount
        return result, match.playerTeam.statisticsByPosition[questCondition.position].assist, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.SpecificBaseIdPlayerGoalCount] = function(match, questCondition)
        local result = match.playerTeam.statisticsByBaseId[questCondition.baseId] and match.playerTeam.statisticsByBaseId[questCondition.baseId].goal >= questCondition.targetCount
        return result, match.playerTeam.statisticsByBaseId[questCondition.baseId] and match.playerTeam.statisticsByBaseId[questCondition.baseId].goal or 0, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.SpecificBaseIdPlayerAssistCount] = function(match, questCondition)
        local result = match.playerTeam.statisticsByBaseId[questCondition.baseId] and match.playerTeam.statisticsByBaseId[questCondition.baseId].assist >= questCondition.targetCount
        return result, match.playerTeam.statisticsByBaseId[questCondition.baseId] and match.playerTeam.statisticsByBaseId[questCondition.baseId].assist or 0, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.SkillCount] = function(match, questCondition)
        local result = match.playerTeam:getSkillCountByBaseSkillId(questCondition.skillId) >= questCondition.targetCount
        return result, match.playerTeam:getSkillCountByBaseSkillId(questCondition.skillId), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.ShootSkillGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getShootSkillGoalCount(questCondition.skillId) >= questCondition.targetCount
        return result, match.playerTeam:getShootSkillGoalCount(questCondition.skillId), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.PassSkillGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getPassSkillGoalCount(questCondition.skillId) >= questCondition.targetCount
        return result, match.playerTeam:getPassSkillGoalCount(questCondition.skillId), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.AboveShootDistanceGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getAboveShootDistanceCount(questCondition.shootDistance) >= questCondition.targetCount
        return result, match.playerTeam:getAboveShootDistanceCount(questCondition.shootDistance), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.BelowShootDistanceGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getBelowShootDistanceCount(questCondition.shootDistance) >= questCondition.targetCount
        return result, match.playerTeam:getBelowShootDistanceCount(questCondition.shootDistance), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.AbovePassTimesGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getAbovePassTimesGoalCount(questCondition.passTimes) >= questCondition.targetCount
        return result, match.playerTeam:getAbovePassTimesGoalCount(questCondition.passTimes), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.BelowPassTimesGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getBelowPassTimesGoalCount(questCondition.passTimes) >= questCondition.targetCount
        return result, match.playerTeam:getBelowPassTimesGoalCount(questCondition.passTimes), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.AbovePassDistanceCount] = function(match, questCondition)
        local result = match.playerTeam:getAbovePassDistanceCount(questCondition.passDistance) >= questCondition.targetCount
        return result, match.playerTeam:getAbovePassDistanceCount(questCondition.passDistance), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.BelowPassDistanceCount] = function(match, questCondition)
        local result = match.playerTeam:getBelowPassDistanceCount(questCondition.passDistance) >= questCondition.targetCount
        return result, match.playerTeam:getBelowPassDistanceCount(questCondition.passDistance), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.CardCount] = nil,
    [QuestConditionConfig.Type.FreeKickGoalCount] = function(match, questCondition)
        local result = match.playerTeam.goalCountByGoalWay[QuestConditionConfig.GoalWayType.centerDirectFreeKick]
        + match.playerTeam.goalCountByGoalWay[QuestConditionConfig.GoalWayType.catchWingDirectFreeKick] >= questCondition.targetCount
        return result, match.playerTeam.goalCountByGoalWay[QuestConditionConfig.GoalWayType.centerDirectFreeKick]
        + match.playerTeam.goalCountByGoalWay[QuestConditionConfig.GoalWayType.catchWingDirectFreeKick], questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.SomeTypeSkillCount] = function(match, questCondition)
        local result = match.playerTeam.skillCountByType[questCondition.skillType] >= questCondition.targetCount
        return result, match.playerTeam.skillCountByType[questCondition.skillType], questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.PassAndShootSkillGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getPassAndShootSkillGoalCount(questCondition.passSkillId, questCondition.shootSkillId) >= questCondition.targetCount
        return result, match.playerTeam:getPassAndShootSkillGoalCount(questCondition.passSkillId, questCondition.shootSkillId), questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.StarterNationCount] = function(match, questCondition)
        local questNationCount = match.playerTeam.starterCountByNation[questCondition.nation]
        questNationCount = questNationCount and questNationCount or 0
        local result = questNationCount >= questCondition.targetCount
        return result, questNationCount, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.StarterLeagueCount] = function(match, questCondition)
        local questLeagueCount = match.playerTeam.starterCountByLeague[questCondition.league]
        questLeagueCount = questLeagueCount and questLeagueCount or 0
        local result = questLeagueCount >= questCondition.targetCount
        return result, questLeagueCount, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.DribbleOperateCount] = function(match, questCondition)
        local result = match.playerTeam.dribbleOperateCount >= questCondition.targetCount
        return result, match.playerTeam.dribbleOperateCount, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.Under23Count] = function(match, questCondition)
        local result = questCondition.count >= questCondition.targetCount
        return result, questCondition.count, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.ForeignersCount] = function(match, questCondition)
        local result = questCondition.count <= questCondition.targetCount
        return result, questCondition.count, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.ClubCount] = function(match, questCondition)
        local result = questCondition.count >= questCondition.targetCount
        return result, questCondition.count, questCondition.isStageClearCondition and result
    end,
    [QuestConditionConfig.Type.DribbleAndShootSkillGoalCount] = function(match, questCondition)
        local result = match.playerTeam:getDribbleAndShootSkillGoalCount(questCondition.dribbleSkillId, questCondition.shootSkillId) >= questCondition.targetCount
        return result, match.playerTeam:getDribbleAndShootSkillGoalCount(questCondition.dribbleSkillId, questCondition.shootSkillId), questCondition.isStageClearCondition and result
    end,

}

return QuestConditionConfig
