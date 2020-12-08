local Skill = import("../Skill")

local TheIcasillas = class(Skill, "TheIcasillas")
TheIcasillas.id = "LR_ICASILLAS2"
TheIcasillas.alias = "圣卡西"

local minProbabilityConfig = 0.15
local maxProbabilityConfig = 0.15
local minSubConfig = 0.2
local maxSubConfig = 0.2

function TheIcasillas:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.subRatio = -Skill.lerpLevel(minSubConfig, maxSubConfig, level)

    self.debuff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return false
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio
        end,
        persistent = true
    }
end

return TheIcasillas
