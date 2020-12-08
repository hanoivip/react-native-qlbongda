local Skill = import("../Skill")

local LRDeterrentForce = class(Skill, "LRDeterrentForce")
LRDeterrentForce.id = "LR_VVANDIJK2"
LRDeterrentForce.alias = "威慑力"

-- 触发概率
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
-- 短期减属性配置
local minSubConfig = 0.2
local maxSubConfig = 0.2
-- 持续时间配置
local durationConfig = 50

function LRDeterrentForce:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.cooldown = cooldownConfig
    self.remainingCooldown = 0

    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.subRatio = -Skill.lerpLevel(minSubConfig, maxSubConfig, level)

    self.debuff = {
        skill = self,
        duration = durationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return math.cmpf(remainingTime, 0) <= 0
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio
        end,
    }
end

return LRDeterrentForce
