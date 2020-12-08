local Skill = import("../Skill")

local SpiritualEncouragement = class(Skill, "SpiritualEncouragement")
SpiritualEncouragement.id = "LR_MSALGADO2"
SpiritualEncouragement.alias = "精神激励"

local minProbabilityConfig = 0.2
local maxProbabilityConfig = 0.2
local minAddConfig = 0.15
local maxAddConfig = 0.15

function SpiritualEncouragement:ctor(level)
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

return SpiritualEncouragement
