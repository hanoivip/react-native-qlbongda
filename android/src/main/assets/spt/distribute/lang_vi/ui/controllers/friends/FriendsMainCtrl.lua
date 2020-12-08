local BaseCtrl = require("ui.controllers.BaseCtrl")
local InfoBarCtrl = require("ui.controllers.common.InfoBarCtrl")
local MenuType = require("ui.models.friends.MenuType")
local FriendsMessagesCtrl = require("ui.controllers.friends.FriendsMessagesCtrl")
local FriendsManagerCtrl = require("ui.controllers.friends.FriendsManagerCtrl")
local FriendsAddCtrl = require("ui.controllers.friends.FriendsAddCtrl")
local FacebookCtrl = require("ui.controllers.friends.FacebookCtrl")
local FriendsMainModel = require("ui.models.friends.FriendsMainModel")
local PlayerInfoModel = require("ui.models.PlayerInfoModel")

local FriendsMainCtrl = class(BaseCtrl)

FriendsMainCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/Friends/FriendsCanvas.prefab"

function FriendsMainCtrl:Init(currentMenu, friendsMainModel)
    self.friendsMainModel = friendsMainModel or FriendsMainModel.new()
    self.friendsManagerCtrl = FriendsManagerCtrl.new(res.GetLuaScript(self.view:GetFriendsBoard(MenuType.MANAGER)))
    self.friendsMessagesCtrl = FriendsMessagesCtrl.new(res.GetLuaScript(self.view:GetFriendsBoard(MenuType.MESSAGES)))
    self.friendsAddCtrl = FriendsAddCtrl.new(res.GetLuaScript(self.view:GetFriendsBoard(MenuType.ADD)))
    self.facebookCtrl = FacebookCtrl.new(res.GetLuaScript(self.view:GetFriendsBoard(MenuType.FaceBook)))
end

function FriendsMainCtrl:Refresh(currentMenu)
    FriendsMainCtrl.super.Refresh(self)
    self.friendsMainModel:SetCurrentMenu(currentMenu)
    self:InitView()
end

function FriendsMainCtrl:GetStatusData()
    return self.friendsMainModel:GetCurrentMenu(), self.friendsMainModel
end

function FriendsMainCtrl:OnEnterScene()
    self.view:EnterScene()
    self.friendsManagerCtrl:OnEnterScene()
    self.friendsMessagesCtrl:OnEnterScene()
    self.friendsAddCtrl:OnEnterScene()
    self.facebookCtrl:OnEnterScene()
end

function FriendsMainCtrl:OnExitScene()
    self.view:ExitScene()
    self.friendsManagerCtrl:OnExitScene()
    self.friendsMessagesCtrl:OnExitScene()
    self.friendsAddCtrl:OnExitScene()
    self.facebookCtrl:OnExitScene()
end

function FriendsMainCtrl:InitView()
    self.view.clickMenu = function(index) self:OnMenuClick(index) end
    self.view.clickGacha = function() self:OnClickGacha() end

    self.view:RegOnDynamicLoad(function(child)
        InfoBarCtrl.new(child, self)
    end)

    self.view:InitView(self.friendsMainModel)
end

function FriendsMainCtrl:OnMenuClick(index)
    local menuType = self.friendsMainModel:GetCurrentMenu()

    self.friendsMainModel:SetCurrentMenu(index)
    if index == MenuType.MESSAGES then
        self:OnFriendsMessages()
    elseif index == MenuType.MANAGER then
        self:OnFriendsManager()
    elseif index == MenuType.ADD then
        self:OnFriendsAdd()
    elseif index == MenuType.FaceBook then
        if menuType ~= index then 
            self:OnFaceBookMessages() 
        end
    end
    self.view:SwitchFriendsTab(self.friendsMainModel)
end

function FriendsMainCtrl:OnClickGacha()
    res.PushSceneImmediate("ui.controllers.store.StoreCtrl", require("ui.models.store.StoreModel").MenuTags.GACHA, nil, nil, nil, nil, "C1")
end

function FriendsMainCtrl:OnFriendsManager()
    clr.coroutine(function()
        local respone = req.friendsListFriends()
        if api.success(respone) then
            local friendsManagerModel = self.friendsMainModel:GetFriendsManagerModel()
            friendsManagerModel:InitWithProtocol(respone.val)
            self.friendsManagerCtrl:InitView(self.friendsMainModel, friendsManagerModel)
        end
    end)
end

function FriendsMainCtrl:OnFriendsMessages()
    local friendsMessagesModel = self.friendsMainModel:GetFriendsMessagesModel()
    self.friendsMessagesCtrl:InitView(self.friendsMainModel, friendsMessagesModel)
end

function FriendsMainCtrl:OnFriendsAdd()
    clr.coroutine(function()
        local respone = req.friendsFind("", PlayerInfoModel.new():GetSID())
        if api.success(respone) then
            local friendsAddModel = self.friendsMainModel:GetFriendsAddModel()
            friendsAddModel:InitWithProtocol(respone.val)
            self.friendsAddCtrl:InitView(self.friendsMainModel, friendsAddModel)
        end
    end)
end

function FriendsMainCtrl:OnFaceBookMessages()
    self.facebookCtrl:OnFaceBookMessages(self.friendsMainModel)
end

return FriendsMainCtrl