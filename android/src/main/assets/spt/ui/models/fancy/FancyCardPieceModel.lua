local FancyCard = require("data.FancyCard")
local FancyGroup = require("data.FancyGroup")
local Model = require("ui.models.Model")
local FancyCardHelper = require("ui.models.fancy.FancyCardHelper")
local FancyCardPieceModel = class(Model, "FancyPieceModel")

function FancyCardPieceModel:ctor()
    FancyCardPieceModel.super.ctor(self)
    self.isPlayerPiece = false
end

function FancyCardPieceModel:InitWithCache(id, num)
    self.id = id
    self.num = num
    self:AllotPieceData()
end

function FancyCardPieceModel:InitWithStatic(id, addNum)
    self.id = id
    self.add = addNum or 0
    local FancyCardPieceMapModel = require("ui.models.fancy.FancyCardPieceMapModel")
    local fancyCardPieceMapModel = FancyCardPieceMapModel.new()
    local num = fancyCardPieceMapModel:GetFancyCardPieceNum(self.id)
    self.num = num
    self:AllotPieceData()
end

function FancyCardPieceModel:AllotPieceData()
    self.staticData = FancyCard[self.id]
end

function FancyCardPieceModel:GetId()
    return self.id
end

function FancyCardPieceModel:GetAddNum()
    return self.add or 0
end

function FancyCardPieceModel:GetNum()
    return self.num or 0
end

function FancyCardPieceModel:GetName()
    return self.staticData.name
end

function FancyCardPieceModel:GetPicIndex()
    return self.staticData.picIndex
end

function FancyCardPieceModel:GetGroupId()
    return tonumber(self.staticData.groupID)
end

function FancyCardPieceModel:GetGroupIcon()
    local groupID = tostring(self:GetGroupId())
    return FancyGroup[groupID].groupIcon
end

function FancyCardPieceModel:GetGroupName()
    local groupID = tostring(self:GetGroupId())
    return FancyGroup[groupID].fancyCardName
end

function FancyCardPieceModel:GetGroupIdNameColor()
    local groupID = tostring(self:GetGroupId())
    return FancyGroup[groupID].groupNameColorSmall
end

function FancyCardPieceModel:GetPieceName()
    local pieceName = self.staticData.name .. lang.transstr("fancy_piece")
    return pieceName
end

function FancyCardPieceModel:GetQuality()
    return self.staticData.quality
end

function FancyCardPieceModel:GetQualityName()
    local quality = self:GetQuality()
    return FancyCardHelper.QualitySign[tonumber(quality)]
end

-- 合成一张梦幻卡所需的碎片数量
function FancyCardPieceModel:GetComposeNeedPiece()
    return self.staticData.fancyCardPiece
end

function FancyCardPieceModel:GetAvatar()
    return self.staticData.pictureID
end

function FancyCardPieceModel:GetStaticDesc()
    return self.staticData.desc or ""
end

function FancyCardPieceModel:GetDesc()
    local pieceNum = self:GetComposeNeedPiece()
    local qualityName = self:GetQualityName()
    local cardName = self:GetName()
    local groupName = self:GetGroupName()
    qualityName = lang.transstr(qualityName)
    return lang.trans("fancy_piece_desc", pieceNum, qualityName, cardName, groupName)
end

function FancyCardPieceModel:GetContentText()
    return ""
end

function FancyCardPieceModel:GetTypeName()
    return lang.trans("piece")
end

function FancyCardPieceModel:GetPieceBg(quality)
    return quality
end

function FancyCardPieceModel:IsShowButton()
    return false
end

return FancyCardPieceModel
