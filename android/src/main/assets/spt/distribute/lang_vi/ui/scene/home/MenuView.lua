local StoreModel = require("ui.models.store.StoreModel")
local StoreCtrl = require("ui.controllers.store.StoreCtrl")
local QualityType = require("ui.controllers.cardIndex.QualityType")
local ItemListMenuType = require("ui.controllers.itemList.MenuType")
local SettingsCtrl = require("ui.controllers.settings.SettingsCtrl")
local OtherMenuCtrl = require("ui.controllers.home.OtherMenuCtrl")
local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local ItemListConstants = require("ui.models.itemList.ItemListConstants")
local FriendsMenuType = require("ui.models.friends.MenuType")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local ReqEventModel = require("ui.models.event.ReqEventModel")
local PlayerInfoModel = require("ui.models.PlayerInfoModel")
local LevelLimit = require("data.LevelLimit")
local CommentSettingCtrl = require("ui.controllers.commentSetting.CommentSettingCtrl")
local DiscussHotTopicModel = require("ui.models.discuss.DiscussHotTopicModel")
local DialogManager = require("ui.control.manager.DialogManager")

local MenuView = class(unity.base)

function MenuView:ctor()
    self.close = self.___ex.close
    self.itemList = self.___ex.itemList
    self.honorPalace = self.___ex.honorPalace
    self.cardIndex = self.___ex.cardIndex
    self.settings = self.___ex.settings
    self.activationCode = self.___ex.activationCode
    self.friends = self.___ex.friends
    self.videoReplay = self.___ex.videoReplay
    self.service = self.___ex.service
    self.out = self.___ex.out
    self.friendsRedPoint = self.___ex.friendsRedPoint
    self.honorRedPoint = self.___ex.honorRedPoint
    self.itemRedPoint = self.___ex.itemRedPoint
    self.notice = self.___ex.notice
    self.medal = self.___ex.medal
    self.rank = self.___ex.rank
    self.pasterBag = self.___ex.pasterBag
end

function MenuView:start()
    -- 提审屏蔽
    local isForbidden = luaevt.trig("___EVENT__NOT_OPEN_FORBIDDEN_VN")
    GameObjectHelper.FastSetActive(self.activationCode.gameObject, not isForbidden)
    GameObjectHelper.FastSetActive(self.service.gameObject, not isForbidden)
    GameObjectHelper.FastSetActive(self.notice.gameObject, not isForbidden)
    
    -- ios版本更换的新sdk暂时没有客服，以后有可能接回来
    if clr.plat == "IPhonePlayer" then
        GameObjectHelper.FastSetActive(self.service.gameObject, false)
        GameObjectHelper.FastSetActive(self.activationCode.gameObject, false)
    end
    -- VI 屏蔽兑换码
    GameObjectHelper.FastSetActive(self.activationCode.gameObject, false)
    self.close:regOnButtonClick(function()
        self:Close()
    end)
    self.itemList:regOnButtonClick(function ()
        -- 防止在恢复场景时没有弹板但是有模糊效果
        res.curSceneInfo.blur = nil
        res.PushScene("ui.controllers.itemList.ItemListMainCtrl", ItemListMenuType.EQUIP, {}, ItemListConstants.SortType.QUALITY_ASCEND, nil, true)
    end)
    self.honorPalace:regOnButtonClick(function ()
        res.PushScene("ui.controllers.honorPalace.HonorPalaceCtrl")
    end)
    self.cardIndex:regOnButtonClick(function ()
        res.PushScene("ui.controllers.cardIndex.CardIndexCtrl", nil, nil, nil, nil, nil, nil, nil)
    end)
     self.friends:regOnButtonClick(function ()
        -- 防止在恢复场景时没有弹板但是有模糊效果
        res.curSceneInfo.blur = nil
        res.PushScene("ui.controllers.friends.FriendsMainCtrl", FriendsMenuType.MESSAGES)
    end)
    self.settings:regOnButtonClick(function()
        clr.coroutine(function ()
            local response = req.setting()
            if api.success(response) then
                local data = response.val
                SettingsCtrl.new(data)
            end
        end)
    end)
    self.activationCode:regOnButtonClick(function()
        res.ShowDialog("Assets/CapstonesRes/Game/UI/Scene/Home/ActivationCode.prefab", "camera", false, true)
    end)
    self.videoReplay:regOnButtonClick(function()
        res.PushDialog("ui.controllers.videoReplay.VideoReplayCtrl")
    end)
    self.notice:regOnButtonClick(function()
        res.PushDialog("ui.controllers.login.NoticeCtrl", cache.getChannel())
    end)
    -- 客服入口
    self.service:regOnButtonClick(function ()
        luaevt.trig("Game_CustomerService")
    end)
    -- 登出入口
    self.out:regOnButtonClick(function ()
        luaevt.trig("Game_Logout")
    end)
    self.rank:regOnButtonClick(function()
        res.PushScene("ui.controllers.rank.RankMainCtrl")
    end)
    self.medal:regOnButtonClick(function()
        res.PushScene("ui.controllers.medal.MedalListCtrl")
    end)
    self.pasterBag:regOnButtonClick(function()
        res.PushScene("ui.controllers.pasterBag.PasterBagMainCtrl")
    end)
    self.medal:regOnButtonClick(function()
        res.PushScene("ui.controllers.medal.MedalListCtrl")
    end)
    DialogAnimation.Appear(self.transform, nil)
    self:UpdateFriendsRedPoint()
    EventSystem.AddEvent("ReqEventModel_friend", self, self.UpdateFriendsRedPoint)
    self:UpdateHonorRedPoint()
    EventSystem.AddEvent("ReqEventModel_honor", self, self.UpdateHonorRedPoint)
    self:UpdateItemRedPoint()
    EventSystem.AddEvent("ReqEventModel_item", self, self.UpdateItemRedPoint)
    self:UpdateMedalRedPoint()
    EventSystem.AddEvent("ReqEventModel_medal", self, self.UpdateMedalRedPoint)
    self:CheckMenuCondition()
