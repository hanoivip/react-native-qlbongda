local sdk_vng_android = {}

local UnityEngine = clr.UnityEngine
local GameObject = UnityEngine.GameObject
local MonoBehaviour = clr.DummyBehav
local ResManager = clr.Capstones.UnityFramework.ResManager
local Time = UnityEngine.Time
local Application = UnityEngine.Application

local canShowSDKExit = true
local exitConfirmDlg = nil

local go = GameObject("vng_sdk")
ResManager.DontDestroyOnLoad(go)
clr.bcoroutine(go:AddComponent(MonoBehaviour), function()
    local lvl
    while true do
        luaevt.delayed()
        -- get player lvl and check lvlup
        if cache then
            local playerInfo = cache.getPlayerInfo()
            if type(playerInfo) == "table" and playerInfo.lvl then
                local newlvl = tonumber(playerInfo.lvl)
                if lvl then
                    if newlvl > lvl then
                        local server = cache.getCurrentServer()
                        luaevt.trig("SDK_PushUserOp", "Lvlup", playerInfo._id, playerInfo.name, newlvl, server.id, server.name, playerInfo.d)
                    end
                end
                lvl = newlvl
            end
        end
        
        if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Escape) then
           if exitConfirmDlg and exitConfirmDlg ~= clr.null then
              exitConfirmDlg.closeDialog()
              exitConfirmDlg = nil
           else
              if canShowSDKExit then
                 canShowSDKExit = false
                 luaevt.trig("SDK_Exit")
              end
           end
        end
        coroutine.yield()
    end
end)

luaevt.reg("SDK_HaveExit", function()
    return false
end)

luaevt.reg("HasPurchaseSystem", function()
    return true
end)

