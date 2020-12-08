local Model = require("ui.models.Model")
local GuildAuthority = require("data.GuildAuthority")
local GuildBossShopModel = class(Model, "GuildBossShopModel")

function GuildBossShopModel:ctor()
    GuildBossShopModel.super.ctor(self)
end

function GuildBossShopModel:InitWithProtocol(data, season, authority)
    self.season = season
    self.authority = authority
    self:ResetData(data)
end

function GuildBossShopModel:ResetData(data)
    self.data = data
    local list = {}
    local isCanBuy = self:IsCanBuy()
    for k, v in pairs(data.shopList) do
        local item = v
        item.id = k
        item.isCanBuy = isCanBuy
        table.insert(list, item)
    end
    
    table.sort(list, function(a,b)
        return a.order < b.order
    end)
    self.data.shopList = list
end

function GuildBossShopModel:GetCoin()
    return self.data.bossCoin
end

function GuildBossShopModel:IsCanBuy()
    local config = GuildAuthority[tostring(self.authority)]
    local bossWarBuyBuff = config.bossWarBuyBuff
    return config.bossWarBuyBuff ~= 0
end

function GuildBossShopModel:GetUpBuff(layer)
    local value = 0
    for k, v in pairs(self.data.shopList) do
        if v.buy ~= 0 and v.effectType == 1 then
            value = value + v.effect
        end
    end
    return value
end

function GuildBossShopModel:GetDownBuff(layer)
    local value = 0
    for k, v in pairs(self.data.shopList) do
        if v.buy ~= 0 and v.effectType == 2 and v.effectBossID == layer then
            value = value + v.effect
        end
    end
    return value
end

function GuildBossShopModel:GetSeason()
    return self.season
end

function GuildBossShopModel:GetItemList()
    return self.data.shopList
end

return GuildBossShopModel
