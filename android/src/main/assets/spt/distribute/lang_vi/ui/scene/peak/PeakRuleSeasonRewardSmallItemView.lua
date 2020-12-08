local GameObjectHelper = require("ui.common.GameObjectHelper")
local RewardDataCtrl = require("ui.controllers.common.RewardDataCtrl")
local RewardNameHelper = require("ui.scene.itemList.RewardNameHelper")
local RewardDataCtrl = require("ui.controllers.common.RewardDataCtrl")
local PeakRuleSeasonRewardSmallItemView = class(unity.base)

function PeakRuleSeasonRewardSmallItemView:ctor()
    self.rewardArea = self.___ex.rewardArea
    self.mName = self.___ex.mName
    self.nNum = self.___ex.nNum
end

function PeakRuleSeasonRewardSmallItemView:InitView(content)
     res.ClearChildren(self.rewardArea.transform)
     local rewardParams = {
        parentObj = self.rewardArea,
        rewardData = content,
        isShowName = false,
        isReceive = false,
        isShowBaseReward = true,
        isShowCardReward = true,
        isShowDetail = false,
        hideCount =true
    }
    RewardDataCtrl.new(rewardParams)
    self.mName.text = RewardNameHelper.GetSingleContentName(content)
    self.nNum.text ="x" .. tostring(content.pp or content[next(content)][1].num)
end

return PeakRuleSeasonRewardSmallItemView