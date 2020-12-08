local UnityEngine = clr.UnityEngine
local GameObjectHelper = require("ui.common.GameObjectHelper")
local AssetFinder = require("ui.common.AssetFinder")
local GuildBossItem = class(unity.base, "GuildBossItem")
local Color = UnityEngine.Color

function GuildBossItem:ctor()
    self.flagImg = self.___ex.flagImg
    self.layerTxt = self.___ex.layerTxt
    self.nameTxt = self.___ex.nameTxt
    self.slider = self.___ex.slider
    self.selectGo = self.___ex.selectGo
    self.btnGo = self.___ex.btnGo
    self.transitGo = self.___ex.transitGo
    self.lockGo = self.___ex.lockGo
    self.arrowGo = self.___ex.arrowGo
    self.killTxt = self.___ex.killTxt
    self.selectBtn = self.___ex.selectBtn
    self.flagAni = self.___ex.flagAni
    self.arrowAni = self.___ex.arrowAni
    self.flagEffectGo = self.___ex.flagEffectGo
    self.particleGo = self.___ex.particleGo
end

function GuildBossItem:start()
    self.selectBtn:regOnButtonClick(function ()
        self:OnClick()
    end)
end

function GuildBossItem:InitView(data)
    self.data = data
    self:RefreshView()
end

function GuildBossItem:RefreshView()
    local isTransit = self.data.isTransit
    GameObjectHelper.FastSetActive(self.btnGo, not isTransit)
    GameObjectHelper.FastSetActive(self.transitGo, isTransit)
    if isTransit then
        self:ShowTransit()
        return
    end
    self:ShowLayerInfo()
end

function GuildBossItem:ShowTransit()
    local isLock = self.data.isLockNext
    self.arrowAni.enabled = false
    GameObjectHelper.FastSetActive(self.particleGo, false)
    if not self.lockGoImg then
        self.lockGoImg = self.lockGo:GetComponent("Image")
        self.arrowGoImg = self.arrowGo:GetComponent("Image")
    end
    local color = Color(1,1,1,1)
    self.lockGoImg.color = color
    self.arrowGoImg.color = color
    GameObjectHelper.FastSetActive(self.lockGo, isLock)
    GameObjectHelper.FastSetActive(self.arrowGo, not isLock)
end

function GuildBossItem:ShowLayerInfo()
    self.flagImg.overrideSprite = AssetFinder.GetGuildBossIcon("Group/" .. self.data.model:GetFlagIcon())
    self.layerTxt.text = tostring(self.data.model:GetId())
    self.nameTxt.text = self.data.model:GetName()
    local value = self.data.model:GetSliderValue()
    self.slider.value = value
    GameObjectHelper.FastSetActive(self.slider.gameObject, value > 0 and not self.data.model:IsLock())
    if value == 0 then
        self.killTxt.text = "<color=#8e97a3>" .. lang.transstr("guildBoss_have_kill") .. "</color>"
    elseif self.data.model:IsLock() then
        self.killTxt.text = "<color=#8e97a3>" .. lang.transstr("guildBoss_no_tip") .. "</color>"
    else
        self.killTxt.text = ""
    end
    if self.data.model:IsFightOver() and self.data.model:IsSelected() then
        self:ShowFlagLoopEffect()
    else
        if self.data.model:isFight() then
            self:ShowFlagLoopEffect()
        else
            self:CloseFlagEffect()
        end
    end
    self:ShowSelect()
end

function GuildBossItem:ShowSelect()
    local bSelect = self.data.model:IsSelected()
    GameObjectHelper.FastSetActive(self.selectGo, bSelect)
end

function GuildBossItem:ShowArrowEffect(layer)
    if self.data.isTransit then
        if self.data.model:GetId() ~= layer then
            return
        end
        self.arrowAni.enabled = true
        GameObjectHelper.FastSetActive(self.particleGo, true)
        GameObjectHelper.FastSetActive(self.arrowGo, true)
    end
end

function GuildBossItem:ShowFlagEffect(layer)
    if not self.data.isTransit then
        if self.data.model:GetId() ~= layer then
            return
        end
        GameObjectHelper.FastSetActive(self.flagEffectGo, true)
        self.flagAni.enabled = true
        self.flagAni:Play("BtnGo")
    end
end

function GuildBossItem:ShowFlagLoopEffect(layer)
    if layer and self.data.model:GetId() ~= layer then
        return
    end
    GameObjectHelper.FastSetActive(self.flagEffectGo, true)
    self.flagAni.enabled = true
    self.flagAni:Play('BtnGoLoop')
end

function GuildBossItem:CloseFlagEffect()
    self.flagAni.enabled = false
    GameObjectHelper.FastSetActive(self.flagEffectGo, false)
end

function GuildBossItem:OnClick()
    if self.data.model:IsSelected() then
        return
    end
    EventSystem.SendEvent("GuildBossItem.OnClick", self.data.model:GetId())
end

return GuildBossItem
