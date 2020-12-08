 local BaseCtrl = require("ui.controllers.BaseCtrl")
local FancyCardPieceDetailCtrl = class(BaseCtrl)
 FancyCardPieceDetailCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Fancy/Common/FancyCardPieceDetail.prefab"
 FancyCardPieceDetailCtrl.dialogStatus = {
    touchClose = true,
    withShadow = true,
    unblockRaycast = false,
}

function FancyCardPieceDetailCtrl:Init(model)
    self.model = model
end

function FancyCardPieceDetailCtrl:Refresh()
    FancyCardPieceDetailCtrl.super.Refresh(self)
    self.view:InitView(self.model)
end

function FancyCardPieceDetailCtrl:GetStatusData()
    return self.model
end

function FancyCardPieceDetailCtrl:OnEnterScene()
    self.view:EnterScene()
end

function FancyCardPieceDetailCtrl:OnExitScene()
    self.view:ExitScene()
end

return FancyCardPieceDetailCtrl
