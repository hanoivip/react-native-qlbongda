local UnityEngine = clr.UnityEngine
local Object = UnityEngine.Object
local ItemModel = require("ui.models.ItemModel")
local AssetFinder = require("ui.common.AssetFinder")
local CardPieceModel = require("ui.models.cardDetail.CardPieceModel")
local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local GameObjectHelper = require("ui.common.GameObjectHelper")

local LadderRewardDetailView = class(unity.base)

function LadderRewardDetailView:ctor()
    self.btnClose = self.___ex.btnClose
    self.txtMyRank = self.___ex.txtMyRank
    self.scrollView = self.___ex.scrollView
    self.canvasGroup = self.___ex.canvasGroup
    self.rewardArea = self.___ex.rewardArea
end

function LadderRewardDetailView:start()
    self:BindButtonHandler()
    self:PlayInAnimator()
end

function LadderRewardDetailView:CreateItem(contents)
    local obj, spt = res.Instantiate("Assets/CapstonesRes/Game/UI/Scene/Ladder/LadderRewardDetailItemSmallBar.prefab")
    obj.transform:SetParent(self.rewardArea.transform, false)
    spt:InitView(contents)
end

function LadderRewardDetailView:InitView(ladderModel)
    self.ladderModel = ladderModel
    local mySeasonRankInfo = self.ladderModel:GetMySeasonRankInfo()
    if mySeasonRankInfo then
        self.txtMyRank.text = tostring(mySeasonRankInfo.rank)
    else
        self.txtMyRank.text = ""
    end
    local mySeasonRewardData = self.ladderModel:GetMySeasonRewardData()
    if mySeasonRewardData and mySeasonRewardData.contents then
        -- res.ClearChildren(self.rewardArea.transform)
        for k,v in pairs(mySeasonRewardData.contents) do
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

function LadderRewardDetailView:ClearItemBox()

end

function LadderRewardDetailView:BindButtonHandler()
    self.btnClose:regOnButtonClick(function()
        self:Close()
    end)
end

function LadderRewardDetailView:PlayInAnimator()
    DialogAnimation.Appear(self.transform, self.canvasGroup)
end

function LadderRewardDetailView:PlayOutAnimator()
    DialogAnimation.Disappear(self.transform, self.canvasGroup, function() self:CloseView() end)
end

function LadderRewardDetailView:CloseView()
    if type(self.closeDialog) == 'function' then
        self.closeDialog()
    end
end

function LadderRewardDetailView:Close()
    self:PlayOutAnimator()
end

return LadderRewardDetailView