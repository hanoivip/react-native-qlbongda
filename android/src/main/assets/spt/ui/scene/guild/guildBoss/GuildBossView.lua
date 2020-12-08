local UnityEngine = clr.UnityEngine
local GameObjectHelper = require("ui.common.GameObjectHelper")
local AssetFinder = require("ui.common.AssetFinder")
local RewardDataCtrl = require('ui.controllers.common.RewardDataCtrl')
local DialogManager = require("ui.control.manager.DialogManager")
local SimpleIntroduceModel = require("ui.models.common.SimpleIntroduceModel")
local Timer = require('ui.common.Timer')
local UnityEngine = clr.UnityEngine
local Time = UnityEngine.Time
local WaitForSeconds = UnityEngine.WaitForSeconds
local GuildBossView = class(unity.base, "GuildBossView")

function GuildBossView:ctor()
--------Start_Auto_Generate--------
    self.backBtn = self.___ex.backBtn
    self.challengeDetailBtn = self.___ex.challengeDetailBtn
    self.storeBtn = self.___ex.storeBtn
    self.teamBtn = self.___ex.teamBtn
    self.freshBtn = self.___ex.freshBtn
    self.layerTxt = self.___ex.layerTxt
    self.upBuffTxt = self.___ex.upBuffTxt
    self.downBuffTxt = self.___ex.downBuffTxt
    self.conditionTxt = self.___ex.conditionTxt
    self.conditionTipTxt = self.___ex.conditionTipTxt
    self.challengeGo = self.___ex.challengeGo
    self.challengeTxt = self.___ex.challengeTxt
    self.challengeBtn = self.___ex.challengeBtn
    self.challengeOverTxt = self.___ex.challengeOverTxt
    self.bgImg = self.___ex.bgImg
    self.playerIconImg = self.___ex.playerIconImg
    self.ruleBtn = self.___ex.ruleBtn
    self.rankBtn = self.___ex.rankBtn
    self.fightTxt = self.___ex.fightTxt
    self.nameTxt = self.___ex.nameTxt
    self.bloodTxt = self.___ex.bloodTxt
    self.bloodSli = self.___ex.bloodSli
    self.bloodEffextGo = self.___ex.bloodEffextGo
    self.killTrans = self.___ex.killTrans
    self.killGo = self.___ex.killGo
    self.killTxt = self.___ex.killTxt
    self.killBtn = self.___ex.killBtn
    self.allTrans = self.___ex.allTrans
    self.allGo = self.___ex.allGo
    self.allTxt = self.___ex.allTxt
    self.allBtn = self.___ex.allBtn
    self.scrollViewSpt = self.___ex.scrollViewSpt
    self.timeTxt = self.___ex.timeTxt
    self.detailBtn = self.___ex.detailBtn
--------End_Auto_Generate----------
    self.freshButton = self.___ex.freshButton
    self.particle = self.___ex.particle
end

function GuildBossView:start()
    self.backBtn:regOnButtonClick(function ()
        res.PopScene()
    end)
    self.challengeDetailBtn:regOnButtonClick(function ()
        self:OnChallengeDetailClick()
    end)
    self.storeBtn:regOnButtonClick(function ()
        self:OnStoreClick()
    end)
    self.teamBtn:regOnButtonClick(function ()
        self:OnTeamClick()
    end)
    self.freshBtn:regOnButtonClick(function ()
        self:OnFreshClick()
    end)
    self.challengeBtn:regOnButtonClick(function ()
        self:OnChallengeClick()
    end)
    self.ruleBtn:regOnButtonClick(function ()
        self:OnRuleClick()
    end)
    self.rankBtn:regOnButtonClick(function ()
        self:OnRankClick()
    end)
    self.detailBtn:regOnButtonClick(function ()
        self:OnDetailClick()
    end)
end

function GuildBossView:InitView(guildBossModel, bFirst)
    self.model = guildBossModel
    self:RefreshView(bFirst)
