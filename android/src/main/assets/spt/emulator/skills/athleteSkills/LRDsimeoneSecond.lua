local Skill = import("../Skill")
local AIConstants = import("../../AIConstants")

local LRDsimeoneSecond = class(Skill, "LRDsimeoneSecond")
LRDsimeoneSecond.id = "LR_DSIMEONE2"
LRDsimeoneSecond.alias = "铁血防线"

local cooldownConfig = 0
local minAddConfig = 0.4
local maxAddConfig = 0.4
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
local minExtraAddConfig = 0.6
local maxExtraAddConfig = 0.6

function LRDsimeoneSecond:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)
    self.extraAddRatio = Skill.lerpLevel(minExtraAddConfig, maxExtraAddConfig, level)

    self.buff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return caster.team.scoreState ~= AIConstants.teamScoreState.DRAW
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.addRatio
        end,
        persistent = true
    }

    self.extraBuff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return caster.team.scoreState ~= AIConstants.teamScoreState.LEAD
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.extraAddRatio
        end,
        persistent = true
    }
end

function LRDsimeoneSecond:enterField(athlete)
    athlete:castSkill(LRDsimeoneSecond)
    for _, friend in ipairs(athlete.team.athletes) do
        friend:addBuff(self.buff, athlete)
    end
end

return LRDsimeoneSecond
