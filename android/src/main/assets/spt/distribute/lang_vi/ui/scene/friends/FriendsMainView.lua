local MenuType = require("ui.models.friends.MenuType")
local ReqEventModel = require("ui.models.event.ReqEventModel")
local PlayerInfoModel = require("ui.models.PlayerInfoModel")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local EventSystem = require("EventSystem")

local FriendsMainView = class(unity.base)

local MenuMap = {
    [MenuType.MESSAGES] = "messages",
    [MenuType.MANAGER] = "manager",
    [MenuType.ADD] = "add",
    [MenuType.FaceBook] = "facebook",
}

function FriendsMainView:ctor()
    self.infoBarDynParent = self.___ex.infoBar
    self.menuButtonGroup = self.___ex.menuButtonGroup
    self.friendsManagerBoard = self.___ex.friendsManagerBoard
    self.friendsMessagesBoard = self.___ex.friendsMessagesBoard
    self.friendsAddBoard = self.___ex.friendsAddBoard
    self.facebookBoard = self.___ex.facebookBoard
    self.friendsMessagesRedPoint = self.___ex.friendsMessagesRedPoint
    self.friendsAddRedPoint = self.___ex.friendsAddRedPoint
    self.friendsManagerRedPoint = self.___ex.friendsManagerRedPoint
    self.friendshipNmuber = self.___ex.friendshipNmuber
    self.friendsAnim = self.___ex.friendsAnim
    self.btnGacha = self.___ex.btnGacha
end

function FriendsMainView:start()
    local menuTransform = self.menuButtonGroup.transform
    for i = 1, menuTransform.childCount do
        local btnObject = menuTransform:GetChild(i - 1).gameObject
        btnObject:GetComponent(clr.CapsUnityLuaBehav):regOnButtonClick(function()
            self:OnMenuClick(i)
        end)
    end

    self.btnGacha:regOnButtonClick(function()
        if self.clickGacha then
            self.clickGacha()
        end
    end)

    self:IsShowFriendsAddRedPoint()
    self:IsShowFriendsMessagesRedPoint()
    self:IsShowManagerRedPoint()
end

function FriendsMainView:InitView(model)
    local playerInfoModel = PlayerInfoModel.new()
    self.friendshipNmuber.text = "x" .. tostring(playerInfoModel:GetFriendshipPoint())
    local menuType = model:GetCurrentMenu()
    self.menuButtonGroup:selectMenuItem(MenuMap[menuType])
    self:OnMenuClick(menuType)
end

function FriendsMainView:RegOnDynamicLoad(func)
    self.infoBarDynParent:RegOnDynamicLoad(func)
end

function FriendsMainView:OnMenuClick(index)
    if self.clickMenu then
        self.clickMenu(index)
    end
end

function FriendsMainView:SwitchFriendsTab(model)
    local menuType = model:GetCurrentMenu()
    GameObjectHelper.FastSetActive(self.friendsMessagesBoard, menuType == MenuType.MESSAGES)
    GameObjectHelper.FastSetActive(self.friendsManagerBoard, menuType == MenuType.MANAGER)
    GameObjectHelper.FastSetActive(self.friendsAddBoard, menuType == MenuType.ADD)
    GameObjectHelper.FastSetActive(self.facebookBoard, menuType == MenuType.FaceBook)
end

function FriendsMainView:GetFriendsBoard(menuType)
    if menuType == MenuType.MESSAGES then
        return self.friendsMessagesBoard
    elseif menuType == MenuType.MANAGER then
        return self.friendsManagerBoard
    elseif menuType == MenuType.ADD then
        return self.friendsAddBoard
    elseif menuType == MenuType.FaceBook then
        return self.facebookBoard
    end
end

function FriendsMainView:IsShowFriendsAddRedPoint()
    local friendsApplyCount = ReqEventModel.GetInfo("friendReq")
    GameObjectHelper.FastSetActive(self.friendsAddRedPoint, tonumber(friendsApplyCount) > 0)
end

function FriendsMainView:IsShowFriendsMessagesRedPoint()
    local friendsReceiveStrengthCount = ReqEventModel.GetInfo("friendSp")
    local friendsMatchRecordCount = ReqEventModel.GetInfo("friendMatch")
    local showRedPoint = tonumber(friendsReceiveStrengthCount) > 0 or tonumber(friendsMatchRecordCount) > 0
    GameObjectHelper.FastSetActive(self.friendsMessagesRedPoint, showRedPoint)
end

function FriendsMainView:IsShowManagerRedPoint()
    local acpCount = ReqEventModel.GetInfo("friendAcp")
    GameObjectHelper.FastSetActive(self.friendsManagerRedPoint, tonumber(acpCount) > 0)
end

function FriendsMainView:OnPlayerInfoChanged(playerInfoModel)
    self.friendshipNmuber.text = "x" .. tostring(playerInfoModel:GetFriendshipPoint())
    self.friendsAnim:Play("FriendPointChanged")
end

function FriendsMainView:EnterScene()
    EventSystem.AddEvent("ReqEventModel_friendReq", self, self.IsShowFriendsAddRedPoint)
    EventSystem.AddEvent("ReqEventModel_friendSp", self, self.IsShowFriendsMessagesRedPoint)
    EventSystem.AddEvent("ReqEventModel_friendMatch", self, self.IsShowFriendsMessagesRedPoint)
    EventSystem.AddEvent("ReqEventModel_friendAcp", self, self.IsShowManagerRedPoint)
    EventSystem.AddEvent("FriendsShipChanged", self, self.OnPlayerInfoChanged)
end

function FriendsMainView:ExitScene()
    EventSystem.RemoveEvent("ReqEventModel_friendReq", self, self.IsShowFriendsAddRedPoint)
    EventSystem.RemoveEvent("ReqEventModel_friendSp", self, self.IsShowFriendsMessagesRedPoint)
    EventSystem.RemoveEvent("ReqEventModel_friendMatch", self, self.IsShowFriendsMessagesRedPoint)
    EventSystem.RemoveEvent("ReqEventModel_friendAcp", self, self.IsShowManagerRedPoint)
    EventSystem.RemoveEvent("FriendsShipChanged", self, self.OnPlayerInfoChanged)
end

return FriendsMainView
