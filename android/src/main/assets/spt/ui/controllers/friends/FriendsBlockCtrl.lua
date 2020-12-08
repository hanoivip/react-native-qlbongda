local FriendsBlockCtrl = class()

function FriendsBlockCtrl:ctor(view)
    self.friendsBlockView = view
end

function FriendsBlockCtrl:InitView(model)
    self.friendsBlockModel = model
    self.friendsBlockView:InitView(self.friendsBlockModel)
end

-- 刷新屏蔽列表
function FriendsBlockCtrl:UpdateList()
    if not self.friendsBlockModel then
        return
    end
    clr.coroutine(function()
        local response = req.friendsBlockList()
        if api.success(response) then
            self.friendsBlockModel:InitWithProtocol(response.val)
            self.friendsBlockView:InitView(self.friendsBlockModel)
        end
    end)
end

function FriendsBlockCtrl:OnEnterScene()
    self.friendsBlockView:EnterScene()
    EventSystem.AddEvent("FriendsBlock_Update", self, self.UpdateList)
end

function FriendsBlockCtrl:OnExitScene()
    self.friendsBlockView:ExitScene()
    EventSystem.RemoveEvent("FriendsBlock_Update", self, self.UpdateList)
end

return FriendsBlockCtrl