local CongratulationsPageCtrl = require("ui.controllers.congratulations.CongratulationsPageCtrl")
local BaseCtrl = require("ui.controllers.BaseCtrl")
local GuildBossMatchDialogCtrl = class(BaseCtrl, "GuildBossMatchDialogCtrl")

GuildBossMatchDialogCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/GuildBoss/GuildBossMatchDialog.prefab"

function GuildBossMatchDialogCtrl:Init(matchModel)
    self.matchModel = matchModel
    self.view.closeClick = function() self:Close() end
    self.view:InitView(matchModel)
end

function GuildBossMatchDialogCtrl:Close()
    local rewards = self.matchModel:GetRewards()
    if table.nums(rewards) ~= 0 then
        CongratulationsPageCtrl.new(rewards)
    end
    self.matchModel:ClearMatch()
    EventSystem.SendEvent("GuildBoss_playEffect")
end

return GuildBossMatchDialogCtrl