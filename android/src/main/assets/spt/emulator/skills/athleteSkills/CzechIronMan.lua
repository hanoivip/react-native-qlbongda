local PerpetualMotionMachine = import("./PerpetualMotionMachine")

local CzechIronMan = class(PerpetualMotionMachine, "CzechIronMan")
CzechIronMan.id = "G01_NEDVED"
CzechIronMan.alias = "捷克铁人"

CzechIronMan.minAddConfig = 0.0396
CzechIronMan.maxAddConfig = 0.396

-- 初始化配置数据以复用,在基类ctor之前调用
function CzechIronMan:initConfig(skill)
    skill.minAddConfig = self.minAddConfig
    skill.maxAddConfig = self.maxAddConfig
end

return CzechIronMan
