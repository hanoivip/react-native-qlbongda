﻿local Skill = import("../Skill")

local SlidingTackle = class(Skill, "SlidingTackle")
SlidingTackle.id = "A01"
SlidingTackle.alias = "飞铲"

local cooldownConfig = 0
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
SlidingTackle.minStealConfig = 0.55
SlidingTackle.maxStealConfig = 5.5

function SlidingTackle:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.cooldown = cooldownConfig
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)

    self.buff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return true
        end,
        abilitiesModifier = function(abilities, caster, receiver)
            abilities.steal = abilities.steal + receiver.initAbilities.steal * Skill.lerpLevel(self.minStealConfig, self.maxStealConfig, level)
        end
    }
end

return SlidingTackle