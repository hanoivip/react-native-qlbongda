local Model = require("ui.models.Model")
local EventSystem = require("EventSystem")

local FacebookModel = class(Model)

function FacebookModel:ctor()
    FacebookModel.super.ctor(self)
end

function FacebookModel:InitWithProtocol(data)
    if data then
        if data.list then
            self.pidList = {}
            self.cacheData = {}
            self.cacheData.searchList = {}
            for k, v in pairs(data.list) do
                local searchData = clone(v)
                searchData.pid = k
                table.insert(self.pidList, {sid = tostring(v.sid), pid = k})
                table.insert(self.cacheData.searchList, searchData)
            end
            table.sort(self.cacheData.searchList, function(a, b) return a.l_t < b.l_t end)
            self.friendPidList = self.pidList
        end
    end
end

function FacebookModel:GetSearchList()
    return self.cacheData.searchList
end

function FacebookModel:GetPidList()
    return self.friendPidList
end

function FacebookModel:GetFacebookData(id)
    return self.socialMap[id] or {}
end

function FacebookModel:GetSocialData()
    return self.socialMap
end

function FacebookModel:SetSocialData(socialData)
    socialData = socialData or {}
    local socialMap = {}
    local id
    for i = 1, #socialData do
        if i % 3 == 1 then 
            id = socialData[i]
            socialMap[id] = {}
        elseif i % 3 == 2 then
            socialMap[id].name = socialData[i]
        elseif i % 3 == 0 then
            socialMap[id].picture = socialData[i]
        end
    end
    self.socialMap = socialMap
end

function FacebookModel:UpdateSearchList(searchList)

end

return FacebookModel