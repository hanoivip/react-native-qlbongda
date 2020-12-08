local DialogManager = require("ui.control.manager.DialogManager")
local ManyFormationPageView = require("ui.scene.formation.ManyFormationPageView")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local GuildBossFormationPageView = class(ManyFormationPageView, "GuildBossFormationPageView")

function GuildBossFormationPageView:SaveTeamData(onComplete)
    local replacePlayersData = {}
    for pos, pcId in pairs(self.replacePlayersData) do
        if tonumber(pcId) ~= 0 then
            replacePlayersData[pos] = pcId
        end
    end

    self:coroutine(function()
        if self.formationCacheDataModel:CheckInitPlayersChangedWithKeyPlayers(self.initPlayersData) then
            self.formationCacheDataModel:SetInitPlayersCacheDataWithKeyPlayers(self.initPlayersData)
            self.formationCacheDataModel:SetKeyPlayersDefaultData()
        end
        local keyPlayersData = self.formationCacheDataModel:GetKeyPlayersCacheData()
        keyPlayersData = self.playerTeamsModel:FixKeyPlayersData(keyPlayersData, self.initPlayersData)
        local tacticsData = self.formationCacheDataModel:GetTacticsCacheData()
        local teamType = self.playerTeamsModel:GetTeamType()
        local flag = self.formationCacheDataModel.currTeamIdChanged
        local resp = req.guildBossSaveTeam(self.nowTeamId, self.nowFormationId, self.initPlayersData, replacePlayersData, teamType, keyPlayersData, tacticsData, self.selectedType, flag)
        if api.success(resp) then
            self:UpdateTeamData(resp.val)
            if type(onComplete) == "function" then
                onComplete()
            end
        end
    end)
end

function GuildBossFormationPageView:ClearCourtPlayers()
    self:coroutine(
        function()
            local teamType = self.formationCacheDataModel:GetTeamType()
            local resp = req.guildBossTeamClear(self.nowTeamId, teamType)
            if api.success(resp) then
                self.initPlayersData = self.playerTeamsModel:GetClearCurrentTeamStartersData(self.nowTeamId)
                self.replacePlayersData = self.playerTeamsModel:GetClearBenchData()
                self.formationCacheDataModel:SetInitPlayerCacheData(self.initPlayersData)
                self.formationCacheDataModel:SetReplacePlayerCacheData(self.replacePlayersData)
                self.formationCacheDataModel:SetTacticsCacheData({})
                self.waitPlayersNoRepeatList, self.waitPlayersRepeatList = self.formationCacheDataModel:GetWaitPlayerCacheData(self.nowSortType)
                self:InitCandidateScrollerView()
                self:BuildPage()
                self.candidateScrollerView:BuildPage()

                self.formationCacheDataModel:SetInitPlayersCacheDataWithKeyPlayers(self.initPlayersData)
                self.formationCacheDataModel:SetKeyPlayersDefaultData()
                self:UpdateTeamData(resp.val)
                self:FormationDataChange(false)
                DialogManager.ShowToastByLang("clear_formation_success")
            end
        end
    )
end

function GuildBossFormationPageView:RefreshMySceneInfo()
end

return GuildBossFormationPageView