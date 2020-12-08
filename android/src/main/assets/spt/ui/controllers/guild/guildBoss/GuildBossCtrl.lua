local BaseCtrl = require("ui.controllers.BaseCtrl")
local GuildBossCtrl = class(BaseCtrl, "GuildBossCtrl")
local DialogManager = require("ui.control.manager.DialogManager")
local GuildBossPlayerTeamsModel = require("ui.models.guild.guildBoss.GuildBossPlayerTeamsModel")
local GuildBossModel = require("ui.models.guild.guildBoss.GuildBossModel")
local MatchInfoModel = require("ui.models.MatchInfoModel")
local MatchLoader = require("coregame.MatchLoader")
local FormationConstants = require("ui.scene.formation.FormationConstants")
local GuildBossMatchModel = require("ui.models.guild.guildBoss.GuildBossMatchModel")
GuildBossCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/GuildBoss/GuildBoss.prefab"

function GuildBossCtrl:ctor()
    GuildBossCtrl.super.ctor(self)
end

function GuildBossCtrl:Init()
    self.view.onStoreClick = function() res.PushDialog("ui.controllers.guild.guildBoss.GuildBossShopCtrl", self.model:GetShopModel()) end
    self.view.onTeamClick = function() res.PushScene("ui.controllers.guild.guildBoss.GuildBossFormationCtrl") end
    self.view.onFreshClick = function() self:OnFreshClick() end
    self.view.onChallengeClick = function(bossId) self:OnChallengeClick(bossId) end
    self.view.onChallengeDetailClick = function() self:OnChallengeDetailClick() end
    self.view.onRankClick = function() self:OnRankClick() end
    self.view.onDetailClick = function() self:OnDetailClick() end
end

function GuildBossCtrl:AheadRequest(authority, model)
    self.authority = authority
    self.bFightOver = false
    local response = req.guildBossInfo()
    if api.success(response) then
        local data = response.val
        if not model then
            self.model = GuildBossModel.new()
        else
            self.model = model
        end
        if not data.haveTeams then
            self:SetDefaultTeam()
        end
        self.model:InitWithProtocol(data, authority)
    else
        self.bFightOver = true
    end
end

function GuildBossCtrl:Refresh()
    if self.bFightOver then
        --回来时赛季结束了
        local guildBossMatchModel = GuildBossMatchModel.new()
        guildBossMatchModel:ClearMatch()
        res.PopScene()
        return
    end
    GuildBossCtrl.super.Refresh(self)
    self:ProcessPopDialog()
    self.view:InitView(self.model, true)
end

-- 处理比赛完回到界面事件
function GuildBossCtrl:ProcessPopDialog()
    local guildBossMatchModel = GuildBossMatchModel.new()
    local guildBossMatch = guildBossMatchModel:GetGuildBossMatch()
    if guildBossMatch then
        self.model:SetFightDamage(guildBossMatchModel:GetDamage())
        res.PushDialog("ui.controllers.guild.guildBoss.GuildBossMatchDialogCtrl", guildBossMatchModel)
    else
        guildBossMatchModel:ClearMatch()
    end
end

function GuildBossCtrl:OnFreshClick()
    clr.coroutine(function()
        self:AheadRequest(self.authority, self.model, true)
        self.view:InitView(self.model)
    end)
end

function GuildBossCtrl:OnEnterScene()
    self.model:SetFightDamage()
    self.view:OnEnterScene()
end

function GuildBossCtrl:OnExitScene()
    self.view:OnExitScene()
end

function GuildBossCtrl:OnChallengeClick(bossId)
    local curTimes = self.model:GetChallengeAmount()
    if curTimes <= 0 then
        DialogManager.ShowToastByLang("guildBoss_times_noEnough")
        return
    end
    clr.coroutine(
        function()
            local response = req.guildBossGetTeam()
            if api.success(response) then
                local data = response.val
                local playerTeamsModel = GuildBossPlayerTeamsModel.new()
                playerTeamsModel:InitWithProtocol(data)

                response = req.guildBossMatch(self.model:GetSeason(), bossId)
                if api.success(response) then
                    MatchInfoModel.GetInstance():SetMatchTeamData(playerTeamsModel.data)
                    MatchLoader.startMatch(response.val)
                end
            end
        end
    )
end

function GuildBossCtrl:SetDefaultTeam()
    local data = self.model:GetDefualtTeam()
    local keyPlayersData = {}
    keyPlayersData.freeKickShoot = data.freeKickShoot
    keyPlayersData.spotKick = data.spotKick
    keyPlayersData.captain = data.captain
    keyPlayersData.freeKickPass = data.freeKickPass
    keyPlayersData.corner = data.corner
    local resp = req.guildBossSaveTeam(data.ptid, data.formationID, data.init, data.rep, FormationConstants.TeamType.GUILDBOSS, keyPlayersData, data.tactics, data.selectedType, data.isDefaultFormation)
    if api.success(resp) then
        --
    end
end

function GuildBossCtrl:GetStatusData()
    return self.authority, self.model
end

function GuildBossCtrl:OnChallengeDetailClick()
    res.PushDialog("ui.controllers.guild.guildBoss.GuildBossDetailCtrl")
end

function GuildBossCtrl:OnRankClick()
    local layerModel = self.model:GetLayerModel(self.model:GetSelect())
    local isLock = layerModel:IsLock()
    if isLock then
        DialogManager.ShowToast(lang.trans("guildBoss_layer_not_open"))
        return
    end
    res.PushDialog("ui.controllers.guild.guildBoss.GuildBossDamageRankCtrl", self.model:GetSeason(), self.model:GetSelect())
end

function GuildBossCtrl:OnDetailClick()
    res.PushDialog("ui.controllers.guild.guildBoss.GuildBossIntroduceCtrl")
end

return GuildBossCtrl
