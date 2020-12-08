local Skill = import("../Skill")

local LRGoalKeeper = class(Skill, "LRGoalKeeper")
LRGoalKeeper.id = "LR_MNEUER2"
LRGoalKeeper.alias = "门卫-诺伊尔"

local minAddConfig = 0.08
local maxAddConfig = 0.08
local minProbabilityConfig = 1
local maxProbabilityConfig = 1

function LRGoalKeeper:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)
end

return LRGoalKeeper