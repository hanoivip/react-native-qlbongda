local Skill = import("../Skill")

local LRPharaoh = class(Skill, "LRPharaoh")
LRPharaoh.id = "LR_MSALAH2"
LRPharaoh.alias = "法老王"

-- 触发概率
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
-- 增加全属性配置
local minAddAbilityConfig = 0.2
local maxAddAbilityConfig = 0.2
-- 短期减属性配置
local minSubConfig = 0.2
local maxSubConfig = 0.2
-- 持续时间配置
local durationConfig = 40

function LRPharaoh:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.cooldown = cooldownConfig
    self.remainingCooldown = 0

    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.abilityAddConfig = Skill.lerpLevel(minAddAbilityConfig, maxAddAbilityConfig, level)
    self.subRatio = -Skill.lerpLevel(minSubConfig, maxSubConfig, level)

    self.buff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return not receiver:hasBall()
        end,
        abilitiesModifier = function(abilities, caster, receiver)
            abilities.shoot = abilities.shoot + caster:getAbilitiesSum() * self.abilityAddConfig
        end
    }

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

return LRPharaoh
