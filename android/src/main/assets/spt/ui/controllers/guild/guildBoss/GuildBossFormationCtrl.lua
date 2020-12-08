local GuildBossPlayerTeamsModel = require("ui.models.guild.guildBoss.GuildBossPlayerTeamsModel")
local FormationConstants = require("ui.scene.formation.FormationConstants")
local FormationPageCtrl = require("ui.controllers.formation.FormationPageCtrl")
local GuildBossFormationCacheDataModel = require "ui.models.guild.guildBoss.GuildBossFormationCacheDataModel"
local GuildBossFormationCtrl = class(FormationPageCtrl, "GuildBossFormationCtrl")
GuildBossFormationCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/GuildBoss/GuildBossFormationPage.prefab"

function GuildBossFormationCtrl:Init()
    self:InitView()
end

function GuildBossFormationCtrl:AheadRequest()
    local response = req.guildBossGetTeam()
    if api.success(response) then
        local data = response.val
        self.playerTeamsModel = GuildBossPlayerTeamsModel.new()
        self.playerTeamsModel:InitWithProtocol(data)
        self.playerTeamsModel:SetTeamType(FormationConstants.TeamType.GUILDBOSS)
        self.formationCacheDataModel = GuildBossFormationCacheDataModel.new(self.playerTeamsModel)
    end
end

function GuildBossFormationCtrl:Refresh(playerTeamsModel, formationCacheDataModel)
    if playerTeamsModel then
        self.playerTeamsModel = playerTeamsModel
    end

    if formationCacheDataModel then
        self.formationCacheDataModel = formationCacheDataModel
    end
    GuildBossFormationCtrl.super.Refresh(self)
    local isPush = nil
    local loadType = self:GetLoadType()
    if loadType == res.LoadType.Pop then
        isPush = false
    else
        isPush = true
    end
    self.view:InitView(self.playerTeamsModel, self.formationCacheDataModel)
    self.view:RefreshPage(isPush, self.playerTeamsModel, self.formationCacheDataModel)
end

return GuildBossFormationCtrl
