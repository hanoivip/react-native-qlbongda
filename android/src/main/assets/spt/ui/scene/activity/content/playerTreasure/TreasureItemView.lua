local UnityEngine = clr.UnityEngine
local Vector3 = UnityEngine.Vector3
local WaitForSeconds = UnityEngine.WaitForSeconds
local AssetFinder = require("ui.common.AssetFinder")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local EventSystem = require("EventSystem")
local RewardNameHelper = require("ui.scene.itemList.RewardNameHelper")
local RewardDataCtrl = require("ui.controllers.common.RewardDataCtrl")

local TreasureItemView = class(unity.base)

local TreasureType = {
    ZHIZUN = 1,    --标记为至尊的礼盒
    DIANCANG = 2,  --标记为典藏的礼盒
}
function TreasureItemView:ctor()
    self.itemAreaTrans = self.___ex.itemAreaTrans
    self.treasureTypeImg = self.___ex.treasureTypeImg
    self.receiveGo = self.___ex.receiveGo
    self.effectGo = self.___ex.effectGo
    self.animator = self.___ex.animator
    self.itemNameTxt = self.___ex.itemNameTxt
    self.typeTxt = self.___ex.typeTxt
    self.cardBackEffect = self.___ex.cardBackEffect
    self.typeStarEffect = self.___ex.typeStarEffect
    EventSystem.AddEvent("TreasureItemSetAnimatorState", self, self.SetAnimatorState)
    EventSystem.AddEvent("TreasureItemHideItem", self, self.HideItem)
end

function TreasureItemView:InitView(treasureData)
    self.treasureType = treasureData.treasureType
    local receiveStatus = treasureData.receiveStatus or false
    local isEffectReward = self.treasureType == TreasureType.ZHIZUN or self.treasureType == TreasureType.DIANCANG
    GameObjectHelper.FastSetActive(self.receiveGo, receiveStatus)
    GameObjectHelper.FastSetActive(self.effectGo, self.treasureType == TreasureType.ZHIZUN or self.treasureType == TreasureType.DIANCANG)
    GameObjectHelper.FastSetActive(self.treasureTypeImg.gameObject, isEffectReward)
    GameObjectHelper.FastSetActive(self.cardBackEffect, isEffectReward)
    GameObjectHelper.FastSetActive(self.typeStarEffect, isEffectReward)
    self.animator.enabled = isEffectReward
    if self.treasureType == TreasureType.ZHIZUN then
        self.treasureTypeImg.overrideSprite = AssetFinder.GetRecommendCornerIcon("Blue")
         self.typeTxt.text = lang.trans("player_treasure_type1")
        self.typeTxt.color = UnityEngine.Color(1, 1, 1)
    elseif self.treasureType == TreasureType.DIANCANG then
        self.treasureTypeImg.overrideSprite = AssetFinder.GetRecommendCornerIcon("Yellow")
        self.typeTxt.text = lang.trans("player_treasure_type2")
        self.typeTxt.color = UnityEngine.Color(0.28, 0.23, 0.1)
    else
        GameObjectHelper.FastSetActive(self.treasureTypeImg.gameObject, false)
        GameObjectHelper.FastSetActive(self.effectGo, false)
    end
    if treasureData.contents.pasterPiece or treasureData.contents.cardPiece then
        self.itemAreaTrans.localScale = Vector3(0.85, 0.85, 0.85)
    end

    local rewardName =RewardNameHelper.GetSingleContentName(treasureData.contents)
    rewardName = string.gsub(rewardName, "%s*(.-)%s*", "%1")
    self.itemNameTxt.text = rewardName
    local rewardParams = {
        parentObj = self.itemAreaTrans,
        rewardData = treasureData.contents,
        isShowName = false,
        isReceive = false,
        isShowBaseReward = true,
        isShowCardReward = true,
        isShowDetail = true,
        isShowSymbol = false
    }
    RewardDataCtrl.new(rewardParams)
end

function TreasureItemView:SetAnimatorState(animatorStatus)
    self.animator.enabled = true
    self.animator:Play("TreasureItemReflashAnimation")
    self:coroutine(function()
        coroutine.yield(WaitForSeconds(0.1))
        GameObjectHelper.FastSetActive(self.itemAreaTrans.gameObject, true)
    end)
end

function TreasureItemView:HideItem()
    GameObjectHelper.FastSetActive(self.itemAreaTrans.gameObject, false)
end

function TreasureItemView:onDestroy()
    EventSystem.RemoveEvent("TreasureItemSetAnimatorState", self, self.SetAnimatorState)
    EventSystem.RemoveEvent("TreasureItemHideItem", self, self.HideItem)
end

return TreasureItemView
