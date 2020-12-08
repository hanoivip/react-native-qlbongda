local GuildBossDamageRankModel = require("ui.models.guild.guildBoss.GuildBossDamageRankModel")
local BaseCtrl = require("ui.controllers.BaseCtrl")
local GuildBossDamageRankCtrl = class(BaseCtrl, "GuildBossDamageRankCtrl")

GuildBossDamageRankCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/GuildBoss/GuildBossDamageRankBoard.prefab"


function GuildBossDamageRankCtrl:AheadRequest(bossId, season)
    local response = req.guildBossDamageRank(bossId, season)
    if api.success(response) then
        local data =response.val
        self.model = GuildBossDamageRankModel.new(gid)
        self.model:InitWithProtocal(data)
    end
end

function GuildBossDamageRankCtrl:Refresh(bossId, season)
    GuildBossDamageRankCtrl.super.Refresh(self)
    self.view:InitView(self.model)
end

return GuildBossDamageRankCtrl
