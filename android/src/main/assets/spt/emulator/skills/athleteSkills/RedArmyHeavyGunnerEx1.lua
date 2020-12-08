local Skill = import("../Skill")
local HeavyGunnerEx1 = import("./HeavyGunnerEx1")
local RedArmyHeavyGunner = import("./RedArmyHeavyGunner")

local RedArmyHeavyGunnerEx1 = class(HeavyGunnerEx1, "RedArmyHeavyGunnerEx1")
RedArmyHeavyGunnerEx1.id = "D07_GERRARD_1"
RedArmyHeavyGunnerEx1.alias = "Ex红军攻城炮"

local minProbability = 1
local maxProbability = 1
local minAbilityConfig = 0.3
local maxAbilityConfig = 0.3

function RedArmyHeavyGunnerEx1:ctor(level)
    HeavyGunnerEx1.ctor(self, level)
    if RedArmyHeavyGunner.initConfig then
        RedArmyHeavyGunner.initConfig(self, level)
    end

    self.ex1SLProbability = Skill.lerpLevel(minProbability, maxProbability, level)
    self.ex1DistanceRatio = Skill.lerpLevel(minAbilityConfig, maxAbilityConfig, level)

    self.ex1SLBuff = {
        skill = self,
        remark = "selfBuff",
        removalCondition = function(remainingTime, caster, receiver)
            return not receiver:hasBall()
        end,
    }
end

return RedArmyHeavyGunnerEx1
