local Skill = import("../Skill")
local BreakThroughEx1 = import("./BreakThroughEx1")
local KingOfTheGun = import("./KingOfTheGun")

local KingOfTheGunEx1 = class(BreakThroughEx1, "KingOfTheGunEx1")
KingOfTheGunEx1.id = "B01_HENRY_1"
KingOfTheGunEx1.alias = "EX枪王之王"

local minProbability = 1
local maxProbability = 1
-- 传球属性加成
local minAbilityConfig = 0.55
local maxAbilityConfig = 5.5


function KingOfTheGunEx1:ctor(level)
    BreakThroughEx1.ctor(self, level)
    if KingOfTheGun.initConfig then
        KingOfTheGun.initConfig(self, level)
    end

    self.ex1SLProbability = Skill.lerpLevel(minProbability, maxProbability, level)
    self.ex1SLAddRatio = Skill.lerpLevel(minAbilityConfig, maxAbilityConfig, level)

    self.buff = {
        skill = self,
        remark = "selfBuff",
        removalCondition = function(remainingTime, caster, receiver)
            return not receiver:hasBall()
        end,
        abilitiesModifier = function(abilities, caster, receiver)
            abilities.dribble = abilities.dribble + (receiver.initAbilities.dribble + receiver.initAbilities.shoot) * self.ex1SLAddRatio
        end,
    }

end

return KingOfTheGunEx1
