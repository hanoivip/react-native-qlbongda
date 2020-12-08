local PlayerTeamsModel = require("ui.models.PlayerTeamsModel")
local FormationConstants = require("ui.scene.formation.FormationConstants")

local GuildBossPlayerTeamsModel = class(PlayerTeamsModel, "GuildBossPlayerTeamsModel")

function GuildBossPlayerTeamsModel:ctor()
    GuildBossPlayerTeamsModel.super.ctor(self)
end

function GuildBossPlayerTeamsModel:InitWithProtocol(data)
    GuildBossPlayerTeamsModel.super.InitWithProtocol(self, data)
end

function GuildBossPlayerTeamsModel:Init(data)
    if data ~= nil then
        self.data = clone(data)
        self:SetNowTeamData(self:GetNowTeamId())
        self:SetSelectedType(self:GetSelectedType())
    end
end

function GuildBossPlayerTeamsModel:SaveData(data)
end

return GuildBossPlayerTeamsModel
