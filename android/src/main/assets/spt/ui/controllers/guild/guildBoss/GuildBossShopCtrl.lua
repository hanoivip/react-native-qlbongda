local BaseCtrl = require("ui.controllers.BaseCtrl")
local DialogManager = require("ui.control.manager.DialogManager")
local GuildBossShopCtrl = class(BaseCtrl, "GuildBossShopCtrl")

GuildBossShopCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/GuildBoss/GuildBossShop.prefab"

function GuildBossShopCtrl:Init()
    self.view.onBtnClick = function(data) self:OnBtnClick(data) end
    self.view.onBtnLog = function() self:OnBtnLog() end
end

function GuildBossShopCtrl:Refresh(model)
    self.model = model
    GuildBossShopCtrl.super.Refresh(self)
    self.view:InitView(self.model)
end

function GuildBossShopCtrl:OnBtnClick(shopItem)
    if shopItem.buy ~= 0 then
        return
    end
    if self.model:GetCoin() < shopItem.bossCoinPrice then
        DialogManager.ShowToast(lang.trans("guildBoss_coin_noEnough"))
        return
    end
    local func = function()
        clr.coroutine(function()
            local response = req.guildBossBuyBuff(shopItem.id, self.model:GetSeason())
            if api.success(response) then
                local data = response.val
                self.model:ResetData(data)
                self.view:Refresh(self.model)
                DialogManager.ShowToastByLang("guildBoss_buy_success")
                EventSystem.SendEvent("GuildBoss_buy_success")
            end
        end)
    end
    DialogManager.ShowConfirmPop(lang.trans("tips"), lang.trans("guildBoss_buy",tostring(shopItem.bossCoinPrice), shopItem.desc), func)
end

function GuildBossShopCtrl:OnBtnLog()
    res.PushDialog("ui.controllers.guild.guildBoss.GuildBossCoinLogCtrl")
end

function GuildBossShopCtrl:GetStatusData()
    return self.model
end

return GuildBossShopCtrl
