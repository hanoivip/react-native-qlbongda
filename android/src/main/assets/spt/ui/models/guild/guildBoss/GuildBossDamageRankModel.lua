local PlayerInfoModel = require("ui.models.PlayerInfoModel")
local Model = require("ui.models.Model")
local GuildBossDamageRankModel = class(Model)

function GuildBossDamageRankModel:ctor()
    GuildBossDamageRankModel.super.ctor(self)
    self.cacheData = {}
end

function GuildBossDamageRankModel:InitWithProtocal(data)
    if not data then return end
    assert(data)
    if type(data) == "table" then
        local id = PlayerInfoModel.new():GetID()
        for k, v in pairs(data) do
            table.insert(self.cacheData, v)
            if v._id == tostring(id) then
                self.selfData = v
            end
        end
        self:ResetData()
    end
end

function GuildBossDamageRankModel:ResetData()
    table.sort(self.cacheData, function (a, b)
            return tonumber(a.rank) < tonumber(b.rank)
    end)
end

function GuildBossDamageRankModel:GetDatas()
    return self.cacheData
end

function GuildBossDamageRankModel:GetSelfData()
    return self.selfData
end

return GuildBossDamageRankModel