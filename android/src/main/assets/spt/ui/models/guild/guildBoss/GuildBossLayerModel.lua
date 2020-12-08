local UnityEngine = clr.UnityEngine
local Time = UnityEngine.Time
local GuildBossSet = require("data.GuildBossSet")
local GuildBossReward = require("data.GuildBossReward")
local Model = require("ui.models.Model")
local GuildBossLayerModel = class(Model, "GuildBossLayerModel")

function GuildBossLayerModel:ctor(layer, guildBossModel)
    GuildBossLayerModel.super.ctor(self)
    self.layer = layer
    self.guildBossModel = guildBossModel
end

function GuildBossLayerModel:GetSetConfig()
	return GuildBossSet[tostring(self.layer)]
end

function GuildBossLayerModel:GetId()
	return self.layer
end

function GuildBossLayerModel:IsLock()
	return self.guildBossModel:GetCurId() < self.layer
end

function GuildBossLayerModel:GetName()
	return self:GetTeamYear() .. self:GetTeamName()
end

function GuildBossLayerModel:GetTeamName()
	return self:GetSetConfig().teamName
end

function GuildBossLayerModel:GetTeamYear()
	return self:GetSetConfig().teamYear
end

function GuildBossLayerModel:GetSliderValue()
	return self:GetBlood()/self:GetMaxBlood()
end

function GuildBossLayerModel:GetBlood()
	if self:IsLock() then
		return self:GetMaxBlood()
	elseif self:IsOver() then
		return 0
	else
		return self.guildBossModel:GetBlood()
	end
end

function GuildBossLayerModel:IsOver()
	return self.guildBossModel:GetCurId() > self.layer or self.guildBossModel:GetCurId() == self.layer and self.guildBossModel:GetBlood() <= 0
end

function GuildBossLayerModel:isFight()
	return self.guildBossModel:GetCurId() == self.layer
end

function GuildBossLayerModel:GetUpBuff()
	return (self.guildBossModel:GetUpBuff(self.layer) / 10) .. "%"
end

function GuildBossLayerModel:GetDownBuff()
	return (self.guildBossModel:GetDownBuff(self.layer) / 10) .. "%"
end

function GuildBossLayerModel:GetMaxBlood()
	return self:GetSetConfig().blood
end

function GuildBossLayerModel:GetFlagIcon()
	return self:GetSetConfig().questPic .. "Flag"
end

function GuildBossLayerModel:GetBgIcon()
	return self:GetSetConfig().questPic .. "bg"
end

function GuildBossLayerModel:GetPlayerIcon()
	return self:GetSetConfig().questPic
end

function GuildBossLayerModel:GetNextId()
	return self:GetSetConfig().nextID
end

function GuildBossLayerModel:GetPower()
	return math.ceil(self:GetSetConfig().power * (1 - self.guildBossModel:GetDownBuff(self.layer) / 1000))
end

function GuildBossLayerModel:IsSelected()
	return self.layer == self.guildBossModel:GetSelect()
end

function GuildBossLayerModel:GetKillReward()
	return GuildBossReward[tostring(self:GetSetConfig().lastBeatReward)].contents
end

function GuildBossLayerModel:GetAllReward()
	return GuildBossReward[tostring(self:GetSetConfig().defeatReward)].contents
end

function GuildBossLayerModel:GetKillName()
	return self.guildBossModel:GetKillName(self.layer)
end

function GuildBossLayerModel:GetPerfectBlood()
	local cfg = self:GetSetConfig()
	return cfg.perfectExtraBlood, cfg.perfectBossCoin
end

function GuildBossLayerModel:GetPerfectConditionText()
	return self.guildBossModel:GetPerfectConditionText(self.layer)
end

--是否领取过改奖励 换帮派不给了
function GuildBossLayerModel:IsGetReward()
	return self.guildBossModel:IsGetReward(self.layer)
end

function GuildBossLayerModel:IsFightOver()
	return self.guildBossModel:IsFightOver()
end

return GuildBossLayerModel
