local Skill = import("../Skill")

local LRConfuseMaster = class(Skill, "LRConfuseMaster")
LRConfuseMaster.id = "LR_DECO2"
LRConfuseMaster.alias = "迷惑大师"

-- 触发概率
local minProbabilityConfig = 0.5
local maxProbabilityConfig = 0.5
-- 减属性配置
local minAddRatioConfig = 0.4
local maxAddRatioConfig = 0.4

function LRConfuseMaster:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.cooldown = cooldownConfig
    self.remainingCooldown = 0

    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.subRatio = -Skill.lerpLevel(minAddRatioConfig, maxAddRatioConfig, level)

    self.debuff = {
        skill = self,
        remark = "mark",
        duration = goalDurationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return caster.team:isDefendRole()
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio
        end
    }
end

return LRConfuseMaster
