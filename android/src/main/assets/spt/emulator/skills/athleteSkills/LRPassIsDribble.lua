local Skill = import("../Skill")

local LRPassIsDribble = class(Skill, "LRPassIsDribble")
LRPassIsDribble.id = "LR_GZOLA2"
LRPassIsDribble.alias = "传带一体-佐拉"

local minAddConfig = 0.4
local maxAddConfig = 0.4
local minProbabilityConfig = 1
local maxProbabilityConfig = 1

function LRPassIsDribble:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)
end

return LRPassIsDribble