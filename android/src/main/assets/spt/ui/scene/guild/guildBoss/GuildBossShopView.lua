local UnityEngine = clr.UnityEngine
local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local GuildBossShopView = class(unity.base, "GuildBossShopView")

function GuildBossShopView:ctor()
--------Start_Auto_Generate--------
    self.itemTrans = self.___ex.itemTrans
    self.coinTxt = self.___ex.coinTxt
    self.logBtn = self.___ex.logBtn
--------End_Auto_Generate----------
end

function GuildBossShopView:start()
    self.logBtn:regOnButtonClick(function ()
        self:OnBtnLog()
    end)
    self:PlayInAnimator()
end

function GuildBossShopView:InitView(guildBossShopModel)
    self.model = guildBossShopModel
    self:RefreshView()
end

function GuildBossShopView:RefreshView()
    self:RefreshCoin()
    if not self.sptList then
        self.sptList = {}
    end
    local itemList = self.model:GetItemList()
    for i, v in ipairs(itemList) do
        if not self.sptList[i] then
            local obj, spt = res.Instantiate("Assets/CapstonesRes/Game/UI/Scene/Guild/Prefab/GuildBoss/GuildBossShopItem.prefab")
            obj.transform:SetParent(self.itemTrans, false)
            self.sptList[i] = spt
        end
        local spt = self.sptList[i]
        spt:InitView(v)
        spt.onBtnClick = function(data) self:OnBtnClick(data) end
    end
end

function GuildBossShopView:Refresh(model)
    self.model = model
    self:RefreshCoin()
    self:RefreshBtn()
end

function GuildBossShopView:RefreshBtn()
    local itemList = self.model:GetItemList()
    for i, v in ipairs(itemList) do
        local spt = self.sptList[i]
        if spt then
            spt:RefreshBtn(v)
        end
    end
end

function GuildBossShopView:RefreshCoin()
    self.coinTxt.text = ' x' .. tostring(self.model:GetCoin())
end

function GuildBossShopView:OnBtnClick(data)
    if self.onBtnClick then
        self.onBtnClick(data)
    end
end

function GuildBossShopView:OnBtnLog()
    if self.onBtnLog then
        self.onBtnLog()
    end
end

function GuildBossShopView:PlayInAnimator()
    DialogAnimation.Appear(self.transform, self.canvasGroup)
end

function GuildBossShopView:PlayOutAnimator()
    DialogAnimation.Disappear(self.transform, self.canvasGroup, function() self:CloseView() end)
end

function GuildBossShopView:CloseView()
    if type(self.closeDialog) == 'function' then
        self.closeDialog()
    end
end

function GuildBossShopView:Close()
    self:PlayOutAnimator()
end

return GuildBossShopView