luaevt.reg("Do_Pay", function(cate, productId, model, chargeItemView)
    clr.coroutine(function()
        local playerInfoModel = require("ui.models.PlayerInfoModel").new()
        local roleLevel = playerInfoModel:GetLevel()
        -- VNG SDK Wallet params
        local currentServer = cache.getCurrentServer()
        local serverID = tostring(currentServer.id)
        local roleId = playerInfoModel:GetID()
        local amount = tostring(model:GetItemPrice())
        local itemID = tostring(productId)
        local itemName = tostring(model:GetItemName())
        local productDesc = tostring(model:GetItemDesc())
        local appTransID = ""
        local addInfo = ""
        -- end
        local price = model:GetItemPrice()
        local productName = model:GetItemName()
        local initResp = req.payInit(productId, 0)
        if api.success(initResp) then
            local blockdlg = nil
            local orderId = initResp.val.order_id
            appTransID = tostring(orderId)

            luaevt.trig("SDK_Report", "pay_begin", roleId, roleLevel, productId)
            local function showBlockDlg()
                if not blockdlg then
                    local dialog, dialogcomp = res.ShowDialog("Assets/CapstonesRes/Game/UI/Common/Template/Loading/WaitForPost.prefab", "overlay", false)
                    blockdlg = dialogcomp
                    dialogcomp.contentcomp:SetTxts({lang.trans("wait_for_diamond_arrival")})
                end
            end
            
            local function closeBlockDlg()
                if blockdlg then
                    local closeDialog = blockdlg.closeDialog
                    if type(closeDialog) == "function" then
                        closeDialog()
                    end
                    blockdlg = nil
                end
            end
            -- 热云sdk，开始充值统计
            require("ui.common.ReyunCustomEvent").ZhifuStart(orderId, productId, price)
            
            luaevt.unreg("Dist_PaySuccess")
            luaevt.unreg("Dist_PayFail")
            local handle_s, handle_f
            -- reg 充值成功的回调
            handle_s = luaevt.reg("Dist_PaySuccess", function()
                luaevt.unreg("Dist_PaySuccess", handle_s)
                luaevt.unreg("Dist_PayFail", handle_f)
                closeBlockDlg()
                clr.coroutine(function()
                    local function doArrivalCheck()
                        showBlockDlg()
                        for i = 1, 30 do
                            coroutine.yield()
                        end
                        local resp = req.payCheckArrived(orderId, nil, nil, true)
                        if api.success(resp) and type(resp.val) == "table" and resp.val.ok == 0 then
                            closeBlockDlg()
                            local title = lang.trans("charge_success_title")
                            local msg = lang.trans("charge_success")
                            local confirmFunc = function() end
                            require("ui.control.manager.DialogManager").ShowAlertPop(title, msg, confirmFunc)
                            -- 热云sdk，充值成功统计
                            require("ui.common.ReyunCustomEvent").Zhifu(orderId, productId, price)
                            
                            --刷新充值面板
                            playerInfoModel:SetDiamond(resp.val.d)
                            playerInfoModel:SetBlackDiamond(resp.val.bkd)
                            EventSystem.SendEvent("Charge_Success")
                            chargeItemView:SetNotFirst()
                            luaevt.trig("SDK_Report", "pay_done", roleId, roleLevel, price, productName, productDesc, productId)
                            return true
                        else
                            return false
                        end
                    end
                    local function smartDoArrivalCheck()
                        local cur_time = Time.unscaledTime
                        local time_to_bubble = function()
                            return Time.unscaledTime - cur_time > 10
                        end
                        
                        while not doArrivalCheck() do
                            if time_to_bubble() then
                                closeBlockDlg()
                                local title = lang.trans("charge_failed_title")
                                local msg = lang.trans("charge_failed_msg")
                                local confirmFunc = function()
                                    clr.coroutine(function()
                                        smartDoArrivalCheck()
                                    end)
                                end
                                local cancelFunc = function() end
                                require("ui.control.manager.DialogManager").ShowConfirmPop(title, msg, confirmFunc, cancelFunc)
                                break
                            end
                        end
                    end
                    smartDoArrivalCheck()
                end)
            end)
            -- reg 充值失败的回调
            handle_f = luaevt.reg("Dist_PayFail", function()
                luaevt.unreg("Dist_PaySuccess", handle_s)
                luaevt.unreg("Dist_PayFail", handle_f)
                closeBlockDlg()
                local confirmFunc = function()
                end
                require("ui.control.manager.DialogManager").ShowAlertPopByLang("training_dribbleKickFail", "charge_failed", confirmFunc)
            end)
            -- ndump(serverID, amount, itemID, itemName, appTransID, addInfo)
            luaevt.trig("SDK_Pay", serverID, amount, itemID, itemName, appTransID, addInfo, roleId)
        end
    end)
end)

