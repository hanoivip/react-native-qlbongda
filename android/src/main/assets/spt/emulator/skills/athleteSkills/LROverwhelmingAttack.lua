local Skill = import("../Skill")

local LROverwhelmingAttack = class(Skill, "LROverwhelmingAttack")
LROverwhelmingAttack.id = "LR_RLEWANDOWSKI2"
LROverwhelmingAttack.alias = "压制性进攻-莱万"

-- 额外计入全属性的比例
local minAddConfig = 0.4
local maxAddConfig = 0.4
local minProbabilityConfig = 1
local maxProbabilityConfig = 1
-- 每次进球后增加的全属性比例(一次增加这么多)
local upgradeRatioConfig = 0.18

function LROverwhelmingAttack:ctor(level)
    if level < 1 or level > 400 then
        error("wrong level")
    end

    self.level = level
    self.remainingCooldown = 0
    self.probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)
    self.upgradeRatio = upgradeRatioConfig
end

return LROverwhelmingAttack