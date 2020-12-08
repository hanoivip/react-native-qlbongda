local Skill = import("../Skill")
local DefendDeterrent = import("./DefendDeterrent")

local WallOfSanSiro = class(DefendDeterrent, "WallOfSanSiro")
WallOfSanSiro.id = "G05_NESTA"
WallOfSanSiro.alias = "圣西罗城墙"

local minSubConfig = 0.18
local maxSubConfig = 1.368

function WallOfSanSiro:ctor(level)
    DefendDeterrent.ctor(self, level)
    WallOfSanSiro.initConfig(self, level)
end

function WallOfSanSiro.initConfig(skillInstance, level)
    skillInstance.subRatio = -Skill.lerpLevel(minSubConfig, maxSubConfig, level)
end

return WallOfSanSiro
