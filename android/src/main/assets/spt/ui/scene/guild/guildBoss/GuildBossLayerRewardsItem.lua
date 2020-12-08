local RewardDataCtrl = require("ui.controllers.common.RewardDataCtrl")
local GuildBossLayerRewardsItem = class(unity.base)

function GuildBossLayerRewardsItem:ctor()
--------Start_Auto_Generate--------
    self.levelTxt = self.___ex.levelTxt
    self.rewardTrans = self.___ex.rewardTrans
--------End_Auto_Generate----------
end

function GuildBossLayerRewardsItem:InitView(rewardsData)
    self.levelTxt.text = rewardsData.name
    res.ClearChildren(self.rewardTrans)
    local rewards = rewardsData.reward
    if type(rewards) ~= "table" then
        return
    end
    local rewardParams = {
        parentObj = self.rewardTrans,
        rewardData = rewards,
        isShowName = false,
        isReceive = false,
        isShowBaseReward = true,
        isShowCardReward = true,
        isShowDetail = true,
        isShowSymbol = false,
    }
    RewardDataCtrl.new(rewardParams)
end

return GuildBossLayerRewardsItem
