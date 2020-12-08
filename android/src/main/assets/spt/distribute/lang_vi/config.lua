___CONFIG__ACCOUNT_URL = "http://seat.capstones.cn/"

luaevt.trig('___EVENT__ACCOUNT_SERVER_CONFIG')

___CONFIG__BASE_URL = ___CONFIG__ACCOUNT_URL

luaevt.reg("__VN__VERSION__", function()
    return true
end)

