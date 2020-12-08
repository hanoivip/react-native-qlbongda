local GuildBossSet = require("data.GuildBossSet")
local GuildBossReward = require("data.GuildBossReward")
local GuildBossRewardDesView = class(unity.base)

function GuildBossRewardDesView:ctor()
--------Start_Auto_Generate--------
    self.rewardItemsSpt = self.___ex.rewardItemsSpt
--------End_Auto_Generate----------
end

function GuildBossRewardDesView:start()
    self:InitRewards()
end

function GuildBossRewardDesView:InitRewards()
    if not GuildBossSet or not GuildBossReward then
        return
    end
    local rewardsData = {}
    for i, v in pairs(GuildBossSet) do
        local reward = GuildBossReward[tostring(v.defeatReward)].contents
        local name = lang.transstr("floor_order", v.ID)
        table.insert(rewardsData, {id = tonumber(v.ID), name = name, reward = reward})
    end
    table.sort(rewardsData, function(a, b) return a.id < b.id end)
    self.rewardItemsSpt:InitView(rewardsData)
end

return GuildBossRewardDesView
