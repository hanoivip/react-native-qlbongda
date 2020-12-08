local UnityEngine = clr.UnityEngine
local WaitForSeconds = UnityEngine.WaitForSeconds
local GuideManager = require("ui.controllers.playerGuide.GuideManager")
local CommonConstants = require("ui.common.CommonConstants")
local UIBgmManager = require("ui.control.manager.UIBgmManager")
local ShareHelper = require("ui.common.ShareHelper")
local ShareConstants = require("ui.scene.shareSDK.ShareConstants")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local StaticCardModel = require("ui.models.cardDetail.StaticCardModel")
local EventSystem = require("EventSystem")

local CongratulationsPageView = class(unity.base)

function CongratulationsPageView:ctor()
    -- 奖励物品的父节点
    self.rewardBoxParent = self.___ex.rewardBoxParent
    -- 遮罩点击层
    self.mask = self.___ex.mask
    -- 动画管理器
    self.animator = self.___ex.animator
    -- 分享按钮
    self.shareBtn = self.___ex.shareBtn
    -- 奖励信息
    self.shareInfo = self.___ex.shareInfo
    -- 奖励信息文字
    self.shareInfoText = self.___ex.shareInfoText
    -- 奖励物品框
    self.rewardBoxView = nil
    -- 奖励数据
    self.rewardData = nil
    -- 暂存数据
    self.rewardDataForever = nil
    self.isPlayMoveOutAnim = false
    self.playerInfoModel = nil
    self.isPlayMoveInAnim = false
end

function CongratulationsPageView:InitView(rewardData, playerInfoModel, isGuideComment, isVisitInfo)
    self.rewardData = clone(rewardData)
    self.rewardDataForever = clone(rewardData)
    self.isGuideComment = isGuideComment
    self.isVisitInfo = isVisitInfo
    local rewardBoxObj, rewardBoxView = res.Instantiate("Assets/CapstonesRes/Game/UI/Scene/Congratulations/RewardBox.prefab")
    rewardBoxObj.transform:SetParent(self.rewardBoxParent, false)
    rewardBoxView:InitView(self.rewardData)
    self.rewardBoxView = rewardBoxView
    self.playerInfoModel = playerInfoModel
end

function CongratulationsPageView:start()
    self:BuildReward()
    self:RegisterEvent()
    self:BindAll()
    self:PlayMoveInAnim()
end

function CongratulationsPageView:BindAll()
    -- 遮罩点击层
    self.mask:regOnButtonClick(function ()
        if self.isPlayMoveInAnim then
            self.isPlayMoveInAnim = false
            self:PlayStayAnim()
        else
            if self.rewardBoxView:IsShowAll() then
                self:PlayMoveOutAnim()
            else
                -- 显示下一个奖励
                self:BuildReward()
            end
        end
    end)
    self.shareBtn:regOnButtonClick(function()
        self:OnBtnShareClick()
    end)
end

function CongratulationsPageView:SetShareBtnVisible(isVisible)
    GameObjectHelper.FastSetActive(self.shareBtn.gameObject, isVisible)
    GameObjectHelper.FastSetActive(self.shareInfo, isVisible and not cache.getIsShareTaskComplete())
end

function CongratulationsPageView:OnBtnShareClick()
    self:SetViewOnShareRender()
    local cardModel = StaticCardModel.new(self.rewardDataForever.card[1].cid)
    local posMap = cardModel:GetBriefPosition()
    local mainPos = posMap[1]
    local posText = ShareConstants.Type.Default
    if mainPos == "F" then
         posText = ShareConstants.Type.GachaFW
    elseif mainPos == "M" then
        posText = ShareConstants.Type.GachaMF
    elseif mainPos == "D" then
        posText = ShareConstants.Type.GachaDF
    elseif mainPos == "GK" then
        posText = ShareConstants.Type.GachaGK
    end
    self:coroutine(function()
        unity.waitForNextEndOfFrame()
        ShareHelper.CaptrueCamera(posText, cardModel:GetName())
    end)
end

