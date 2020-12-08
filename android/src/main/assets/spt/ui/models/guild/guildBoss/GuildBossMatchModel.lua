local Model = require("ui.models.Model")
local GuildBossMatchModel = class(Model, "GuildBossMatchModel")

function GuildBossMatchModel:ctor()
    self.super.ctor(self)
end

function GuildBossMatchModel:InitProtocolData(data)
    cache.setGuildBossMatch(data)
end

-- 玩家球队信息
function GuildBossMatchModel:GetPlayerTeamInfo()
    return self:GetGuildBossMatch().playerInfo
end

-- 对手球队信息
function GuildBossMatchModel:GetOpponentTeamInfo()
    return self:GetGuildBossMatch().opponentInfo
end

-- 比赛信息
function GuildBossMatchModel:GetGuildBossMatch()
    return cache.getGuildBossMatch()
end

-- 清空比赛信息
function GuildBossMatchModel:ClearMatch()
    cache.setGuildBossMatch(nil)
end

-- 比分
function GuildBossMatchModel:GetScoreData()
    local guildBossMatchData = self:GetGuildBossMatch() or {}
    local statistics = guildBossMatchData.statistics or {}
    local player = statistics.player or {}
    local opponent = statistics.opponent or {}
    local playerScore = tonumber(player.score)
    local opponentScore = tonumber(opponent.score)
    return playerScore, opponentScore
end

-- 赛果信息/奖励
function GuildBossMatchModel:GetSettlementData()
    local guildBossMatchData = self:GetGuildBossMatch() or {}
    local settlement = guildBossMatchData.settlement or {}
    return settlement
end

-- 赛果
function GuildBossMatchModel:GetFinishState()
    local guildBossMatchData = self:GetSettlementData() or {}
    local finishState = guildBossMatchData.finishState or 1
    return finishState
end

-- 对boss造成血量伤害
function GuildBossMatchModel:GetDamage()
    local guildBossMatchData = self:GetSettlementData() or {}
    local damage = guildBossMatchData.damage or 0
    return damage
end

-- 贡献boss币
function GuildBossMatchModel:GetBossCoin()
    local guildBossMatchData = self:GetSettlementData() or {}
    local coin = guildBossMatchData.bossCoin or 0
    return coin
end

-- 是否对boss形成最后一击
function GuildBossMatchModel:IsLastAttack()
    local guildBossMatchData = self:GetSettlementData() or {}
    local isLastAttack = guildBossMatchData.lastAttack
    return tobool(isLastAttack)
end

-- 奖励
function GuildBossMatchModel:GetRewards()
    local guildBossMatchData = self:GetSettlementData() or {}
    local rewards = guildBossMatchData.resultGift or {}
    return rewards
end

-- bossId
function GuildBossMatchModel:GetBossId()
    local guildBossMatchData = self:GetSettlementData() or {}
    local bossId = guildBossMatchData.bossId or 1
    return bossId
end

return GuildBossMatchModel