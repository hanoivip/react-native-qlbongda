local TimeFormater = require("ui.controllers.friends.TimeFormater")
local TeamLogoCtrl = require("ui.controllers.common.TeamLogoCtrl")
local PlayerDetailCtrl = require("ui.controllers.playerDetail.PlayerDetailCtrl")
local DialogManager = require("ui.control.manager.DialogManager")
local UnityEngine = clr.UnityEngine
local EventSystems = UnityEngine.EventSystems
local FriendsBlockItemView = class(unity.base)

function FriendsBlockItemView:ctor()
--------Start_Auto_Generate--------
    self.friendsBlockItemAnim = self.___ex.friendsBlockItemAnim
    self.nameTxt = self.___ex.nameTxt
    self.levelTxt = self.___ex.levelTxt
    self.powerTxt = self.___ex.powerTxt
    self.teamLogoImg = self.___ex.teamLogoImg
    self.guildInfoTxt = self.___ex.guildInfoTxt
    self.loginTimeTxt = self.___ex.loginTimeTxt
    self.viewDetailBtn = self.___ex.viewDetailBtn
    self.blockUndoBtn = self.___ex.blockUndoBtn
--------End_Auto_Generate----------
end

function FriendsBlockItemView:start()
    self.viewDetailBtn:regOnButtonClick(function()
        self:OnViewDetail()
    end)
    self.blockUndoBtn:regOnButtonClick(function()
        self:RemoveFriendsBlockByPid()
    end)
end

function FriendsBlockItemView:InitView(data)
    self.data = data
    self.nameTxt.text = data.name
    self.levelTxt.text = lang.trans("friends_manager_item_level", data.lvl)
    self.powerTxt.text = tostring(data.power)
    -- 公会以后再加
    self.guildInfoTxt.text = ""
    self.loginTimeTxt.text = TimeFormater.formatLoginTime(data.l_t)
    self:InitTeamLogo(self.teamLogoImg, data.logo)
end

-- 初始化玩家队标
function FriendsBlockItemView:InitTeamLogo(teamLogo, logoData)
    TeamLogoCtrl.BuildTeamLogo(teamLogo, logoData)
end

-- 查看玩家详情
function FriendsBlockItemView:OnViewDetail()
    PlayerDetailCtrl.ShowPlayerDetailView(function() return req.friendsDetail(self.data.pid, self.data.sid) end, self.data.pid, self.data.sid)
end

-- 解开对该玩家的屏蔽
function FriendsBlockItemView:RemoveFriendsBlockByPid()
    self:coroutine(function()
        local response = req.friendsBlock(self.data.pid, self.data.sid, false)
        if api.success(response) then
            local currentEventSystem = EventSystems.EventSystem.current
            currentEventSystem.enabled = false
            DialogManager.ShowToast(lang.trans("friends_block_undo_success"))
            self.friendsBlockItemAnim.SetTrigger("Remove")
            coroutine.yield(UnityEngine.WaitForSeconds(0.5))
            currentEventSystem.enabled = true
            EventSystem.SendEvent("FriendsBlock_Remove", self.data.pid)
        end
    end)
end

return FriendsBlockItemView