function CongratulationsPageView:PlayMoveInAnim()
    self.animator:Play("MoveIn", 0)
    self.isPlayMoveInAnim = true
    clr.coroutine(function()
        coroutine.yield(WaitForSeconds(0.25))
        UIBgmManager.play("congratulations")
    end)
end

function CongratulationsPageView:PlayMoveOutAnim()
    self.animator:Play("MoveOut", 0)
    self.isPlayMoveOutAnim = true
end

function CongratulationsPageView:PlayStayAnim()
    self.animator:Play("MoveIn", 0, 1)
end

function CongratulationsPageView:UpdateShareTaskState()
    GameObjectHelper.FastSetActive(self.shareInfo, not cache.getIsShareTaskComplete())
end

function CongratulationsPageView:SetViewOnShareRender()
    GameObjectHelper.FastSetActive(self.shareBtn.gameObject, false)
end

function CongratulationsPageView:SetViewOnShareRenderComplete()
    GameObjectHelper.FastSetActive(self.shareBtn.gameObject, true)
end

function CongratulationsPageView:SetViewOnShareComplete()
    GameObjectHelper.FastSetActive(self.shareInfo, not cache.getIsShareTaskComplete())
end

function CongratulationsPageView:OnShareComplete()
    self:SetViewOnShareComplete()
end

function CongratulationsPageView:OnShareCancel()
    self:SetViewOnShareRenderComplete()
end

-- 注册事件
function CongratulationsPageView:RegisterEvent()
    EventSystem.AddEvent("RewardBox.HaveShowAllRewards", self, self.PlayMoveOutAnim)
    EventSystem.AddEvent("ShareRenderComplete", self, self.SetViewOnShareRenderComplete)
    EventSystem.AddEvent("ShareTask_UpdateState", self, self.UpdateShareTaskState)
    luaevt.reg("ShareSDK_OnComplete", function(cate, action)
        self:OnShareComplete() 
    end)
    luaevt.reg("ShareSDK_OnCancel", function(cate, action)
        self:OnShareCancel()
    end)
end

-- 移除事件
function CongratulationsPageView:RemoveEvent()
    EventSystem.RemoveEvent("RewardBox.HaveShowAllRewards", self, self.PlayMoveOutAnim)
    EventSystem.RemoveEvent("ShareRenderComplete", self, self.SetViewOnShareRenderComplete)
    EventSystem.RemoveEvent("ShareTask_UpdateState", self, self.UpdateShareTaskState)
    luaevt.unreg("ShareSDK_OnComplete")
    luaevt.unreg("ShareSDK_OnCancel")
end

--- 构建奖励
function CongratulationsPageView:BuildReward()
    self.rewardBoxView:BuildView()
end

function CongratulationsPageView:OnAnimEnd(animMoveType)
    if animMoveType == CommonConstants.UIAnimMoveType.MOVE_IN then
        self.isPlayMoveInAnim = false
    elseif animMoveType == CommonConstants.UIAnimMoveType.MOVE_OUT then
        self.isPlayMoveOutAnim = false
        self:Destroy()
    end
end

function CongratulationsPageView:IsPlayMoveOutAnim()
    return self.isPlayMoveOutAnim
end

function CongratulationsPageView:Destroy()
    if type(self.closeDialog) == "function" then
        self.closeDialog()
    end
end

function CongratulationsPageView:onDestroy()
    self:RemoveEvent()
    local playerInfoModel = self.playerInfoModel
    local rewardDataForever = self.rewardDataForever
    local isGuideComment = self.isGuideComment
    
    clr.coroutine(function ()
        -- 关闭恭喜获得界面
        GuideManager.Show(res.GetTopCtrl())
        coroutine.yield(WaitForSeconds(0.1))
        EventSystem.SendEvent("CongratulationsPageClosed", rewardDataForever)
        playerInfoModel:UnlockLevelUp()
        playerInfoModel:UnLockVIPLevelUp()
        -- 越南版本永久关闭好评引导
        if isGuideComment and clr.plat == "IPhonePlayer" and false then
            res.PushDialog("ui.control.guideComment.GoodGuideCtrl", false)
        end
    end)
end

return CongratulationsPageView
