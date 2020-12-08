local Skill = import("../Skill")

local LRSgerrardSecond = class(Skill, "LRSgerrardSecond")
LRSgerrardSecond.id = "LR_SGERRARD2"
LRSgerrardSecond.alias = "安菲尔德鼓舞"

local cooldownConfig = 0
local minAddConfig = 0.2
local maxAddConfig = 0.2
local minProbabilityConfig = 1
local maxProbabilityConfig = 1

function LRSgerrardSecond:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)

    self.buff = {
        skill = self,
        duration = durationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return false
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.addRatio
        end,
        persistent = true
    }
end

return LRSgerrardSecond