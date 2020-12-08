local Skill = import("../Skill")

local LRThenrySecond = class(Skill, "LRThenrySecond")
LRThenrySecond.id = "LR_THENRY2"
LRThenrySecond.alias = "大帝"

local cooldownConfig = 0
local minAddConfig = 0.05
local maxAddConfig = 0.05
local minProbabilityConfig = 1
local maxProbabilityConfig = 1

function LRThenrySecond:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)

    self.buff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return false
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.addRatio
        end,
        persistent = true
    }
end

return LRThenrySecond