luaevt.reg("Do_Pay_Special", function(cate, model, giftBoxItemPopCtrl)
    clr.coroutine(function()
        local playerInfoModel = require("ui.models.PlayerInfoModel").new()
        local roleLevel = playerInfoModel:GetLevel()
        local productId = model:GetID()
        local price = model:GetPrice()
        local productName = model:GetTitle()
        local productDesc = tostring(model:GetDesc())
        -- VNG SDK Wallet params
        local roleId = playerInfoModel:GetID()
        local currentServer = cache.getCurrentServer()
        local serverID = tostring(currentServer.id)
        local amount = tostring(price)
        local itemID = tostring(productId)
        local itemName = tostring(productName)
        local appTransID = ""
        local addInfo = ""
        -- end
        local initResp = req.buyGiftBox(productId)
        if api.success(initResp) then
            local blockdlg = nil
            local orderId = initResp.val.order_id

            luaevt.trig("SDK_Report", "pay_begin", roleId, roleLevel)
            local function showBlockDlg()
                if not blockdlg then
                    local dialog, dialogcomp = res.ShowDialog("Assets/CapstonesRes/Game/UI/Common/Template/Loading/WaitForPost.prefab", "overlay", false)
                    blockdlg = dialogcomp
                    dialogcomp.contentcomp:SetTxts({lang.trans("wait_for_diamond_arrival")})
                end
            end
            
            local function closeBlockDlg()
                if blockdlg then
                    local closeDialog = blockdlg.closeDialog
                    if type(closeDialog) == "function" then
                        closeDialog()
                    end
                    blockdlg = nil
                end
            end
            -- 热云sdk，开始充值统计
            require("ui.common.ReyunCustomEvent").ZhifuStart(orderId, productId, price)
            
            luaevt.unreg("Dist_PaySuccess")
            luaevt.unreg("Dist_PayFail")
            local handle_s, handle_f
            -- reg 充值成功的回调
            handle_s = luaevt.reg("Dist_PaySuccess", function()
                luaevt.unreg("Dist_PaySuccess", handle_s)
                luaevt.unreg("Dist_PayFail", handle_f)
                closeBlockDlg()
                clr.coroutine(function()
                    local function doArrivalCheck()
                        showBlockDlg()
                        for i = 1, 30 do
                            coroutine.yield()
                        end
                        local resp = req.payCheckArrived(orderId, nil, nil, true)
                        if api.success(resp) and type(resp.val) == "table" and resp.val.ok == 0 then
                            closeBlockDlg()
                            local title = lang.trans("charge_success_title")
                            local msg = lang.trans("charge_success")
                            local confirmFunc = function()
                            end
                            require("ui.control.manager.DialogManager").ShowAlertPop(title, msg, confirmFunc)
                            -- 热云sdk，充值成功统计
                            require("ui.common.ReyunCustomEvent").Zhifu(orderId, productId, price)
                            giftBoxItemPopCtrl:BuyGiftBoxSuccess(resp.val.contents)
                            luaevt.trig("SDK_Report", "pay_done", roleId, roleLevel, price, productName, productDesc, productId)
                            return true
                        else
                            return false
                        end
                    end
                    local function smartDoArrivalCheck()
                        local cur_time = Time.unscaledTime
                        local time_to_bubble = function()
                            return Time.unscaledTime - cur_time > 10
                        end
                        
                        while not doArrivalCheck() do
                            if time_to_bubble() then
                                closeBlockDlg()
                                local title = lang.trans("charge_failed_title")
                                local msg = lang.trans("charge_failed_msg")
                                local confirmFunc = function()
                                    clr.coroutine(function()
                                        smartDoArrivalCheck()
                                    end)
                                end
                                local cancelFunc = function() end
                                require("ui.control.manager.DialogManager").ShowConfirmPop(title, msg, confirmFunc, cancelFunc)
                                break
                            end
                        end
                    end
                    smartDoArrivalCheck()
                end)
            end)
            -- reg 充值失败的回调
            handle_f = luaevt.reg("Dist_PayFail", function()
                luaevt.unreg("Dist_PaySuccess", handle_s)
                luaevt.unreg("Dist_PayFail", handle_f)
                closeBlockDlg()
                local confirmFunc = function()
                end
                require("ui.control.manager.DialogManager").ShowAlertPopByLang("training_dribbleKickFail", "charge_failed", confirmFunc)
            end)
            luaevt.trig("SDK_Pay", serverID, amount, itemID, itemName, appTransID, addInfo, roleId)
        end
    end)
end)

luaevt.reg("Dist_CanShowSDKExit", function()
    canShowSDKExit = true
end)

luaevt.reg("Dist_ShowExitConfirm", function()
    if not exitConfirmDlg then
        local content = {}
        content.title = lang.trans("exit_confirm")
        content.content = lang.trans("exit_confirm_msg")
        content.button1Text = lang.trans("cancel")
        content.onButton1Clicked = function()
            exitConfirmDlg = nil
        end
        content.button2Text = lang.trans("confirm")
        content.onButton2Clicked = function()
            UnityEngine.Application.Quit()
        end
        content.hideCloseIcon = true
        local resDlg, dialogcomp = res.ShowDialog("Assets/CapstonesRes/Game/UI/Control/Dialog/MessageBox.prefab", "overlay", false, true, nil, nil, 10000)
        exitConfirmDlg = dialogcomp.contentcomp
        dialogcomp.contentcomp:initData(content)
    end
end)

