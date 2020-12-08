local Skill = import("../Skill")

local LRButcherInMidfield = class(Skill, "LRButcherInMidfield")
LRButcherInMidfield.id = "LR_PEPE2"
LRButcherInMidfield.alias = "中场屠夫"

-- 触发概率
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
-- 持续全场减全属性配置
local minSubConfig1 = 0.15
local maxSubConfig1 = 0.15
-- 短期减属性配置
local minSubConfig2 = 0.3
local maxSubConfig2 = 0.3
-- 持续时间配置
local durationConfig = 30

function LRButcherInMidfield:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.cooldown = cooldownConfig
    self.remainingCooldown = 0

    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.subRatio1 = -Skill.lerpLevel(minSubConfig1, maxSubConfig1, level)
    self.subRatio2 = -Skill.lerpLevel(minSubConfig2, maxSubConfig2, level)

    self.debuff1 = {
        skill = self,
        remark = "fullCount",
        removalCondition = function(remainingTime, caster, receiver)
            return false
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio1
        end,
        persistent = true
    }

    self.debuff2 = {
        skill = self,
        remark = "duration",
        duration = durationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return math.cmpf(remainingTime, 0) <= 0
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio2
        end
    }
end

return LRButcherInMidfield
