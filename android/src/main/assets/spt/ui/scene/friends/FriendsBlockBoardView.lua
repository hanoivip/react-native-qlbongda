local GameObjectHelper = require("ui.common.GameObjectHelper")
local FriendsBlockBoardView = class(unity.base)

function FriendsBlockBoardView:ctor()
--------Start_Auto_Generate--------
    self.blockNumberTxt = self.___ex.blockNumberTxt
    self.listSpt = self.___ex.listSpt
    self.emptyTipGo = self.___ex.emptyTipGo
--------End_Auto_Generate----------
end

function FriendsBlockBoardView:start()
end

function FriendsBlockBoardView:InitView(model)
    self.friendsBlockModel = model
    self:UpdateBlockList()
end

function FriendsBlockBoardView:RemoveFriendsBlockByPid(pid)
    if not self.friendsBlockModel then
        return
    end
    self.friendsBlockModel:RemoveFriendsBlockByPid(pid)
end

function FriendsBlockBoardView:UpdateBlockList()
    local blockNum = self.friendsBlockModel:GetBlockNum()
    local blockNumLimit = self.friendsBlockModel:GetBlockNumLimit()
    self.blockNumberTxt.text = lang.transstr("friends_block_list_tip", blockNum, blockNumLimit)
    local blockList = self.friendsBlockModel:GetBlockList()
    self.listSpt:InitView(blockList)
    GameObjectHelper.FastSetActive(self.emptyTipGo, table.nums(blockList) == 0)
end

function FriendsBlockBoardView:EnterScene()
    EventSystem.AddEvent("FriendsBlock_Remove", self, self.RemoveFriendsBlockByPid)
    EventSystem.AddEvent("FriendsBlock_UpdateView", self, self.UpdateBlockList)
end

function FriendsBlockBoardView:ExitScene()
    EventSystem.RemoveEvent("FriendsBlock_Remove", self, self.RemoveFriendsBlockByPid)
    EventSystem.RemoveEvent("FriendsBlock_UpdateView", self, self.UpdateBlockList)
end

return FriendsBlockBoardView
