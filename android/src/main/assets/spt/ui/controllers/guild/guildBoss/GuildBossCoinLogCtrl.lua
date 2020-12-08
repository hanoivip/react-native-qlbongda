local GuildBossCoinLogItemModel = require("ui.models.guild.guildBoss.GuildBossCoinLogItemModel")
local BaseCtrl = require("ui.controllers.BaseCtrl")
local GuildBossCoinLogCtrl = class(BaseCtrl, "GuildBossCoinLogCtrl")
GuildBossCoinLogCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/GuildBoss/GuildBossCoinLog.prefab"

function GuildBossCoinLogCtrl:AheadRequest()
    local response = req.guildBossWarBossCoinRecord()
    if api.success(response) then
        local data = response.val
        self.list = {}
        for k, v in pairs(data) do
            local itemModel = GuildBossCoinLogItemModel.new(v)
            table.insert(self.list, itemModel)
        end
    end
end

function GuildBossCoinLogCtrl:Refresh()
    GuildBossCoinLogCtrl.super.Refresh(self)
    self.view:InitView(self.list)
end

return GuildBossCoinLogCtrl
