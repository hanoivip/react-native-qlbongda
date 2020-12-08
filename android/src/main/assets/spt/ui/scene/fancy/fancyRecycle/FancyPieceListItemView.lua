local AssetFinder = require("ui.common.AssetFinder")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local FancyCardHelper = require("ui.models.fancy.FancyCardHelper")

local FancyCardPieceBoxView = class(unity.base)

function FancyCardPieceBoxView:ctor()
    --------Start_Auto_Generate--------
    self.selectBorderGo = self.___ex.selectBorderGo
    self.borderImg = self.___ex.borderImg
    self.pieceAreaGo = self.___ex.pieceAreaGo
    self.pieceShapeImg = self.___ex.pieceShapeImg
    self.pieceMaskImg = self.___ex.pieceMaskImg
    self.cardIconImg = self.___ex.cardIconImg
    self.cardIcon2Img = self.___ex.cardIcon2Img
    self.groupImg = self.___ex.groupImg
    self.groupTxt = self.___ex.groupTxt
    self.pieceNumTxt = self.___ex.pieceNumTxt
    self.pieceNameTxt = self.___ex.pieceNameTxt
    self.clickAreaBtn = self.___ex.clickAreaBtn
    --------End_Auto_Generate----------
    self.pieceNumGradient = self.___ex.pieceNumGradient
    self.model = nil
end

function FancyCardPieceBoxView:InitView(fancyCardPieceModel, pieceClick)
    self.model = fancyCardPieceModel
    self.pieceClick = pieceClick
    self:BuildPage()
end

function FancyCardPieceBoxView:start()
    self.clickAreaBtn:regOnButtonClick(function()
        if self.pieceClick then
            self.pieceClick(self.model)
        end
    end)
end

function FancyCardPieceBoxView:BuildPage()
    local quality = self.model:GetQuality()
    local avatar = self.model:GetAvatar()
    local iconRes = AssetFinder.GetPlayerIcon(avatar)
    local groupName = self.model:GetGroupName()
    local groupIdNameColor = self.model:GetGroupIdNameColor()
    local groupIcon = self.model:GetGroupIcon()
    local num = self.model:GetNum() or 0
    local isSelect = self.model.isSelect or false

    self.cardIconImg.overrideSprite = iconRes
    self.cardIcon2Img.overrideSprite = iconRes
    local shapePath = "Assets/CapstonesRes/Game/UI/Common/Images/FancyCardPiece/FancyShape_"
    local borderPath = "Assets/CapstonesRes/Game/UI/Common/Images/FancyCardPiece/FancyBG_"
    local groupPath = "Assets/CapstonesRes/Game/UI/Common/Images/FancyCardPiece/FancyM_"
    shapePath = shapePath .. quality .. ".png"
    borderPath = borderPath .. quality .. ".png"
    groupPath = groupPath .. groupIcon .. ".png"
    local shapeRes = res.LoadRes(shapePath)
    local borderRes = res.LoadRes(borderPath)
    local groupRes = res.LoadRes(groupPath)
    self.pieceShapeImg.overrideSprite = shapeRes
    self.pieceMaskImg.overrideSprite = shapeRes
    self.borderImg.overrideSprite = borderRes
    self.groupImg.overrideSprite = groupRes
    self.groupTxt.text = "<color=" .. groupIdNameColor .. ">" .. groupName .. "</color>"
    self.pieceNameTxt.text = self.model:GetName()
    self.groupTxt.color = groupIdNameColor
    self.pieceNumTxt.text = lang.transstr("piece") .. "     x" .. string.formatNumWithUnit(num)
    local gradColors = FancyCardHelper.PieceQualityColor[quality]
    self.pieceNumGradient:ResetPointColors(#gradColors)
    for i, v in ipairs(gradColors) do
        self.pieceNumGradient:AddPointColors(i-1, v)
    end
    GameObjectHelper.FastSetActive(self.selectBorderGo, isSelect)
end

return FancyCardPieceBoxView
