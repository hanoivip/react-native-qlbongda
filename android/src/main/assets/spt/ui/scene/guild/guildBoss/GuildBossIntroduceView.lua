local Introduce = require("data.Introduce")
local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local GuildBossIntroduceView = class(unity.base)

local tabs = {}
tabs.playingDes = "playing"
tabs.rewardDes = "reward"

function GuildBossIntroduceView:ctor()
--------Start_Auto_Generate--------
    self.buttonGroupSpt = self.___ex.buttonGroupSpt
    self.playingDescGo = self.___ex.playingDescGo
    self.playingDesTxt = self.___ex.playingDesTxt
    self.rewardDescGo = self.___ex.rewardDescGo
    self.closeBtn = self.___ex.closeBtn
--------End_Auto_Generate----------
end

function GuildBossIntroduceView:start()
    DialogAnimation.Appear(self.transform, self.canvasGroup)
    self.closeBtn:regOnButtonClick(function()
        self:Close()
    end)
    self:InitView()
    self.buttonGroupSpt:selectMenuItem(tabs.playingDes)
    self:OnTabClick(tabs.playingDes)
end

function GuildBossIntroduceView:InitView()
    self:InitPlayingDes()
    for i, v in pairs(self.buttonGroupSpt.menu) do
        self.buttonGroupSpt:BindMenuItem(i, function()
            self:OnTabClick(i)
        end)
    end
end

function GuildBossIntroduceView:InitPlayingDes()
    if self.clickPlayingDes then return end
    local introduceStr = (Introduce["25"] and Introduce["25"].introduce) or ""
    self.playingDesTxt.text = introduceStr
end

function GuildBossIntroduceView:OnTabClick(tag)
    local isPlayingDes = tag == tabs.playingDes
    local isRewardDes = tag == tabs.rewardDes
    if not self.clickPlayingDes and isPlayingDes then
        self.clickPlayingDes = true
    end
    if not self.clickRewardDes and isRewardDes then
        self.clickRewardDes = true
    end
    GameObjectHelper.FastSetActive(self.playingDescGo, isPlayingDes)
    GameObjectHelper.FastSetActive(self.rewardDescGo, isRewardDes)
end

function GuildBossIntroduceView:Close()
    DialogAnimation.Disappear(self.transform, self.canvasGroup, function()
        if type(self.closeDialog) == "function" then
            self.closeDialog()
        end
    end)
end

return GuildBossIntroduceView
