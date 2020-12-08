local Model = require("ui.models.Model")
local FriendsBlockModel = class(Model)

function FriendsBlockModel:ctor()
    FriendsBlockModel.super.ctor(self)
end

function FriendsBlockModel:InitWithProtocol(data)
    if not data then return end
    self.cacheData = {}
    self.cacheData.blockList = {}
    if data.blockList then
        for k, v in pairs(data.blockList) do
            local friendData = clone(v)
            friendData.pid = k
            table.insert(self.cacheData.blockList, friendData)
        end
        table.sort(self.cacheData.blockList, function(a, b) return a.blockTime > b.blockTime end)
    end
    self.cacheData.blocksNumber = #(self.cacheData.blockList)
    self.cacheData.blockLimit = data.blockLimit
end

-- 解除对玩家pid的屏蔽
function FriendsBlockModel:RemoveFriendsBlockByPid(pid)
    local removeIndex = nil
    for i = #self.cacheData.blockList, 1, -1 do
        if self.cacheData.blockList[i].pid == pid then
            removeIndex = i
            table.remove(self.cacheData.blockList, i)
            break
        end
    end
    self.cacheData.blocksNumber = #(self.cacheData.blockList)
    EventSystem.SendEvent("FriendsBlock_UpdateView")
end

-- 获取屏蔽列表
function FriendsBlockModel:GetBlockList()
    return self.cacheData.blockList
end

-- 获取屏蔽数量
function FriendsBlockModel:GetBlockNum()
    return self.cacheData.blocksNumber
end

-- 获取屏蔽数量上限
function FriendsBlockModel:GetBlockNumLimit()
    return self.cacheData.blockLimit or 0
end

return FriendsBlockModel