local Skill = import("../Skill")
local HeavyGunner = import("./HeavyGunner")

local RedArmyHeavyGunner = class(HeavyGunner, "RedArmyHeavyGunner")
RedArmyHeavyGunner.id = "D07_GERRARD"
RedArmyHeavyGunner.alias = "红军攻城炮"

local minAbilitiesSumMultiply = 0.396
local maxAbilitiesSumMultiply = 3.96

function RedArmyHeavyGunner:ctor(level)
    HeavyGunner.ctor(self, level)
    RedArmyHeavyGunner.initConfig(self, level)
end

function RedArmyHeavyGunner.initConfig(skillInstance, level)
    skillInstance.abilitiesSumMultiply = Skill.lerpLevel(minAbilitiesSumMultiply, maxAbilitiesSumMultiply, level)
end

return RedArmyHeavyGunner
