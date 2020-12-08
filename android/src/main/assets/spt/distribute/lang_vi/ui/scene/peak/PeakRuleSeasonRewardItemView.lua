local GameObjectHelper = require("ui.common.GameObjectHelper")
local RewardDataCtrl = require("ui.controllers.common.RewardDataCtrl")
local CommonConstants = require("ui.common.CommonConstants")
local PeakRuleSeasonRewardItemView = class(unity.base)

function PeakRuleSeasonRewardItemView:ctor()
    self.firstRank = self.___ex.firstRank
    self.secondRank = self.___ex.secondRank
    self.thirdRank = self.___ex.thirdRank
    self.normalRank = self.___ex.normalRank
    self.rewardArea = self.___ex.rewardArea
end

function PeakRuleSeasonRewardItemView:InitView(data)
    self:InitRank(data)
    self:InitRewardContent(data)
end

function PeakRuleSeasonRewardItemView:CreateItem(contents)
    local obj, spt = res.Instantiate("Assets/CapstonesRes/Game/UI/Scene/Peak/RuleSeasonRewardItemSmall.prefab")
    obj.transform:SetParent(self.rewardArea.transform, false)
    spt:InitView(contents)
end

function PeakRuleSeasonRewardItemView:InitRewardContent(data)
    res.ClearChildren(self.rewardArea.transform)
    if data.contents then
        for k,v in pairs(data.contents) do
            if type(v) == "table" then
                for kk,vv in pairs(v) do
                    local tempCont = {}
                    tempCont[k] = {}
                    tempCont[k][1] = vv
                    self:CreateItem(tempCont)
                end
            else
                local tempCont = {}
                tempCont[k] = v
                self:CreateItem(tempCont)
            end
        end
    end
end

function PeakRuleSeasonRewardItemView:InitRank(data)
    GameObjectHelper.FastSetActive(self.firstRank, tonumber(data.low) == 1)
    GameObjectHelper.FastSetActive(self.secondRank, tonumber(data.low) == 2)
    GameObjectHelper.FastSetActive(self.thirdRank, tonumber(data.low) == 3)
    GameObjectHelper.FastSetActive(self.normalRank.gameObject, tonumber(data.low) ~= 1 and tonumber(data.low) ~= 2 and tonumber(data.low) ~= 3)
    if data.low == data.high then
        self.normalRank.text = lang.trans("league_rank", data.low)
    else
        if data.high == 0 then
            self.normalRank.text = lang.trans("peak_rank_range_1", data.low)
        else
            self.normalRank.text = lang.trans("peak_rank_range", data.low, data.high)
        end
    end
end

return PeakRuleSeasonRewardItemView