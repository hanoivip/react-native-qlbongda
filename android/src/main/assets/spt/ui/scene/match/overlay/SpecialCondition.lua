local UnityEngine = clr.UnityEngine
local Color = UnityEngine.Color
local MatchInfoModel = require("ui.models.MatchInfoModel")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local SpecialCondition = class(unity.base)

local FinishColor = Color(1, 1, 0.215)
local UnfinishedColor = Color(1, 1, 1)

function SpecialCondition:ctor()
    --------Start_Auto_Generate--------
    self.contentGo = self.___ex.contentGo
    self.content1Txt = self.___ex.content1Txt
    self.content2Txt = self.___ex.content2Txt
    --------End_Auto_Generate----------
end

function SpecialCondition:start()
    local matchInfoModel = MatchInfoModel.GetInstance()
    self:InitSpecialInfo(matchInfoModel)
    EventSystem.AddEvent("Match_UpdateQuestConditions", self, self.UpdateSpecialInfo)
end

function SpecialCondition:InitSpecialInfo(matchInfoModel)
    local hasSpecialCondition = matchInfoModel:hasQuestConditions()
    GameObjectHelper.FastSetActive(self.contentGo, hasSpecialCondition)
    if hasSpecialCondition then
        local questConditions = matchInfoModel:getQuestConditions()
        for i, v in ipairs(questConditions) do
            local txtName = "content" .. i .. "Txt"
            if self[txtName] then
                local count = v.count or 0
                local targetCount = v.targetCount
                local showInfo = v.showInfo or ""
                local desc = ""
                self[txtName].color = UnfinishedColor
                if v.type == 2 then
                    desc = showInfo .. "(0/1)"
                elseif v.type == 6 then
                    desc = showInfo .. "(1/1)"
                    self[txtName].color = FinishColor
                else
                    desc = showInfo .. "(" .. count .. "/" .. targetCount .. ")"
                end
                self[txtName].text = desc
            end
        end
    end
end

function SpecialCondition:UpdateSpecialInfo(questConditions)
    if questConditions then
        for i, v in ipairs(questConditions) do
            local txtName = "content" .. i .. "Txt"
            if self[txtName] then
                local count = v.count or 0
                if count < 0 then count = 0 end
                local targetCount = v.targetCount
                local result = v.result
                local showInfo = v.showInfo or ""
                local desc = ""
                self[txtName].text = desc
                if v.type == 2 or v.type == 6 then
                    if result then
                        desc = showInfo .. "(1/1)"
                    else
                        desc = showInfo .. "(0/1)"
                    end
                else
                    desc = showInfo .. "(" .. count .. "/" .. targetCount .. ")"
                end
                self[txtName].text = desc
                if result then
                    self[txtName].color = FinishColor
                else
                    self[txtName].color = UnfinishedColor
                end
            end
        end
    end
end

function SpecialCondition:onDestroy()
    EventSystem.RemoveEvent("Match_UpdateQuestConditions", self, self.UpdateSpecialInfo)
end

return SpecialCondition
