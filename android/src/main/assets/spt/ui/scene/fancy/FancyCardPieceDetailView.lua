local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local FancyCardPieceDetailView = class(unity.base)

function FancyCardPieceDetailView:ctor()
--------Start_Auto_Generate--------
    self.titleTxt = self.___ex.titleTxt
    self.itemIconAreaTrans = self.___ex.itemIconAreaTrans
    self.itemNameTxt = self.___ex.itemNameTxt
    self.ownNumTxt = self.___ex.ownNumTxt
    self.introductionTxt = self.___ex.introductionTxt
    self.closeBtn = self.___ex.closeBtn
--------End_Auto_Generate----------
    self.canvasGroup = self.___ex.canvasGroup
end

function FancyCardPieceDetailView:start()
    self.closeBtn:regOnButtonClick(function()
        self:Close()
    end)
    DialogAnimation.Appear(self.transform, self.canvasGroup)
end

function FancyCardPieceDetailView:InitView(fancyCardPieceModel)
    local model = fancyCardPieceModel
    local name = model:GetName()
    local des = model:GetDesc()
    local num = model:GetNum()
    self.titleTxt.text = lang.trans("itemDetail_title")
    self.itemNameTxt.text = name
    self.ownNumTxt.text = lang.trans("itemDetail_number", num)
    self.introductionTxt.text = des
    res.ClearChildren(self.itemIconAreaTrans)
    local avatarBoxObj, avatarBoxView = res.Instantiate("Assets/CapstonesRes/Game/UI/Common/Part/FancyCardPiece.prefab")
    avatarBoxObj.transform:SetParent(self.itemIconAreaTrans, false)
    avatarBoxView:InitView(model, true, false, false)
end

function FancyCardPieceDetailView:Close()
    DialogAnimation.Disappear(self.transform, self.canvasGroup, function()
        if type(self.closeDialog) == 'function' then
            self.closeDialog()
        end
    end)
end

function FancyCardPieceDetailView:EnterScene()
end

function FancyCardPieceDetailView:ExitScene()
end

return FancyCardPieceDetailView
