local GameObjectHelper = require("ui.common.GameObjectHelper")
local RewardDataCtrl = require("ui.controllers.common.RewardDataCtrl")
local RewardNameHelper = require("ui.scene.itemList.RewardNameHelper")
local RewardDataCtrl = require("ui.controllers.common.RewardDataCtrl")
local LadderRewardDetailItemSmallView = class(unity.base)

function LadderRewardDetailItemSmallView:ctor()
    self.rewardArea = self.___ex.rewardArea
    self.mName = self.___ex.mName
    self.nNum = self.___ex.nNum
end

function LadderRewardDetailItemSmallView:InitView(content)
    self.mName.text = content.m and "" or RewardNameHelper.GetSingleContentName(content)
    self.nNum.text ="x" .. tostring(content.m or content[next(content)][1].num)

    res.ClearChildren(self.rewardArea.transform)
    if content.card then
        for k,v in pairs(content.card) do
            content.card[k] = {id = v.id}
        end
    end
    if content.card or content.cardPiece then
        GameObjectHelper.FastSetActive(self.mName.gameObject, false)
    end
    local rewardParams = {
        parentObj = self.rewardArea,
        rewardData = content,
        isShowName = false,
        isReceive = false,
        isShowBaseReward = true,
        isShowCardReward = true,
        isShowDetail = false,
        hideCount = true,
        isHideLvl = true
    }
    RewardDataCtrl.new(rewardParams)
end

return LadderRewardDetailItemSmallView