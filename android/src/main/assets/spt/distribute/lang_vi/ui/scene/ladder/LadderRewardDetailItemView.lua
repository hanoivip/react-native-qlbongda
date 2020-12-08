local UnityEngine = clr.UnityEngine
local Object = UnityEngine.Object
local ItemModel = require("ui.models.ItemModel")
local AssetFinder = require("ui.common.AssetFinder")
local CardPieceModel = require("ui.models.cardDetail.CardPieceModel")
local GameObjectHelper = require("ui.common.GameObjectHelper")

local LadderRewardDetailItemView = class(unity.base)

function LadderRewardDetailItemView:ctor()
    self.firstRank = self.___ex.firstRank
    self.secondRank = self.___ex.secondRank
    self.thirdRank = self.___ex.thirdRank
    self.normalRank = self.___ex.normalRank
    self.txtNormalRank = self.___ex.txtNormalRank
    self.rewardArea = self.___ex.rewardArea
end

function LadderRewardDetailItemView:CreateItem(contents)
    local obj, spt = res.Instantiate("Assets/CapstonesRes/Game/UI/Scene/Ladder/LadderRewardDetailItemSmallBar.prefab")
    obj.transform:SetParent(self.rewardArea.transform, false)
    spt:InitView(contents)
end

function LadderRewardDetailItemView:InitView(data)
    local rankLow = data.rankLow
    local rankHigh = data.rankHigh
    self:SetRankShowStatus(rankLow, rankHigh)
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

function LadderRewardDetailItemView:SetRankShowStatus(rankLow, rankHigh)
    local isTopThree, isFirst, isSecond, isThird = true, false, false, false
    if rankLow == 1 and rankHigh == 1 then 
        isFirst = true
    elseif rankLow == 2 and rankHigh == 2 then 
        isSecond = true
    elseif rankLow == 3 and rankHigh == 3 then 
        isThird = true
    else
        isTopThree = false
        local rankStr
        if rankHigh == rankLow then 
            rankStr = lang.trans("ladder_rewardDetail_rank2", tostring(rankHigh))
        else
            rankStr = lang.trans("ladder_rewardDetail_rank", tostring(rankHigh), tostring(rankLow))
        end
        self.txtNormalRank.text = rankStr
    end

    GameObjectHelper.FastSetActive(self.firstRank, isFirst)
    GameObjectHelper.FastSetActive(self.secondRank, isSecond)
    GameObjectHelper.FastSetActive(self.thirdRank, isThird)
    GameObjectHelper.FastSetActive(self.normalRank, not isTopThree)
end

function LadderRewardDetailItemView:ClearRewardItems()

end

return LadderRewardDetailItemView