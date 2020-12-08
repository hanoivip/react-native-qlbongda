local EventSystem = require("EventSystem")
local ReqEventModel = require("ui.models.event.ReqEventModel")
local MenuType = require("ui.models.friends.MenuType")

local FacebookBoardView = class(unity.base)

function FacebookBoardView:ctor()
    self.btnAddAll = self.___ex.btnAddAll
    self.friendsNumber = self.___ex.friendsNumber
    self.friendsApplyCount = self.___ex.friendsApplyCount
    self.scrollView = self.___ex.scrollView
    self.friendText = self.___ex.friendText
end

function FacebookBoardView:start()
    self.btnAddAll:regOnButtonClick(function()
        if self.onAddAll then
            self.onAddAll()
        end
    end)
end

function FacebookBoardView:InitView(mainModel)
    self.friendsMainModel = mainModel
    self.friendsNumber.text = lang.trans("friends_friendsNumber", self.friendsMainModel:GetFriendsCount(), self.friendsMainModel:GetFriendsLimit())
end

function FacebookBoardView:EventUpdateSearchList()
    if self.updateSearchListCallBack then
        self.updateSearchListCallBack()
    end
end

function FacebookBoardView:EventUpdateFriendsCount(count)
    if self.friendsMainModel then
        self.friendsNumber.text = lang.trans("friends_friendsNumber", count, self.friendsMainModel:GetFriendsLimit())
    end
end

function FacebookBoardView:OnFacebookListComplete(action)
    if self.facebookList then
        self.facebookList(action)
    end
end

function FacebookBoardView:EnterScene()
    EventSystem.AddEvent("FacebookModel_UpdateSearchList", self, self.EventUpdateSearchList)
    EventSystem.AddEvent("FriendsMainModel_UpdateFriendsCount", self, self.EventUpdateFriendsCount)
    luaevt.reg("FBFriendList_OnComplete", function(cate, action)
        self:OnFacebookListComplete(action) 
    end)
end

function FacebookBoardView:ExitScene()
    EventSystem.RemoveEvent("FacebookModel_UpdateSearchList", self, self.EventUpdateSearchList)
    EventSystem.RemoveEvent("FriendsMainModel_UpdateFriendsCount", self, self.EventUpdateFriendsCount)
    luaevt.unreg("FBFriendList_OnComplete")
end

return FacebookBoardView