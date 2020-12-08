local UnityEngine = clr.UnityEngine
local Vector2 = UnityEngine.Vector2
local Vector3 = UnityEngine.Vector3
local AssetFinder = require("ui.common.AssetFinder")
local GameObjectHelper = require("ui.common.GameObjectHelper")

local FancyCardPieceBoxView = class(unity.base)

local GroupHeightScaleFactor = 0.2153
local GroupPosScaleFactor = 0.378

function FancyCardPieceBoxView:ctor()
    self.border = self.___ex.border
    self.pieceMask = self.___ex.pieceMask
    self.pieceShape = self.___ex.pieceShape
    self.cardIcon = self.___ex.cardIcon
    self.cardIcon2 = self.___ex.cardIcon2
    -- 名称
    self.nameTxt = self.___ex.name
    self.nameShadow = self.___ex.nameShadow
    -- 获得的数量
    self.addNum = self.___ex.addNum
    self.addNumText = self.___ex.addNumText
    -- 碎片图标
    self.rectTrans = self.___ex.rectTrans
    self.btnClick = self.___ex.btnClick
    -- 组名字的品质背景
    self.groupImg = self.___ex.groupImg
    -- 组名字
    self.groupTxt = self.___ex.groupTxt

    self.model = nil
    -- 是否显示名称
    self.isShowName = false
    -- 是否显示获得的数量
    self.isShowAddNum = false
    -- 是否要显示详情板
    self.isShowDetail = false
end

function FancyCardPieceBoxView:InitView(fancyCardPieceModel, isShowName, isShowAddNum, isShowDetail)
    self.model = fancyCardPieceModel
    self.isShowName = isShowName or false
    self.isShowAddNum = isShowAddNum or false
    self.isShowDetail = isShowDetail or false
    self:BuildPage()
end

function FancyCardPieceBoxView:start()
    self:ResetAddNumSize()
    self:ResetGroupSize()
    if self.isShowDetail then
        self.btnClick:regOnButtonClick(function()
            self:OnFancyPieceBoxClick()
        end)
    end
end

function FancyCardPieceBoxView:BuildPage()
    local quality = self.model:GetQuality()
    local avatar = self.model:GetAvatar()
    local iconRes = AssetFinder.GetPlayerIcon(avatar)
    local groupName = self.model:GetGroupName()
    local groupIcon = self.model:GetGroupIcon()
    local groupIdNameColor = self.model:GetGroupIdNameColor()

    self.cardIcon.overrideSprite = iconRes
    self.cardIcon2.overrideSprite = iconRes
    local shapePath = "Assets/CapstonesRes/Game/UI/Common/Images/FancyCardPiece/FancyShape_"
    local borderPath = "Assets/CapstonesRes/Game/UI/Common/Images/FancyCardPiece/FancyBG_"
    local groupPath = "Assets/CapstonesRes/Game/UI/Common/Images/FancyCardPiece/FancyM_"
    shapePath = shapePath .. quality .. ".png"
    borderPath = borderPath .. quality .. ".png"
    groupPath = groupPath .. groupIcon .. ".png"
    local shapeRes = res.LoadRes(shapePath)
    local borderRes = res.LoadRes(borderPath)
    local groupRes = res.LoadRes(groupPath)
    self.pieceShape.overrideSprite = shapeRes
    self.pieceMask.overrideSprite = shapeRes
    self.border.overrideSprite = borderRes
    self.groupImg.overrideSprite = groupRes
    self.groupTxt.text = "<color=" .. groupIdNameColor .. ">" .. groupName .. "</color>"

    if self.isShowName then
        self.nameTxt.text = self.model:GetName()
    end
    if self.isShowAddNum then
        local addNum = self.model:GetAddNum() or 0
        self.addNumText.text = "x" .. string.formatNumWithUnit(addNum)
    end
    GameObjectHelper.FastSetActive(self.addNum.gameObject, self.isShowAddNum)
    GameObjectHelper.FastSetActive(self.nameTxt.gameObject, self.isShowName)
end

function FancyCardPieceBoxView:ResetAddNumSize()
    self:coroutine(function ()
        unity.waitForEndOfFrame()
        local boxRect = self.rectTrans.rect
        if boxRect.width ~= 82 then
            local scaleFactor = boxRect.width / 82
            scaleFactor = (scaleFactor - 1) / 2 + 1
            self.addNumText.fontSize = math.floor(16 * scaleFactor)
            local addNumSize = self.addNum.sizeDelta
            self.addNum.sizeDelta = Vector2(addNumSize.x, addNumSize.y * scaleFactor)
        end
    end)
end

function FancyCardPieceBoxView:ResetGroupSize()
    self:coroutine(function ()
        unity.waitForEndOfFrame()
        unity.waitForEndOfFrame()
        local pieceY = self.rectTrans.sizeDelta.y
        local groupTrans = self.groupImg.transform
        local groupSize = groupTrans.sizeDelta
        local heightY = math.clamp(pieceY * GroupHeightScaleFactor, 22, pieceY)
        local posY = pieceY * GroupPosScaleFactor * -1
        groupTrans.sizeDelta = Vector2(groupSize.x, heightY)
        groupTrans.localPosition = Vector3(groupTrans.localPosition.x, posY, 0)
    end)
end

--- 设置名称颜色
function FancyCardPieceBoxView:SetNameColor(nameColor, nameShadowColor)
    self.nameTxt.color = nameColor
    self.nameShadow.effectColor = nameShadowColor
end

--- 设置名称字号
function FancyCardPieceBoxView:SetNumFont(numFont)
    self.isFixNumFont = true
    self.addNumText.fontSize = numFont
    self.nameTxt.fontSize = numFont
end

function FancyCardPieceBoxView:OnFancyPieceBoxClick()
    res.PushDialog("ui.controllers.fancy.FancyCardPieceDetailCtrl", self.model)
end

return FancyCardPieceBoxView
