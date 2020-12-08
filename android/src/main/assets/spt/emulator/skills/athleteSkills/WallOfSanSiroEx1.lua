local Skill = import("../Skill")
local DefendDeterrentEx1 = import("./DefendDeterrentEx1")
local WallOfSanSiro = import("./WallOfSanSiro")

local WallOfSanSiroEx1 = class(DefendDeterrentEx1, "WallOfSanSiroEx1")
WallOfSanSiroEx1.id = "G05_NESTA_1"
WallOfSanSiroEx1.alias = "EX圣西罗城墙"

local minProbability = 1
local maxProbability = 1
-- 全属性减少配置
local minAbilityConfig = 0.1
local maxAbilityConfig = 1.1

function WallOfSanSiroEx1:ctor(level)
    DefendDeterrentEx1.ctor(self, level)

    if WallOfSanSiro.initConfig then
        WallOfSanSiro.initConfig(self, level)
    end

    self.ex1SLProbability = Skill.lerpLevel(minProbability, maxProbability, level)
    self.ex1SLAddRatio = Skill.lerpLevel(minAbilityConfig, maxAbilityConfig, level)

    self.ex1Buff = {
        skill = self,
        removalCondition = function(remainingTime, caster, receiver)
            return receiver.team:isAttackRole()
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.ex1SLAddRatio
        end,
    }
end

return WallOfSanSiroEx1
