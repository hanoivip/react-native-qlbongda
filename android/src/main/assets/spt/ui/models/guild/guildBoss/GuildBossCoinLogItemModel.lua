local Model = require("ui.models.Model")
local GuildBossCoinLogItemModel = class(Model, "GuildBossCoinLogItemModel")

function GuildBossCoinLogItemModel:ctor(data)
    self.data = data
end

function GuildBossCoinLogItemModel:GetContent()
    local operatePerformer = self.data.content.operatePerformer or ""
    local bossId = self.data.content.key1
    local bossCoin = self.data.content.key2
    local str = lang.transstr("guildBoss_coin_log_txt", operatePerformer, bossId, bossCoin)
    return str
end

function GuildBossCoinLogItemModel:GetTime()
    local time = self.data.c_t
    local timeStr = string.convertSecondToMonth(time)
    return timeStr
end

return GuildBossCoinLogItemModel