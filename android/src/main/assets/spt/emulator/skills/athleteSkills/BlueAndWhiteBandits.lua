local SlidingTackle = import("./SlidingTackle")

local BlueAndWhiteBandits = class(SlidingTackle, "BlueAndWhiteBandits")
BlueAndWhiteBandits.id = "A01_SIMEONE"
BlueAndWhiteBandits.alias = "蓝白悍匪"

local minStealConfig = 0.66
local maxStealConfig = 6.6

function BlueAndWhiteBandits:ctor(level)
    SlidingTackle.ctor(self, level)
    BlueAndWhiteBandits.initConfig(self)
end

function BlueAndWhiteBandits.initConfig(skillInstance)
    skillInstance.minStealConfig = minStealConfig
    skillInstance.maxStealConfig = maxStealConfig
end

return BlueAndWhiteBandits
