local UnityEngine = clr.UnityEngine
local Color = UnityEngine.Color
local GameObjectHelper = require("ui.common.GameObjectHelper")
local AssetFinder = require("ui.common.AssetFinder")
local GuildBossShopItem = class(unity.base, "GuildBossShopItem")

function GuildBossShopItem:ctor()
    --------Start_Auto_Generate--------
    self.bgImg = self.___ex.bgImg
    self.layerGo = self.___ex.layerGo
    self.layerTxt = self.___ex.layerTxt
    self.nameTxt = self.___ex.nameTxt
    self.iconImg = self.___ex.iconImg
    self.attrTxt = self.___ex.attrTxt
    self.descTxt = self.___ex.descTxt
    self.buyBtn = self.___ex.buyBtn
    self.canBuyGo = self.___ex.canBuyGo
    self.costTxt = self.___ex.costTxt
    self.disableCostTxt = self.___ex.disableCostTxt
    self.notCanBuyGo = self.___ex.notCanBuyGo
--------End_Auto_Generate----------
    self.btnBuy = self.___ex.btnBuy
    self.attrTxtColor = self.___ex.attrTxtColor
    self.shadowColor = self.___ex.shadowColor
end

function GuildBossShopItem:start()
    self.buyBtn:regOnButtonClick(function()
        self:OnBtnClick()
    end)
end

function GuildBossShopItem:InitView(data)
    self.data = data
    self:RefreshView()
end


local s_color = {
    [1] = {
            { percent = 0, color = Color(226/255, 255/255, 99/255, 1) } ,
            { percent = 1, color = Color(171/255, 255/255, 74/255, 1) } ,
          },
    [2] = { 
            { percent = 0, color = Color(255/255, 235/255, 255/255, 1) } ,
            { percent = 1, color = Color(255/255, 61/255, 111/255, 1) } ,
          },
}

function GuildBossShopItem:RefreshView()
    local bUp = self.data.effectType == 1
    self.bgImg.overrideSprite = AssetFinder.GetGuildBossIcon("Store/" .. (bUp and "Bg1" or "Bg2"))
    self.iconImg.overrideSprite = AssetFinder.GetGuildBossIcon("Store/" .. (bUp and "BUFF01" or "BUFF02"))
    self.nameTxt.text = self.data.desc
    self.descTxt.text = lang.trans(bUp and "guildBoss_shop_upBuff" or "guildBoss_shop_downBuff")
    self.costTxt.text = 'x' .. self.data.bossCoinPrice
    self.disableCostTxt.text = 'x' .. self.data.bossCoinPrice
    self.layerTxt.text = tostring(self.data.effectBossID)
    self.attrTxt.text = (self.data.effect/10) .. "<size=18>%</size>"
    local color = bUp and s_color[1] or s_color[2]
    self.attrTxtColor:ResetPointColors(2)
    for i, v in ipairs(color) do
        self.attrTxtColor:AddPointColors(v.percent, v.color)
    end
    self.shadowColor.effectColor = bUp and Color(19/255, 98/255, 63/255, 1) or Color(148/255, 20/255, 26/255, 1)
    GameObjectHelper.FastSetActive(self.layerGo, self.data.effectBossID ~= 0)
    GameObjectHelper.FastSetActive(self.canBuyGo, self.data.isCanBuy)
    GameObjectHelper.FastSetActive(self.costTxt.gameObject, self.data.buy == 0)
    GameObjectHelper.FastSetActive(self.disableCostTxt.gameObject, self.data.buy ~= 0)
    GameObjectHelper.FastSetActive(self.notCanBuyGo, not self.data.isCanBuy)
    self:RefreshBtn()
end

function GuildBossShopItem:RefreshBtn(data)
    if data then
        self.data = data
    end
    self.btnBuy.interactable = self.data.buy == 0 and self.data.isCanBuy
end

function GuildBossShopItem:OnBtnClick()
    if self.data.buy ~= 0 then
        return
    end
    if not self.data.isCanBuy then
        return
    end
    if self.onBtnClick then
        self.onBtnClick(self.data)
    end
end

return GuildBossShopItem
