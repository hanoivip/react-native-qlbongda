local TeamLogoCtrl = require("ui.controllers.common.TeamLogoCtrl")
local FriendsApplyCtrl = require("ui.controllers.friends.FriendsApplyCtrl")
local DialogManager = require("ui.control.manager.DialogManager")
local PlayerDetailCtrl = require("ui.controllers.playerDetail.PlayerDetailCtrl")
local MenuType = require("ui.models.friends.MenuType")
local PlayerInfoModel = require("ui.models.PlayerInfoModel")

local FacebookCtrl = class()

function FacebookCtrl:ctor(view)
    self.facebookView = view
    self.facebookView.onAddAll = function() self:OnAddFriend() end
    self.facebookView.updateSearchListCallBack = function() self:UpdateSearchListCallBack() end
    self.facebookView.facebookList = function(socialData) self:FacebookList(socialData) end
    self:CreateItemList()
end

function FacebookCtrl:InitView(mainModel, model)
    self.friendsMainModel = mainModel
    self.friendsAddModel = model
    self.facebookView:InitView(self.friendsMainModel)
    self:RefreshScrollView()
end

function FacebookCtrl:FacebookList(socialData)
    local facebookModel = self.friendsMainModel:GetFacebookModel()
    facebookModel:SetSocialData(socialData)
    local socialMap = facebookModel:GetSocialData()
    local keys = table.keys(socialMap)
    if next(keys) then 
        clr.coroutine(function()
            local respone = req.facebookList(keys)
            if api.success(respone) then
                facebookModel:InitWithProtocol(respone.val)
                self:InitView(self.friendsMainModel, facebookModel)
            end
        end)
    end
end

function FacebookCtrl:OnFaceBookMessages(friendsMainModel)
    self.friendsMainModel = friendsMainModel
    luaevt.trig("SDK_FBFriendList")
end

function FacebookCtrl:CreateItemList()
    self.facebookView.scrollView.onScrollCreateItem = function(index)
        local obj, spt = res.Instantiate("Assets/CapstonesRes/Game/UI/Scene/Friends/FacebookItem.prefab")
        return obj, spt
    end
    self.facebookView.scrollView.onScrollResetItem = function(spt, index)
        local searchData = self.facebookView.scrollView.itemDatas[index]
        spt.onInitTeamLogo = function() self:OnInitTeamLogo(spt:GetTeamLogoGameObject(), searchData.logo) end
        spt.onViewDetail = function() self:OnViewDetail(searchData.pid, searchData.sid) end
        spt:InitView(searchData, self.friendsAddModel)
        self.facebookView.scrollView:updateItemIndex(spt, index)
    end
end

function FacebookCtrl:RefreshScrollView()
    local searchList = self.friendsAddModel:GetSearchList()
    self.facebookView.scrollView:clearData()
    for i = 1, #searchList do
        table.insert(self.facebookView.scrollView.itemDatas, searchList[i])
    end
    self.facebookView.scrollView:refresh()
end

function FacebookCtrl:OnViewDetail(pid, sid)
    PlayerDetailCtrl.ShowPlayerDetailView(function() return req.friendsDetail(pid, sid) end, pid, sid)
end

function FacebookCtrl:OnAddFriend()
    self:OnFaceBookInviteFriend()
end

function FacebookCtrl:OnFaceBookInviteFriend()
    luaevt.trig("SDK_InviteFriendFB", "InviteFriend", "message")
end

function FacebookCtrl:OnInitTeamLogo(teamLogo, logoData)
    TeamLogoCtrl.BuildTeamLogo(teamLogo, logoData)
end

function FacebookCtrl:UpdateSearchListCallBack()
    self:RefreshScrollView()
end

function FacebookCtrl:OnEnterScene()
    self.facebookView:EnterScene()
end

function FacebookCtrl:OnExitScene()
    self.facebookView:ExitScene()
end

return FacebookCtrl