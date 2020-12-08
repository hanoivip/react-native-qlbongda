local BaseCtrl = require("ui.controllers.BaseCtrl")
local FancyCardsMapModel = require("ui.models.fancy.FancyCardsMapModel")
local DialogManager = require("ui.control.manager.DialogManager")
local FancyRecycleModel = require("ui.models.fancy.fancyRecycle.FancyRecycleModel")
local FancyBagModel = require("ui.models.fancy.fancyRecycle.FancyBagModel")
local FancyPieceBagModel = require("ui.models.fancy.fancyRecycle.FancyPieceBagModel")
local FancyGachaInfoBarCtrl = require("ui.controllers.common.FancyGachaInfoBarCtrl")
local CongratulationsPageCtrl = require("ui.controllers.congratulations.CongratulationsPageCtrl")
local FancyCardResourceCache = require('ui.common.fancycard.FancyCardResourceCache')
local FancyCardPieceMapModel = require("ui.models.fancy.FancyCardPieceMapModel")
local FancyCardPieceModel = require("ui.models.fancy.FancyCardPieceModel")
local FancyRecycleCtrl = class(BaseCtrl, "LegendRoadCtrl")

FancyRecycleCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Fancy/FancyRecycle/FancyRecycle.prefab"

function FancyRecycleCtrl:ctor()
    FancyRecycleCtrl.super.ctor(self)
end

function FancyRecycleCtrl:Init(tag)
    self.view.recycleClick = function() self:OnRecycleClick() end
    self.view.onTabClick = function(topTag) self:OnTabClick(topTag) end
    self.view.pieceUse = function(topTag) self:OnPieceIncorporate() end
    self:RegInfoBar()
end

function FancyRecycleCtrl:RegInfoBar()
    self.view:RegOnDynamicLoad(function(child)
        local param = {}
        param.isHideBack = true
        param.isHideDiamond = true
        param.isHideFancyTicket1 = true
        param.isHideFancyTicket10 = true
        param.isHidePiece = true
        param.isHideMoney = true
        self.infoBarCtrl = FancyGachaInfoBarCtrl.new(child, param)
    end)
end

function FancyRecycleCtrl:Refresh(tag, fancyBagModel)
    FancyRecycleCtrl.super.Refresh(self)
    self.fancyCardsMapModel = FancyCardsMapModel.new()
    self.fancyCardResourceCache = self.fancyCardResourceCache or FancyCardResourceCache.new()
    self.model = FancyRecycleModel.new()
    self.fancyBagModel = fancyBagModel
    if not self.fancyBagModel then
        self.fancyBagModel = FancyBagModel.new()
    end
    if not self.fancyPieceBagModel then
        self.fancyPieceBagModel = FancyPieceBagModel.new()
    end
    self.fancyBagModel:FilterCardList()
    self.tag = tag
    self.view:InitView(self.model, self.fancyBagModel, self.fancyPieceBagModel, tag, self.fancyCardResourceCache)
end

function FancyRecycleCtrl:OnRecycleClick()
    local title = lang.trans("tips")
    local content = lang.trans("fancy_recycle_confirm")
    DialogManager.ShowConfirmPop(title, content, function()
        self:OnRecycle()
    end)
end

function FancyRecycleCtrl:OnRecycle()
    local selectCards = self.model:GetSelectCards()
    self.view:coroutine(function()
        local response = req.fancyCardDecomposition(selectCards)
        if api.success(response) then
            local data = response.val
            CongratulationsPageCtrl.new(data.contents)
            for i, v in pairs(data.cost) do
                local cardData = v.fancyCard
                self.fancyCardsMapModel:UpdateCard(cardData.id, cardData.star, cardData.num)
            end
            self.model:FilterCardList()
            self.view:InitRecycle()
        end
    end)
end

function FancyRecycleCtrl:OnPieceIncorporate()
    local fancyCardPieceModel = self.fancyPieceBagModel:GetSelectCardPieceModel()
    local fancyCardId = fancyCardPieceModel:GetId()
    local pieceNum = fancyCardPieceModel:GetNum()
    local composeNeedPieceNum = fancyCardPieceModel:GetComposeNeedPiece()
    if not fancyCardId then
        return
    end
    if pieceNum < composeNeedPieceNum then
        DialogManager.ShowToastByLang("need_piece_enough")
        return
    end
    self.view:coroutine(function()
        local response = req.fancyCardIncorporate(fancyCardId)
        if api.success(response) then
            local data = response.val
            CongratulationsPageCtrl.new(data.contents)
            local fancyCardPieceMapModel = FancyCardPieceMapModel.new()
            local costPiece = data.cost.fancyCardPiece
            fancyCardPieceMapModel:SetFancyCardPieceNum(costPiece.id, costPiece.num)
            local cardPieceModel = FancyCardPieceModel.new()
            cardPieceModel:InitWithCache(costPiece.id, costPiece.num)
            self.fancyPieceBagModel:SetSelectCardPieceModel(cardPieceModel)
            self.fancyPieceBagModel:FilterCardPieceList()
            self.view:InitFancyPiece()
        end
    end)
end


function FancyRecycleCtrl:GetStatusData()
    return self.tag, self.fancyBagModel
end

function FancyRecycleCtrl:OnTabClick(topTag)
    self.tag = topTag
end

function FancyRecycleCtrl:OnEnterScene()
    self.view:EnterScene()
end

function FancyRecycleCtrl:OnExitScene()
    self.view:ExitScene()
    self.fancyCardResourceCache:Clear()
end

-- 点击返回按钮
function FancyRecycleCtrl:OnBtnBackClick()
    res.PopScene()
end

return FancyRecycleCtrl