end

function GuildBossView:RefreshView(bFirst)
    self:ShowLeft()
    self:ShowRight()
    self:ShowMiddle()
    self:ShowBottom(bFirst)
    self:ResetTimer()
end

function GuildBossView:OnBossClick(bossId)
    self.model:SetSelect(bossId)
    self:ShowLeft()
    self:ShowRight()
    self:ShowMiddle()
    self:ShowBottom()
end

function GuildBossView:ShowReward(tran, reward)
    local rewardParams = {
        parentObj = tran,
        rewardData = reward,
        isShowName = false,
        isReceive = false,
        isShowSymbol = false,
        isShowBaseReward = true,
        isShowCardReward = true,
        isShowDetail = true,
    }
    RewardDataCtrl.new(rewardParams)
end

function GuildBossView:ShowLeft()
    res.ClearChildren(self.killTrans)
    res.ClearChildren(self.allTrans)
    local guildBossLayerModel = self.model:GetLayerModel(self.model:GetSelect())
    self:ShowReward(self.killTrans, guildBossLayerModel:GetKillReward())
    self:ShowReward(self.allTrans, guildBossLayerModel:GetAllReward())

--  这里先不删 万一又要领取(md)
    GameObjectHelper.FastSetActive(self.killGo, true)
    GameObjectHelper.FastSetActive(self.allGo, true)
    GameObjectHelper.FastSetActive(self.killBtn.gameObject, false)
    GameObjectHelper.FastSetActive(self.allBtn.gameObject, false)

    if not guildBossLayerModel:IsOver() then
        if guildBossLayerModel:IsGetReward() then
            self.allTxt.text = lang.trans("guildBoss_reward_get")
        else
            self.allTxt.text = lang.trans("guildBoss_all_reward")
        end
        self.killTxt.text = lang.trans("guildBoss_kill_reward")
    else
        self.killTxt.text = "<color=#ffc200><size=24>" .. guildBossLayerModel:GetKillName() .. "</size></color>"
        if guildBossLayerModel:IsGetReward() then
            self.allTxt.text = lang.trans("guildBoss_reward_get")
        else
            self.allTxt.text = lang.trans("guildBoss_no_fight")
        end
    end
end

function GuildBossView:ShowRight()
    local guildBossLayerModel = self.model:GetLayerModel(self.model:GetSelect())
    self.layerTxt.text = tostring(self.model:GetSelect())
    self.conditionTxt.text = guildBossLayerModel:GetPerfectConditionText()
    self.conditionTipTxt.text = lang.trans("guildBoss_condition_tip", guildBossLayerModel:GetPerfectBlood())
    if guildBossLayerModel:IsLock() then
        GameObjectHelper.FastSetActive(self.challengeGo, false)
        self.challengeOverTxt.text = lang.trans("guildBoss_no_tip")
    elseif guildBossLayerModel:IsOver() then
        GameObjectHelper.FastSetActive(self.challengeGo, false)
        self.challengeOverTxt.text = lang.trans("guildBoss_challenge_over")
    else
        self.challengeTxt.text = lang.trans("guildBoss_challenge_times", self.model:GetChallengeAmount())
        GameObjectHelper.FastSetActive(self.challengeGo, true)
        self.challengeOverTxt.text = ""
    end
    self:RefreshBuff()
end

-- 设置倒计时
function GuildBossView:ResetTimer()
    if self.model:GetRemainTime() > 0 then
        self:RefreshTimer()
    else
        self:SetRunOutOfTimeView()
    end
end

function GuildBossView:RefreshTimer()
    if self.residualTimer ~= nil then
        self.residualTimer:Destroy()
    end
    local remainTime = self.model:GetRemainTime()
    local timeTitleStr = lang.transstr("residual_time")
    self.residualTimer = Timer.new(remainTime, function(time)
        if time <= 1 then
            if self.SetRunOutOfTimeView then
                self:SetRunOutOfTimeView()
            end
            return
        else
            if self.timeTxt then
                self.timeTxt.text = timeTitleStr .. string.convertSecondToTime(time)
            end
        end
    end)
