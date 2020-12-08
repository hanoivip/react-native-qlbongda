local Skill = import("../Skill")

local AccurateGuide = class(Skill, "AccurateGuide")
AccurateGuide.id = "LR_KDEBRUYNE2"
AccurateGuide.alias = "精准制导"

local cooldownConfig = 0
local minAddConfig = 0.35
local maxAddConfig = 0.35
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
local minPassConfig = 0.2
local maxPassConfig = 0.2
local durationConfig = 10

function AccurateGuide:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)
    self.passAddConfig = Skill.lerpLevel(minPassConfig, maxPassConfig, level)

    self.selfBuff = {
        skill = self,
        remark = "buffSign",
        removalCondition = function(remainingTime, caster, receiver)
            return true
        end,
        abilitiesModifier = function(abilities, caster, receiver)
             abilities.pass = abilities.pass + receiver:getAbilitiesSum() * self.passAddConfig
        end
    }

    self.buff = {
        skill = self,
        duration = durationConfig,
        removalCondition = function(remainingTime, caster, receiver)
            return math.cmpf(remainingTime, 0) <= 0
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.addRatio
        end
    }
end

return AccurateGuide