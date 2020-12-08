local Model = require("ui.models.Model")
local FriendsMessagesModel = require("ui.models.friends.FriendsMessagesModel")
local FriendsManagerModel = require("ui.models.friends.FriendsManagerModel")
local FriendsAddModel = require("ui.models.friends.FriendsAddModel")
local FacebookModel = require("ui.models.friends.FacebookModel")
local MenuType = require("ui.models.friends.MenuType")
local EventSystem = require("EventSystem")

local FriendsMainModel = class(Model)

function FriendsMainModel:ctor()
    FriendsMainModel.super.ctor(self)
    self:Init()
end

function FriendsMainModel:Init()
    self.friendsMessagesModel = FriendsMessagesModel.new()
    self.friendsManagerModel = FriendsManagerModel.new()
    self.friendsAddModel = FriendsAddModel.new()
    self.facebookModel = FacebookModel.new()
    self.currentMenu = MenuType.MESSAGES
end

function FriendsMainModel:GetFriendsMessagesModel()
    return self.friendsMessagesModel
end

function FriendsMainModel:GetFriendsManagerModel()
    return self.friendsManagerModel
end

function FriendsMainModel:GetFriendsAddModel()
    return self.friendsAddModel
end

function FriendsMainModel:GetFacebookModel()
    return self.facebookModel
end

function FriendsMainModel:GetCurrentMenu()
    return self.currentMenu or -1
end

function FriendsMainModel:SetCurrentMenu(curMenu)
    self.currentMenu = curMenu
end

function FriendsMainModel:SetFriendsCountAndLimit(count, limit)
    self.friendsCount = count
    self.friendsLimit = limit
end

function FriendsMainModel:UpdateFriendsCount(count)
    self.friendsCount = count
    EventSystem.SendEvent("FriendsMainModel_UpdateFriendsCount", self.friendsCount)
end

function FriendsMainModel:GetFriendsCount()
    return self.friendsCount or 0
end

function FriendsMainModel:GetFriendsLimit()
    return self.friendsLimit
end

function FriendsMainModel:AddOneFriend()
    self:UpdateFriendsCount(self.friendsCount + 1)
end

return FriendsMainModel