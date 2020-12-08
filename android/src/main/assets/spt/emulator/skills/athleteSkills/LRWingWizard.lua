local Skill = import("../Skill")

local LRWingWizard = class(Skill, "LRWingWizard")
LRWingWizard.id = "LR_LUISFIGO2"
LRWingWizard.alias = "魔翼-菲戈"

local minSubConfig = 0.2
local maxSubConfig = 0.2
local minFullSubConfig = 0.04
local maxFullSubConfig = 0.04
local minProbabilityConfig = 1
local maxProbabilityConfig = 1

function LRWingWizard:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.subRatio = -Skill.lerpLevel(minSubConfig, maxSubConfig, level)
    self.subFullRatio = -Skill.lerpLevel(minFullSubConfig, maxFullSubConfig, level)

    self.debuff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return caster.team:isDefendRole()
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio
        end,
    }

    self.fullDebuff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return false
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subFullRatio
        end,
        persistent = true
    }

    self.debuffs = {self.debuff, self.fullDebuff}

end

return LRWingWizard