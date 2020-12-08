local EventSystem = require ("EventSystem")
local Model = require("ui.models.Model")
local FancyCardPieceMapModel = class(Model, "FancyCardPieceMapModel")

function FancyCardPieceMapModel:ctor()
    FancyCardPieceMapModel.super.ctor(self)
end

function FancyCardPieceMapModel:Init(data)
    if not data then
        data = cache.GetFancyCardPieceMap() or {}
    end
    self.data = data or {}
end

function FancyCardPieceMapModel:InitWithProtocol(data)
    data = data or {}
    cache.SetFancyCardPieceMap(data)
    self:Init(data)
end

function FancyCardPieceMapModel:GetAllFancyCardPiece()
    return self.data
end

function FancyCardPieceMapModel:UpdateCardPiece(cardId, num)
    self.data[cardId] = num or 0
    cache.SetFancyCardPieceMap(self.data)
end

function FancyCardPieceMapModel:GetFancyCardPieceNum(cardId)
	return self.data[cardId] or 0
end

function FancyCardPieceMapModel:SetFancyCardPieceNum(cardId, num)
    if num == 0 then
        self.data[cardId] = nil
    else
        self.data[cardId] = num
    end
end

function FancyCardPieceMapModel:UpdateFromReward(rewardTable)
    assert(rewardTable and type(rewardTable) == "table")
    if not rewardTable.fancyCardPiece then return end
    for i, v in ipairs(rewardTable.fancyCardPiece) do
        local cardId = v.id
        local num = v.num
        self:UpdateCardPiece(cardId, num)
    end
    EventSystem.SendEvent("FancyCardPieceMapModel_UpdateFromReward")
end

return FancyCardPieceMapModel