end

function MenuView:CheckMenuCondition()
    local playerInfoModel = PlayerInfoModel.new()
    local playerLevel = playerInfoModel:GetLevel()
    
    local medalNeedLvl = LevelLimit["medal"].playerLevel
    local isMedalOpen = tobool(playerLevel >= medalNeedLvl)
    GameObjectHelper.FastSetActive(self.medal.gameObject, isMedalOpen)
    local isRankOpen = tobool(playerLevel >= LevelLimit["LeaderBoard"].playerLevel)
    GameObjectHelper.FastSetActive(self.rank.gameObject, isRankOpen)
end

function MenuView:Close(callback)
    DialogAnimation.Disappear(self.transform, nil, function()
        if type(self.closeDialog) == 'function' then
            self.closeDialog()
        end
    end)
end

function MenuView:UpdateFriendsRedPoint()
    local friendsNum = ReqEventModel.GetInfo("friend")
    local isShowRedPoint = tonumber(friendsNum) > 0
    GameObjectHelper.FastSetActive(self.friendsRedPoint, isShowRedPoint)
end

function MenuView:UpdateHonorRedPoint()
    GameObjectHelper.FastSetActive(self.honorRedPoint, tonumber(ReqEventModel.GetInfo("honor")) > 0 or tonumber(ReqEventModel.GetInfo("honorReward")) > 0)
end

function MenuView:UpdateItemRedPoint()
    GameObjectHelper.FastSetActive(self.itemRedPoint, tonumber(ReqEventModel.GetInfo("item")) > 0)
end

function MenuView:UpdateMedalRedPoint()
    GameObjectHelper.FastSetActive(self.medalRedPoint, tonumber(ReqEventModel.GetInfo("medal")) > 0)
end


function MenuView:onDestroy()
    EventSystem.RemoveEvent("ReqEventModel_friend", self, self.UpdateFriendsRedPoint)
    EventSystem.RemoveEvent("ReqEventModel_honor", self, self.UpdateHonorRedPoint)
    EventSystem.RemoveEvent("ReqEventModel_item", self, self.UpdateItemRedPoint)
    EventSystem.RemoveEvent("ReqEventModel_medal", self, self.UpdateMedalRedPoint)
end

return MenuView
