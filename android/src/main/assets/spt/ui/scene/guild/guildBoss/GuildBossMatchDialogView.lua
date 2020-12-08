local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local TeamLogoCtrl = require("ui.controllers.common.TeamLogoCtrl")
local GuildBossSet = require("data.GuildBossSet")
local GuildBossReward = require("data.GuildBossReward")

local GuildBossMatchDialogView = class(unity.base)

function GuildBossMatchDialogView:ctor()
--------Start_Auto_Generate--------
    self.scoreTxt = self.___ex.scoreTxt
    self.homeLogoImg = self.___ex.homeLogoImg
    self.homeNameTxt = self.___ex.homeNameTxt
    self.visitLogoImg = self.___ex.visitLogoImg
    self.visitNameTxt = self.___ex.visitNameTxt
    self.resultTxt = self.___ex.resultTxt
    self.damageTxt = self.___ex.damageTxt
    self.coinImgGo = self.___ex.coinImgGo
    self.coinNumTxt = self.___ex.coinNumTxt
    self.coinNoneGo = self.___ex.coinNoneGo
    self.killTipsGo = self.___ex.killTipsGo
    self.confirmSpt = self.___ex.confirmSpt
    self.rewardTipTxt = self.___ex.rewardTipTxt
--------End_Auto_Generate----------
end

function GuildBossMatchDialogView:start()
    DialogAnimation.Appear(self.transform)
    self.confirmSpt:regOnButtonClick(function()
        self:Close()
    end)
end

function GuildBossMatchDialogView:Close()
    DialogAnimation.Disappear(self.transform, nil, self.closeDialog)
    if self.closeClick then
        self.closeClick()
    end
end

function GuildBossMatchDialogView:InitView(matchModel)
    if not matchModel then return end
    self:InitMatchMsg(matchModel)
    self:InitResultMsg(matchModel)
    self:InitRewardTip(matchModel)
end

-- 球队/比分信息
function GuildBossMatchDialogView:InitMatchMsg(matchModel)
    local playerScore, opponentScore = matchModel:GetScoreData()
    self.scoreTxt.text = tostring(playerScore) .. " : " .. tostring(opponentScore)
    local playerTeamInfo = matchModel:GetPlayerTeamInfo()
    local opponentTeamInfo = matchModel:GetOpponentTeamInfo()
    if playerTeamInfo and opponentTeamInfo then
        TeamLogoCtrl.BuildTeamLogo(self.homeLogoImg, playerTeamInfo.logo)
        TeamLogoCtrl.BuildTeamLogo(self.visitLogoImg, opponentTeamInfo.logo)
        self.homeNameTxt.text = tostring(playerTeamInfo.teamName)
        self.visitNameTxt.text = tostring(opponentTeamInfo.teamName)
    end
end

-- 赛果信息
function GuildBossMatchDialogView:InitResultMsg(matchModel)
    self.resultTxt.text = lang.transstr("guildBoss_result_" .. tostring(matchModel:GetFinishState()))
    self.damageTxt.text = lang.transstr("guildBoss_damage_value", tostring(matchModel:GetDamage()))
    local bossCoin = tonumber(matchModel:GetBossCoin())
    self.coinNumTxt.text = lang.transstr("x" ..tostring(bossCoin))
    GameObjectHelper.FastSetActive(self.killTipsGo, matchModel:IsLastAttack())
    GameObjectHelper.FastSetActive(self.coinImgGo, bossCoin > 0 )
    GameObjectHelper.FastSetActive(self.coinNoneGo, bossCoin == 0 )
end

-- 礼盒奖励提示
function GuildBossMatchDialogView:InitRewardTip(matchModel)
    local bossId = tostring(matchModel:GetBossId())
    local bossSet = GuildBossSet[bossId]
    local num1 = 0
    local num2 = 0
    local num3 = 0
    if bossSet then
        num1, num2, num3 = self:GetRewardNum(bossSet)
    end
    self.rewardTipTxt.text = lang.transstr("guildBoss_result_tip", num1, num2, num3)
end

-- 比赛后胜利/平局/失败可获得的礼盒数量
function GuildBossMatchDialogView:GetRewardNum(bossSet)
    local challengeReward = bossSet.challengeReward
    local num1 = GuildBossReward[challengeReward["3"]].contents.item[1].num
    local num2 = GuildBossReward[challengeReward["2"]].contents.item[1].num
    local num3 = GuildBossReward[challengeReward["1"]].contents.item[1].num
    return tonumber(num1), tonumber(num2), tonumber(num3)
end

return GuildBossMatchDialogView