end

function GuildBossView:SetRunOutOfTimeView()
    self.timeTxt.text = lang.trans("visit_endInfo")
    if self.runOutOfTime then
        self.runOutOfTime()
    end
end
function GuildBossView:RefreshBuff()
    local guildBossLayerModel = self.model:GetLayerModel(self.model:GetSelect())
    self.upBuffTxt.text = lang.transstr("allAttribute") .. '<color=#8df74c>+' .. guildBossLayerModel:GetUpBuff() .. '</color>'
    self.downBuffTxt.text = lang.transstr("allAttribute") .. '<color=#ff3238>-' .. guildBossLayerModel:GetDownBuff() .. '</color>'
    self.fightTxt.text = tostring(guildBossLayerModel:GetPower())
end

function GuildBossView:ShowMiddle()
    local guildBossLayerModel = self.model:GetLayerModel(self.model:GetSelect())
    self.nameTxt.text = '<size=56>' .. guildBossLayerModel:GetTeamYear() .. '</size>' .. '<size=24>' .. guildBossLayerModel:GetTeamName() .. '</size>'
    self.bgImg.overrideSprite = AssetFinder.GetGuildBossIcon("Group/" .. guildBossLayerModel:GetBgIcon())
    self.playerIconImg.overrideSprite = AssetFinder.GetGuildBossIcon("Group/" .. guildBossLayerModel:GetPlayerIcon())
    self:ShowBloodBeforeEffect(guildBossLayerModel)
end

function GuildBossView:ShowBloodBeforeEffect(guildBossLayerModel)
    local damage = self.model:GetDamage()
    if damage then
        self:ShowBloodInfo(guildBossLayerModel:GetBlood() + damage, true, true)
    else
        self.effectIsOver = true
        self:ShowBloodInfo(guildBossLayerModel:GetBlood(), guildBossLayerModel:isFight(), true)
    end
end

function GuildBossView:ShowBloodInfo(blood, bShowEffect, bInit)
    local guildBossLayerModel = self.model:GetLayerModel(self.model:GetSelect())
    local maxBlood = guildBossLayerModel:GetMaxBlood()
    GameObjectHelper.FastSetActive(self.bloodEffextGo, bShowEffect)
    self.bloodSli.value = blood / maxBlood
    self.bloodTxt.text = '<size=30><color=#ff2c31>' .. blood .. '</color></size>' .. '<size=18>/' .. maxBlood .. '</size>'
    bShowEffect = bShowEffect and blood ~= 0
    if bInit then
        local emission = self.particle.emission
        emission.enabled = false
        self:coroutine(
        function()
            coroutine.yield(WaitForSeconds(1))
            emission.enabled = true
        end)
    end
    
end

function GuildBossView:ShowBottom(bFirst)
    local list, index = self.model:GetShowLayerList()
    if bFirst then
        self.scrollViewSpt:InitView(list)
        self.scrollViewSpt:scrollToCellImmediate(index)
    else
        self.scrollViewSpt:RefreshShow(list)
    end
    self.model:SetFightOver()
end

function GuildBossView:OnChallengeDetailClick()
    if self.onChallengeDetailClick then
        self.onChallengeDetailClick()
    end
end

function GuildBossView:OnStoreClick()
    if self.onStoreClick then
        self.onStoreClick()
    end
end

function GuildBossView:OnTeamClick()
    if self.onTeamClick then
        self.onTeamClick()
    end
end

local lockTime = 30
local lockStartTime = -100 --没有实际意义 与lockTime和为负值就可以 
function GuildBossView:OnFreshClick()
    local time = lockTime + lockStartTime - Time.realtimeSinceStartup 
    if time > 0 then
        DialogManager.ShowToast(lang.transstr("guildBoss_fresh_cd", math.ceil(time)))
        return
    end
    lockStartTime = Time.realtimeSinceStartup
    if self.onFreshClick then
        self.onFreshClick()
    end
