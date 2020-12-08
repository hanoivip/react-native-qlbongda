local PlayerInfoModel = require("ui.models.PlayerInfoModel")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local TeamLogoCtrl = require("ui.controllers.common.TeamLogoCtrl")
local PlayerDetailCtrl = require("ui.controllers.playerDetail.PlayerDetailCtrl")

local GuildBossRankItemBarView = class(unity.base, "GuildBossRankItemBarView")

function GuildBossRankItemBarView:ctor()
--------Start_Auto_Generate--------
    self.normalGo = self.___ex.normalGo
    self.highLightGo = self.___ex.highLightGo
    self.firstRankGo = self.___ex.firstRankGo
    self.secondRankGo = self.___ex.secondRankGo
    self.thirdRankGo = self.___ex.thirdRankGo
    self.normalRankTxt = self.___ex.normalRankTxt
    self.logoImg = self.___ex.logoImg
    self.teamNameTxt = self.___ex.teamNameTxt
    self.viewButtonBtn = self.___ex.viewButtonBtn
    self.damageTxt = self.___ex.damageTxt
    self.coinTxt = self.___ex.coinTxt
--------End_Auto_Generate----------
    self.playerInfoModel = PlayerInfoModel.new()
    self.playerInfoModel:Init()
end

function GuildBossRankItemBarView:start()
    self.viewButtonBtn:regOnButtonClick(function ()
        self:OnViewDetail()
    end)
end

function GuildBossRankItemBarView:InitView(rankData, index)
    self.pid = rankData._id
    self.sid = rankData.sid
    self.teamNameTxt.text = rankData.name
    self.damageTxt.text = tostring(rankData.damage)
    self.coinTxt.text = tostring(rankData.bossCoin)
    self.normalRankTxt.text = lang.trans("ladder_rank", tostring(rankData.rank))
    self:InitTeamLogo(self.logoImg, rankData.logo)
    self:InitRankShowState(rankData.rank)
    self:InitBackGround(rankData._id, rankData.rank)
end

function GuildBossRankItemBarView:InitTeamLogo(teamLogo, logoTable)
    TeamLogoCtrl.BuildTeamLogo(teamLogo, logoTable)
end

function GuildBossRankItemBarView:OnViewDetail()
    PlayerDetailCtrl.ShowPlayerDetailView(function() return req.friendsDetail(self.pid, self.sid) end, self.pid, self.sid)
end

function GuildBossRankItemBarView:InitRankShowState(rank)
    GameObjectHelper.FastSetActive(self.firstRankGo, rank == 1)
    GameObjectHelper.FastSetActive(self.secondRankGo, rank == 2)
    GameObjectHelper.FastSetActive(self.thirdRankGo, rank == 3)
    GameObjectHelper.FastSetActive(self.normalRankTxt.gameObject, rank >= 4)
end

function GuildBossRankItemBarView:InitBackGround(id, rank)
    if self.playerInfoModel:GetID() == id then
         GameObjectHelper.FastSetActive(self.normalGo, false)
         GameObjectHelper.FastSetActive(self.highLightGo, true)
    else
         GameObjectHelper.FastSetActive(self.normalGo, rank % 2 == 0)
         GameObjectHelper.FastSetActive(self.highLightGo, false)
    end
end

return GuildBossRankItemBarView
