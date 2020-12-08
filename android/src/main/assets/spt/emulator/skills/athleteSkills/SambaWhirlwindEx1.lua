local Skill = import("../Skill")
local ThroughBallEx1 = import("./ThroughBallEx1")
local SambaWhirlwind = import("./SambaWhirlwind")

local SambaWhirlwindEx1 = class(ThroughBallEx1, "SambaWhirlwindEx1")
SambaWhirlwindEx1.id = "C01_KAKA_1"
SambaWhirlwindEx1.alias = "Ex米兰幻想曲"

local minProbability = 1
local maxProbability = 1
-- 传球属性加成
local minAbilityConfig = 0.7
local maxAbilityConfig = 7
-- 全属性减少配置
local minSubAbilityConfig = 0.5
local maxSubAbilityConfig = 0.5

function SambaWhirlwindEx1:ctor(level)
    ThroughBallEx1.ctor(self, level)
    if SambaWhirlwind.initConfig then
        SambaWhirlwind.initConfig(self)
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
            abilities.pass = abilities.pass + (receiver.initAbilities.pass + receiver.initAbilities.dribble) * self.ex1SLAddRatio
        end,
    }

end

return SambaWhirlwindEx1
