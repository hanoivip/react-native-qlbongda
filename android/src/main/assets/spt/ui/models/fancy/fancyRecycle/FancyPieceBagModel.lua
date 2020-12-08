local Model = require("ui.models.Model")
local FancyCardPieceModel = require("ui.models.fancy.FancyCardPieceModel")
local FancyCardPieceMapModel = require("ui.models.fancy.FancyCardPieceMapModel")
local FancyPieceBagModel = class(Model, "FancyPieceBagModel")

function FancyPieceBagModel:ctor()
    FancyPieceBagModel.super.ctor(self)
    self:FilterCardPieceList()
end

function FancyPieceBagModel:FilterCardPieceList()
    self.fancyCardPieceMapModel = FancyCardPieceMapModel.new()
    local pieceList = self.fancyCardPieceMapModel:GetAllFancyCardPiece()
    local filterPieceList = {}
    for i, v in pairs(pieceList) do
        if v > 0 then
            local fancyCardPieceModel = FancyCardPieceModel.new()
            fancyCardPieceModel:InitWithCache(i, v)
            table.insert(filterPieceList, fancyCardPieceModel)
        end
    end
    table.sort(filterPieceList, function(a, b)
        local qualityA = a:GetQuality()
        local qualityB = b:GetQuality()
        if qualityA == qualityB then
            local groupIdA = a:GetGroupId()
            local groupIdB = b:GetGroupId()
            return groupIdA > groupIdB
        else
            return qualityA > qualityB
        end
    end)
    self.pieceModelList = filterPieceList
end

function FancyPieceBagModel:GetFilterPieceModelList()
    local selectModel = self:GetSelectCardPieceModel()
    local selectId
    if selectModel then
        selectId = selectModel:GetId()
    end
    for i, v in ipairs(self.pieceModelList) do
        local id = v:GetId()
        v.isSelect = id == selectId
    end
    return self.pieceModelList
end

function FancyPieceBagModel:SetSelectCardPieceModel(cardPieceModel)
    self.cardPieceModel = cardPieceModel
end

function FancyPieceBagModel:GetSelectCardPieceModel()
    if self.cardPieceModel then
        local num = self.cardPieceModel:GetNum()
        if num <= 0 then
            return false
        end
    end
    return self.cardPieceModel
end

return FancyPieceBagModel
