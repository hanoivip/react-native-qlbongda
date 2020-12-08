local AntiAddictionSystem = {}

if clr.plat == "WindowsEditor" then
    return AntiAddictionSystem
end

local UnityEngine = clr.UnityEngine
local GameObject = UnityEngine.GameObject
local Object = UnityEngine.Object
local MonoBehaviour = clr.DummyBehav
local ResManager = clr.Capstones.UnityFramework.ResManager
local Time = UnityEngine.Time
local Application = UnityEngine.Application
local WaitForSeconds = UnityEngine.WaitForSeconds

local maxTimeLength = 3 * 60 * 60
local showTipsInterval = 5 * 60

local function getAntiAddictionCache()
    local cacheData = cache.getLocalData("vn_antiAddictionCache")
    if not cacheData then
        cacheData = {
            antiAddictionCD = maxTimeLength,
            antiAddictionStatus = 0, -- 0关闭，1开启，2政府审核
        }

        cache.setLocalData("vn_antiAddictionCache", cacheData, false)
    end

    return cacheData
end

local function getReportTimeInterval()
    local reportTimeInterval = 2 * 60
    if getAntiAddictionCache().antiAddictionStatus ~= 0 then
        reportTimeInterval = 20
    end

    return reportTimeInterval
end

local url_a_antiAddiction = "player/antiAddiction"
local function accountAntiAddictionRequest(remainTime)
    local data = {
        cd = tonumber(remainTime),
    }

    return req.post(url_a_antiAddiction, data, nil, nil, true)
end

local function reportAntiAddictionTime(remainTime)
    clr.coroutine(function()
        local response = accountAntiAddictionRequest(remainTime)
        if api.success(response) then
            local data = response.val
            cache.setLocalData("vn_antiAddictionCache", data.antiAddiction, false)
        end
    end)
end

local antiAddictionView = nil
local function getAntiAddictionView()
    if antiAddictionView == nil or antiAddictionView == clr.null then
        local go, spt = res.Instantiate("Assets/CapstonesRes/Game/UI/Common/Anti-addictionSystem/Anti-addictionCanvas.prefab")
        res.DontDestroyOnLoad(go)

        spt.onOvertimeConfirmClick = function()
            luaevt.trig("Game_Logout")
        end

        antiAddictionView = spt
        if getAntiAddictionCache().antiAddictionStatus == 2 then
            antiAddictionView:Init()
        else
            antiAddictionView:Hide()
        end
    end

    return antiAddictionView
end

local CDStart = false
local clientFrameSeconds = 0
local currentDay = os.date("%d")
local function startCD()
    CDStart = true
    clr.coroutine(function()
        while true do
            -- 跨天
            local day = os.date("%d")
            if day ~= currentDay then
                currentDay = day
                reportAntiAddictionTime(maxTimeLength)
            end

            -- 剩余时间小于0时打开超时弹板
            if getAntiAddictionCache().antiAddictionCD <= 0 then
                if getAntiAddictionCache().antiAddictionStatus ~= 0 then
                    getAntiAddictionView():ShowOvertimePanel(true)
                    reportAntiAddictionTime(0)
                    CDStart = false
                    break
                end
            else
                -- 每隔2分钟向服务器发送剩余时间
                if clientFrameSeconds > 0 and math.fmod(clientFrameSeconds, getReportTimeInterval()) == 0 then
                    reportAntiAddictionTime(getAntiAddictionCache().antiAddictionCD)
                end

                -- 每隔5分钟显示tips
                if clientFrameSeconds > 0 and math.fmod(clientFrameSeconds, showTipsInterval) == 0 then
                    getAntiAddictionView():ShowTips(true)
                end

                clientFrameSeconds = clientFrameSeconds + 1

                getAntiAddictionCache().antiAddictionCD = getAntiAddictionCache().antiAddictionCD - 1

                getAntiAddictionView():SetCountdown(getAntiAddictionCache().antiAddictionCD)
            end

            coroutine.yield(WaitForSeconds(1))

            -- dump("Anti-Addiction System coroutine heart beat : " .. clientFrameSeconds)
        end
    end)
end

-- 处理因调用res.DestroyAll()之后导致的资源丢失情况  --Lua assist checked flag
luaevt.reg("res_destroyAll", function()
    if antiAddictionView then
        Object.Destroy(antiAddictionView.gameOject)
        antiAddictionView = nil
    end
end)

luaevt.reg("EnterHomeScene", function()
    if not CDStart then
        startCD()
    end
    getAntiAddictionView():ShowLabel00(true)
    getAntiAddictionView():ShowCountdown(true)
end)

luaevt.reg("ExitHomeScene", function()
    if getAntiAddictionCache().antiAddictionStatus ~= 2 then
        getAntiAddictionView():ShowLabel00(false)
        getAntiAddictionView():ShowCountdown(false)
    end    
end)

return AntiAddictionSystem
