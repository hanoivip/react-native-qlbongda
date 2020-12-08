local ThroughBall = import("./ThroughBall")

local SambaWhirlwind = class(ThroughBall, "SambaWhirlwind")
SambaWhirlwind.id = "C01_KAKA"
SambaWhirlwind.alias = "米兰幻想曲"

local minPassConfig = 0.66
local maxPassConfig = 6.6

function SambaWhirlwind:ctor(level)
    ThroughBall.ctor(self, level)
    SambaWhirlwind.initConfig(self)
end

function SambaWhirlwind.initConfig(skillInstance)
    skillInstance.minPassConfig = minPassConfig
    skillInstance.maxPassConfig = maxPassConfig
end

return SambaWhirlwind
