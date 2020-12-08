local TeamInvestType = require("ui.models.activity.teamInvest.TeamInvestType")
local ActivityModel = require("ui.models.activity.ActivityModel")
local TeamInvestModel = class(ActivityModel)

local SafeTime = 50  -- 网络请求的最大时间（防止还在倒计时时，服务器活动已经结束）

function TeamInvestModel:ctor(data)
    TeamInvestModel.super.ctor(self, data)
    self.singleData = self:GetActivitySingleData()
end

function TeamInvestModel:InitWithProtocol()
    self.singleData = self:GetActivitySingleData()
end

function TeamInvestModel:GetPeriod()
    return self.singleData.ID
end

function TeamInvestModel:GetNowSlotLevel()
    if self.singleData.p_data then
        return self.singleData.p_data.value + 1
    else
        return 1
    end
end

function TeamInvestModel:GetDiamondNeed()
    local lvl = self:GetNowSlotLevel()
    local lData = self.singleData.list[lvl]
    if not lData then
        return self:GetRecordDiamond()
    else
        return lData.dNeed
    end

end

function TeamInvestModel:GetEndTime()
    local endTime = self.singleData.endTime
    return string.formatTimestampNoYear(endTime)
end

function TeamInvestModel:GetStartTime()
    local beginTime = self.singleData.beginTime
    return string.formatTimestampNoYear(beginTime)
end

function TeamInvestModel:GetNeedVIPLevel()
    local slotLevel = self:GetNowSlotLevel()
    return self.singleData.list[slotLevel] and self.singleData.list[slotLevel].vip
end

function TeamInvestModel:GetMaxDiamond()
    local slotLevel = self:GetNowSlotLevel()
    return self.singleData.list[slotLevel] and self.singleData.list[slotLevel].dDisplay
end

function TeamInvestModel:GetConsumeDiamond()
    local slotLevel = self:GetNowSlotLevel()
    return self.singleData.list[slotLevel] and self.singleData.list[slotLevel].dNeed
end

function TeamInvestModel:GetMaxVIPLevel()
    local maxValue = #self.singleData.list
    return self.singleData.list[maxValue].vip or 0
end

function TeamInvestModel:GetDesc()
    local slotLevel = self:GetNowSlotLevel()
    if not self.singleData.list[slotLevel] then
        slotLevel = #self.singleData.list
    end
    return self.singleData.list[slotLevel].desc
end

function TeamInvestModel:IsSlotFull()
    local slotLevel = self:GetNowSlotLevel()
    local maxValue = #self.singleData.list
    return slotLevel > maxValue
end

function TeamInvestModel:RefreshRedeemData(data)
    self.singleData.p_data = data.pdata
    self.singleData.currentDiamond = data.currentDiamond
end

function TeamInvestModel:ChangeInt2Str(intNumber)
    local dStr = tostring(intNumber)
    local le = string.len(dStr)
    for i = 1, 5 - le do
       dStr = 0 .. dStr
    end
    return dStr
end

function TeamInvestModel:GetTeamInvestType()
    return TeamInvestType.TIME_LIMIT
end

-- 所有的奖励抽完只有 显示上一次抽到的奖励
function TeamInvestModel:GetRecordDiamond()
    return self.singleData.p_data.dRecord
end

-- 获取活动剩余时间
function TeamInvestModel:GetRemainTime()
    local endTime = tonumber(self.singleData.endTime)
    local serverDeltaTime = cache.getServerDeltaTimeValue() or 0
    local osTime = os.time() + serverDeltaTime
    local remainTime = endTime - osTime - SafeTime
    if remainTime > 0 then
        return remainTime
    else
        return 0
    end
end

function TeamInvestModel:GetBoardType()
    return self.singleData.boardType or 1
end

return TeamInvestModel
