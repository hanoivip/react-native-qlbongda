local Skill = import("../Skill")

local LRKakaSecond = class(Skill, "LRKakaSecond")
LRKakaSecond.id = "LR_KAKA2"
LRKakaSecond.alias = "天之骄子"

local cooldownConfig = 0
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
local durationConfig = 6

function LRKakaSecond:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)

    self.buff = {
        skill = self,
        remark = "blockInfluence",
        duration = durationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return math.cmpf(remainingTime, 0) <= 0
        end,
    }
end

return LRKakaSecond