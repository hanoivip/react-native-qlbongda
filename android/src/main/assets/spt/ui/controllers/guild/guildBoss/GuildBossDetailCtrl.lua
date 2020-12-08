local SelfDetailBattleModel = require("ui.models.guild.guildWar.SelfDetailBattleModel")
local BaseCtrl = require("ui.controllers.BaseCtrl")
local GuildBossDetailCtrl = class(BaseCtrl, "GuildBossDetailCtrl")

GuildBossDetailCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/SelfDetailBattle.prefab"

function GuildBossDetailCtrl:AheadRequest()
    local response = req.guildBossDetail()
    if api.success(response) then
        local data =response.val
        self.model = SelfDetailBattleModel.new()
        self.model:InitWithProtocal(data)
    end
end

function GuildBossDetailCtrl:Refresh()
    GuildBossDetailCtrl.super.Refresh(self)
    self.view:InitView(self.model)
end

return GuildBossDetailCtrl