luaevt.reg("Dist_Exit", function()
    UnityEngine.Application.Quit()
end)

luaevt.reg("Dist_Logout", function()
    local isClearData = cache.getIsClearData()
    if isClearData then
        clr.Capstones.UnityFramework.ResManager.ResetCacheVersion()
        cache.setIsClearData(false)
    end
    unity.restart()
end)

luaevt.reg("Dist_VNGSDK_Close", function()
    cache.setAccount(nil)
end)

luaevt.reg("Force_Cold_Update", function()
    local bichannel = luaevt.trig("SDK_GetChannel")
    if not bichannel then
        bichannel = ""
    end
    if type(bichannel) ~= "string" then
        bichannel = tostring(bichannel)
    end
    UnityEngine.Application.OpenURL(___CONFIG__ACCOUNT_URL .. "device/forcecoldupdate?did=" .. bichannel)
end)

luaevt.reg("___EVENT__ACCOUNT_SERVER_CONFIG", function()
    local url = luaevt.trig("SDK_GetMetaData", "ACCOUNT_URL")
    if ___CONFIG__CHANGESERVER_URL then 
        ___CONFIG__ACCOUNT_URL = ___CONFIG__CHANGESERVER_URL
    elseif type(url) == "string" and url ~= "" then
        ___CONFIG__ACCOUNT_URL = url
    end
end)

luaevt.reg("Dist_LoginFailed", function()
    local LoginCtrl = require("ui.controllers.login.LoginCtrl")
    if LoginCtrl.instance then
        LoginCtrl.instance:SetLoginFlag(false)
        LoginCtrl.instance.view:OnLoginComplete()
    end
end)

luaevt.reg("Game_Logout", function()
    unity.restart()
end)

luaevt.reg("Game_CustomerService", function()
    luaevt.trig("SDK_CustomerService")
end)

luaevt.reg("SDK_ShareImage_OnComplete", function(cate, token)
    clr.coroutine(function()
        local respone = req.rewardFinish("3001")
        -- "3001" 奖励任务ID
        if api.success(respone) then
            local data = respone.val
            if data["3001"] ~= nil then
                cache.setIsShareTaskComplete(data["3001"].state ~= -1)
            end
        end
        luaevt.trig("ShareSDK_OnComplete", action)
        require("ui.control.manager.DialogManager").ShowToast(lang.trans("share_success_title"))
    end)
    cache.setSharePlatform("")
    luaevt.trig("ShareSDK_CloseDialog")
end)

luaevt.reg("SDK_ShareImage_OnError", function(cate, token)
    require("ui.control.manager.DialogManager").ShowToast(lang.trans("not_install_facebook"))
end)

luaevt.reg("SDK_ShareImage_OnCancel", function(cate, token)

end)

luaevt.reg("SDK_FBFriendList_OnComplete", function(cate, ...)
    local arg = {...}
    luaevt.trig("FBFriendList_OnComplete", arg)
end)

luaevt.reg("SDK_FBFriendList_OnFailure", function(cate)
    luaevt.trig("FBFriendList_OnFailure")
end)

luaevt.reg("SDK_InviteFriendFB_OnSuccess", function(cate, result)
    luaevt.trig("InviteFriendFB_OnSuccess", result)
end)

luaevt.reg("SDK_InviteFriendFB_OnError", function(cate)
    luaevt.trig("InviteFriendFB_OnError")
end)

luaevt.reg("SDK_InviteFriendFB_OnCancel", function(cate)
    luaevt.trig("InviteFriendFB_OnCancel")
end)

return sdk_vng_android