end

function GuildBossView:OnChallengeClick()
    if self.onChallengeClick then
        self.onChallengeClick(self.model:GetSelect())
    end
end

function GuildBossView:OnRuleClick()
    local simpleIntroduceModel = SimpleIntroduceModel.new(26, "GuideBossBlood")
    res.PushDialog("ui.controllers.common.SimpleIntroduceCtrl", simpleIntroduceModel)
end

function GuildBossView:OnRankClick()
    if self.onRankClick then
        self.onRankClick()
    end
end

function GuildBossView:OnDetailClick()
    if self.onDetailClick then
        self.onDetailClick()
    end
end

function GuildBossView:OnEnterScene()
    self:RegEvent()
end

function GuildBossView:OnExitScene()
    self:UnRegEvent()
    if self.residualTimer ~= nil then
        self.residualTimer:Destroy()
    end
    self.effectIsOver = true
end

local flagTime = 0.617
local arrowTime = 1.6
function GuildBossView:ShowOverLayerEffect()
    local id = self.model:GetSelect()
    local curId = self.model:GetCurId()
    if curId == id then
        return
    end
    self.scrollViewSpt:CloseFlagEffect()
    clr.coroutine(function()
        coroutine.yield(WaitForSeconds(1))
        if not self.effectIsOver then
            repeat
                self.scrollViewSpt:ShowArrowEffect(id)
                coroutine.yield(WaitForSeconds(arrowTime))
                local guildBossLayerModel = self.model:GetLayerModel(id)
                id = guildBossLayerModel:GetNextId()
                self.scrollViewSpt:ShowFlagEffect(id)
                coroutine.yield(WaitForSeconds(flagTime))
            until self.effectIsOver or id == curId
        end
        self.scrollViewSpt:CloseFlagEffect()
        self.scrollViewSpt:ShowFlagLoopEffect(curId)
    end)
end

function GuildBossView:PlayEffect()
    self:ShowBloodEffect()
    self:ShowOverLayerEffect()
end

local showTime = 2.5
local time = 0
function GuildBossView:ShowBloodEffect()
    local guildBossLayerModel = self.model:GetLayerModel(self.model:GetSelect())
    self.damage = self.model:GetDamage()
    if self.damage then
        self.model:SetFightDamage()
        self.effectIsOver = false
        self.startTime = UnityEngine.Time.realtimeSinceStartup
    else
        self.effectIsOver = true
        self:ShowBloodInfo(guildBossLayerModel:GetBlood(), guildBossLayerModel:isFight())
    end
end

function GuildBossView:update()
    if self.effectIsOver or not self.startTime then
        return
    end
    time = showTime - Time.realtimeSinceStartup + self.startTime
    if time < 0 then
        time = 0
    end
    local guildBossLayerModel = self.model:GetLayerModel(self.model:GetSelect())
    self:ShowBloodInfo(guildBossLayerModel:GetBlood() + math.floor(self.damage * time / showTime), true)
    if time <= 0 then
        self.startTime = nil
    end
end

function GuildBossView:RegEvent()
    EventSystem.AddEvent("GuildBossItem.OnClick", self, self.OnBossClick)  --点击BOSS
    EventSystem.AddEvent("GuildBoss_buy_success", self, self.RefreshBuff)
    EventSystem.AddEvent("GuildBoss_playEffect", self, self.PlayEffect)
end

function GuildBossView:UnRegEvent()
    EventSystem.RemoveEvent("GuildBossItem.OnClick", self, self.OnBossClick)
    EventSystem.RemoveEvent("GuildBoss_buy_success", self, self.RefreshBuff)
    EventSystem.RemoveEvent("GuildBoss_playEffect", self, self.PlayEffect)
end

return GuildBossView
