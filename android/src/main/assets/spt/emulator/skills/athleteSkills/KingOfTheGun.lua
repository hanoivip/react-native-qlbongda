local BreakThrough = import("./BreakThrough")
local Skill = import("../Skill")

local KingOfTheGun = class(BreakThrough, "KingOfTheGun")
KingOfTheGun.id = "B01_HENRY"
KingOfTheGun.alias = "枪王之王"

local minAddDribbleConfig = 0.66
local maxAddDribbleConfig = 6.6
local minAddConfig = 0.264
local maxAddConfig = 2.64

function KingOfTheGun:ctor(level)
    BreakThrough.ctor(self, level)
    KingOfTheGun.initConfig(self, level)
end

function KingOfTheGun.initConfig(skillInstance, level)
    skillInstance.addRatio = Skill.lerpLevel(minAddConfig, maxAddConfig, level)
    skillInstance.addDribbleConfig = Skill.lerpLevel(minAddDribbleConfig, maxAddDribbleConfig, level)
end

return KingOfTheGun
