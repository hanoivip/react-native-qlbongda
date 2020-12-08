local UnityEngine = clr.UnityEngine
local Time = UnityEngine.Time
local GuildBossBaseSet = require("data.GuildBossBaseSet")
local GuildBossLayerModel = require("ui.models.guild.guildBoss.GuildBossLayerModel")
local GuildBossShopModel = require("ui.models.guild.guildBoss.GuildBossShopModel")
local Model = require("ui.models.Model")
local GuildBossModel = class(Model, "GuildBossModel")

function GuildBossModel:ctor()
    GuildBossModel.super.ctor(self)
    self.guildBossShopModel = GuildBossShopModel.new()
end

local baseConfig = nil
local function GetBaseConfig()
    if not baseConfig then
        baseConfig = GuildBossBaseSet['1']
    end
    return baseConfig
end

function GuildBossModel:InitWithProtocol(data, authority)
    self.data = data
    self.guildBossShopModel:InitWithProtocol(self.data.shopList, self:GetSeason(), authority)
    self.requestTime = Time.realtimeSinceStartup
end

function GuildBossModel:GetShopModel()
    return self.guildBossShopModel
end

function GuildBossModel:GetCurId()
    return self.data.bossId
end

function GuildBossModel:GetChallengeAmount()
    return self.data.remainCount, GetBaseConfig().challengeAmount
end

function GuildBossModel:GetBlood()
    return self.data.bossHp
end

function GuildBossModel:GetRemainTime()
    if not self.data.endTime then
        return false
    end
    local serverTime = self.data.serverTime
    local realtimeSinceStartup = Time.realtimeSinceStartup
    local nowTime = serverTime + realtimeSinceStartup - self.requestTime
    local endTime = self.data.endTime
    local remainTime = endTime - nowTime
    if remainTime < 0 then
        remainTime = 0
    end
    return remainTime
end

function GuildBossModel:GetSeason()
    return self.data.season
end

function GuildBossModel:GetUpBuff(layer)
    return self.guildBossShopModel:GetUpBuff(layer)
end

function GuildBossModel:GetDownBuff(layer)
    return self.guildBossShopModel:GetDownBuff(layer)
end

function GuildBossModel:GetPerfectConditionText(layer)
    layer = tostring(layer)
    local bossInfo = self.data.bossList[layer]
    if not bossInfo or not bossInfo.perfectCond then
        return ""
    end
    return bossInfo.perfectCond.specialPass
end

function GuildBossModel:SetSelect(select)
    self.select = select
end

function GuildBossModel:GetSelect()
    if not self.select then
        self:SetSelect(self:GetCurId())
    end
    return self.select
end

function GuildBossModel:GetKillName(layer)
    layer = tostring(layer)
    if self.data.bossList[layer] then
        return self.data.bossList[layer].name or ""
    end
    return ""
end

function GuildBossModel:IsGetReward(layer)
    layer = tostring(layer)
    if self.data.bossList[layer] then
        return not not self.data.bossList[layer].received
    end
    return false
end

function GuildBossModel:GetLayerModel(layer)
    if not self.layerList then
        self.layerList = {}
    end
    if not self.layerList[layer] then
        self.layerList[layer] = GuildBossLayerModel.new(layer, self)
    end
    return self.layerList[layer]
end

function GuildBossModel:GetShowLayerList()
    local layerList = {}
    local showIndex = 0
    local index = 1
    --为了显示这里穿插了n-1个箭头
    local id = GetBaseConfig().initBossId
    local bLock = false
    while(true) do
        if self:GetCurId() == id or (self:IsFightOver() and self:GetSelect() == id) then
            bLock = true
        end
        local bossTb = {}
        bossTb.model = self:GetLayerModel(id)
        table.insert(layerList, bossTb)
        if id == self:GetSelect() then
            showIndex = index
        end
        index = index + 1
        id = bossTb.model:GetNextId()
        if id ~= nil and id ~= 0 then
            local arrowBossTb = {}
            arrowBossTb.isTransit = true
            arrowBossTb.isLockNext = bLock
            arrowBossTb.model = bossTb.model
            table.insert(layerList, arrowBossTb)
            index = index + 1
        else
            break
        end
    end
    return layerList, showIndex
end

function GuildBossModel:GetDefualtTeam()
    local playerTeamsModel = require("ui.models.PlayerTeamsModel").new()
    local teamData = playerTeamsModel:GetNowTeamData() or {}
    if teamData.rep and next(teamData.rep) then
        for k,v in pairs(teamData.rep) do 
            if tonumber(v) == 0 then
                teamData.rep[k] = nil
            end
        end
    end
    teamData.ptid = 0
    teamData.tid = 0
    teamData.isDefaultFormation = true
    return teamData or {}
end

--self.damage 不为空的时候 是从战斗出来的
function GuildBossModel:SetFightDamage(damage)
    if damage then
        self.isFightOver = self:GetCurId() > self:GetSelect()
    end
    self.damage = damage
end

function GuildBossModel:GetDamage()
    return self.damage
end

function GuildBossModel:IsFightOver()
    return self.isFightOver
end

function GuildBossModel:SetFightOver()
    self.isFightOver = nil
end

return GuildBossModel
