local vnglogin = {}

local platform = "vng_vn"
local channel = "vng_vn"

luaevt.reg("Dist_LoginSuccess_VNG", function(cate, userID, userName, sessionID, loginType, countryCode, accessToken, token_expirationtime, GGAuthcode, socialID)
    ndump(userID, userName, sessionID, loginType, countryCode, accessToken, token_expirationtime, GGAuthcode, socialID)
    luaevt.trig("SDK_Report", "sdk_login_done", channel, userID, clr.plat)
    clr.coroutine(function ()
        local cuid = userID
        local uinfo = {
            uid = cuid,
            userName = userName,
            loginType = loginType,
            socialID = socialID,
            countryCode = countryCode,
            sessionID = sessionID,
            accessToken = accessToken,
        }
        local biChannel = luaevt.trig("SDK_GetChannel")

        local LoginCtrl = require("ui.controllers.login.LoginCtrl")
        while not LoginCtrl.___deviceOver do
            coroutine.yield()
        end

        cache.setCuid(cuid)
        cache.setChannel(channel)
        local resp = req.unitedlogin(platform, cuid, channel, biChannel, uinfo)
        if api.success(resp) then
            luaevt.trig("SendBIReport", "login_success", "12")
            local data = resp.val

            cache.setLocalData("vn_antiAddictionCache", data.account.antiAddiction, false)

            if type(LoginCtrl.OnLoginSuccess) == "function" then
                LoginCtrl.OnLoginSuccess(channel)
            end
        end
    end)
end)

luaevt.reg("Dist_LoginFail_VNG", function(cate, err)
    dump(err, "-------Dist_LoginFail_VNG-------")
    local LoginCtrl = require("ui.controllers.login.LoginCtrl")
    while not LoginCtrl.___deviceOver do
        coroutine.yield()
    end
    if type(LoginCtrl.OnLoginFail) == "function" then
        LoginCtrl.OnLoginFail()
    end
end)

local function SendBIReport(metric, data)
    local jsonData = json.encode(data)
    luaevt.trig("SDK_HoolaiBIReport", metric, jsonData)
end

local serverZone = 28800

local function GetCurrentTime()
    local function get_timezone()
        local now = os.time()
        return os.difftime(now, os.time(os.date("!*t", now)))
    end
    local localTimeZone = get_timezone()
    return os.date("%H:%M:%S", os.time() - (localTimeZone - serverZone))
end

local function GetCurrentData()
    local function get_timezone()
        local now = os.time()
        return os.difftime(now, os.time(os.date("!*t", now)))
    end
    local localTimeZone = get_timezone()
    return os.date("%Y-%m-%d", os.time() - (localTimeZone - serverZone))
end

return vnglogin
