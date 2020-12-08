local Skill = import("../Skill")

local AresShotBlasting = class(Skill, "AresShotBlasting")
AresShotBlasting.id = "LR_GBATISTUTA2"
AresShotBlasting.alias = "战神轰射"

local minAddConfig = 0.3
local maxAddConfig = 0.3
local durationConfig = 30
local minProbabilityConfig = 0.4
local maxProbabilityConfig = 0.4

function AresShotBlasting:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.subRatio = -Skill.lerpLevel(minAddConfig, maxAddConfig, level)
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.durationConfig = durationConfig

    self.debuff = {
        skill = self,
        duration = durationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return math.cmpf(remainingTime, 0) <= 0
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.subRatio
        end
    }
end

return AresShotBlasting