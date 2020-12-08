local Skill = import("../Skill")
local SlidingTackleEx1 = import("./SlidingTackleEx1")
local BlueAndWhiteBandits = import("./BlueAndWhiteBandits")

local BlueAndWhiteBanditsEx1 = class(SlidingTackleEx1, "BlueAndWhiteBanditsEx1")
BlueAndWhiteBanditsEx1.id = "A01_SIMEONE_1"
BlueAndWhiteBanditsEx1.alias = "EX蓝白悍匪"

-- 概率
local minProbabilityConfig = 0.6
local maxProbabilityConfig = 0.6
-- 减全属性
local minSubConfig = 0.6
local maxSubConfig = 0.6
BlueAndWhiteBanditsEx1.durationConfig = 60

function BlueAndWhiteBanditsEx1:ctor(level)
    SlidingTackleEx1.ctor(self, level)

    -- SlidingTackleEx1的属性
    self.ex1Probability = Skill.lerpLevel(minProbabilityConfig, maxProbabilityConfig, level)
    self.ex1SubRatio = -Skill.lerpLevel(minSubConfig, maxSubConfig, level)

    self.ex1Debuff = {
        skill = self,
        duration = self.durationConfig,
        remark = "mark",
        removalCondition = function(remainingTime, caster, receiver)
            return math.cmpf(remainingTime, 0) <= 0
        end,
        abilitiesAddRatio = function(caster, receiver)
            return self.ex1SubRatio
        end,
    }

    if BlueAndWhiteBandits.initConfig then
        BlueAndWhiteBandits.initConfig(self)
    end
end

return BlueAndWhiteBanditsEx1
