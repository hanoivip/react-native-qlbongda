--[[
    所有刘海屏适配都将基于从系统API方法获取刘海屏相关参数。
    但同时保留以下配置的方式，以便能快速解决一些特殊机型的适配问题
--]]
local SafeAreaConfig = {}

SafeAreaConfig.AndroidModelConfig = {
    -----注意型号key 必须小写----------------------
    -- 数据格式
    -- {screenWidth, screenHeight, notchSize}
}

-- https://gist.github.com/adamawolf/3048717
-- https://www.theiphonewiki.com/wiki/Models
SafeAreaConfig.IOSModelConfig = {
    ["iPhone10,3"] = {2436, 1125, 90},  -- iPhone X
    ["iPhone10,6"] = {2436, 1125, 90},  -- iPhone X GSM
    ["iPhone11,2"] = {2436, 1125, 90},  -- iPhone XS
    ["iPhone11,4"] = {2688, 1242, 90},  -- iPhone XS Max
    ["iPhone11,6"] = {2688, 1242, 90},  -- iPhone XS Max China
    ["iPhone11,8"] = {1792, 828, 60},   -- iPhone XR
    ["iPhone12,1"] = {1792, 828, 60},   -- iPhone 11
    ["iPhone12,3"] = {2436, 1125, 60},   -- iPhone 11 Pro
    ["iPhone12,5"] = {2688, 1242, 60},   -- iPhone 11 Pro Max
}

local configStr = ""
if clr.plat == "Android" then

elseif clr.plat == "IPhonePlayer" then
    local SystemInfo = clr.UnityEngine.SystemInfo
    local deviceModel = SystemInfo.deviceModel
    for i, v in ipairs(SafeAreaConfig.IOSModelConfig[deviceModel]) do
        configStr = configStr .. v .. ","
    end
elseif clr.UnityEngine.Application.isEditor then

end
clr.UnityEngine.PlayerPrefs.SetString("SafeAreaConfig", configStr)
clr.UnityEngine.PlayerPrefs.Save()

return SafeAreaConfig