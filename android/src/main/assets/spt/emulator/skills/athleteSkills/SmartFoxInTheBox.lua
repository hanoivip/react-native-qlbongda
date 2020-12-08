local Skill = import("../Skill")

local SmartFoxInTheBox = class(Skill, "SmartFoxInTheBox")
SmartFoxInTheBox.id = "LR_LSUAREZ2"
SmartFoxInTheBox.alias = "禁区灵狐"

local minAbilityConfig = 0.4
local maxAbilityConfig = 0.4
local minProbabilityConfig = 1
local maxProbabilityConfig = 1

function SmartFoxInTheBox:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)

    self.buff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return true
        end,
        abilitiesModifier = function(abilities, caster, receiver)
            abilities.shoot = abilities.shoot + caster.initAbilities.dribble * Skill.lerpLevel(minAbilityConfig, maxAbilityConfig, level)
        end,
    }
end

return SmartFoxInTheBox
