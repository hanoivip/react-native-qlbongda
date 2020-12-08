local Skill = import("../Skill")

local LRAnestaSecond = class(Skill, "LRAnestaSecond")
LRAnestaSecond.id = "LR_ANESTA2"
LRAnestaSecond.alias = "优雅后卫"

local cooldownConfig = 0
local minAddConfig = 0.15
local maxAddConfig = 0.15
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
LRAnestaSecond.durationConfig = 30

function LRAnestaSecond:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.subRatio = -Skill.lerpLevel(minAddConfig, maxAddConfig, level)

    self.debuff = {
        skill = self,
        remark = "resetTime",
        duration = self.durationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return math.cmpf(remainingTime, 0) <= 0
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio
        end
    }
end

return LRAnestaSecond