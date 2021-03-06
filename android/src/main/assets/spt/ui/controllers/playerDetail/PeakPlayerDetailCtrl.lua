local UnityEngine = clr.UnityEngine
local Object = UnityEngine.Object
local WaitForSeconds = UnityEngine.WaitForSeconds
local BaseCtrl = require("ui.controllers.BaseCtrl")
local PlayerDetailModel = require("ui.models.playerDetail.PeakPlayerDetailModel")
local FormationConstants = require("ui.scene.formation.FormationConstants")
local MatchLoader = require("coregame.MatchLoader")
local EventSystem = require("EventSystem")
local CardBuilder = require("ui.common.card.CardBuilder")
local OtherPlayerTeamsModel = require("ui.models.OtherPlayerTeamsModel")
local DialogManager = require("ui.control.manager.DialogManager")
local ChatMainModel = require("ui.models.chat.ChatMainModel")
local ArenaModel = require("ui.models.arena.ArenaModel")
local GuildDetailModel = require("ui.models.guild.GuildDetailModel")
local HonorPalaceModel = require("ui.models.honorPalace.HonorPalaceModel")
local PlayerInfoModel = require("ui.models.PlayerInfoModel")
local CHAT_TYPE = require("ui.controllers.chat.CHAT_TYPE")
local ChatTipDialogModel = require("ui.models.chat.ChatTipDialogModel")

local PeakPlayerDetailCtrl = class(BaseCtrl)
PeakPlayerDetailCtrl.viewPath = "Assets/CapstonesRes/Game/UI/Scene/PlayerDetail/PeakPlayerDetail.prefab"

PeakPlayerDetailCtrl.dialogStatus = {
    touchClose = false,
    withShadow = true,
    unblockRaycast = false,
}

function PeakPlayerDetailCtrl:Init()
    self.playerDetailModel = PlayerDetailModel.new()
    self.chatMainModel = ChatMainModel.new()
    self.arenaModel = ArenaModel.new()
    self.guildDetailModel = nil
    self.honorPalaceModel = HonorPalaceModel.new()
    self.playerInfoModel = PlayerInfoModel.new()
end

function PeakPlayerDetailCtrl:Refresh(data, pid, sid, hideFunBtn, showIndex, friendManagerModel, specialEventsMatchId, arenaType)
    PeakPlayerDetailCtrl.super.Refresh(self)
    self.data = data
    self.pid = pid
    self.sid = sid
    self.showIndex = showIndex
    self.friendManagerModel = friendManagerModel
    self.specialEventsMatchId = specialEventsMatchId
    self.playerDetailModel:InitWithProtocol(data)
    self.playerDetailModel.specialEventsMatchId = specialEventsMatchId
    self.playerDetailModel:SetArenaType(arenaType)
    local guild = self.playerDetailModel:GetGuild()
    local size = guild and table.nums(guild) or 0
    -- 如果没有公会，就不用创建了
    if size ~= 0 then
        self.guildDetailModel = GuildDetailModel.new()
        self.guildDetailModel:InitWithProtrol(guild)
    end
    local player = data.player
    local honorData = {
        honor = player.honor,
        list = player.list
    }
    self.honorPalaceModel:InitWithProtocol(honorData)

    local sender = {
        authority = 1,
        logo = self.playerDetailModel:GetTeamLogo(),
        lvl = self.playerDetailModel:GetPlayerLevel(),
        name = self.playerDetailModel:GetPlayerName(),
        pid = pid,
        sid = sid
    }
    self.chatDialogModel = ChatTipDialogModel.new(sender)
    self:InitView()
end

function PeakPlayerDetailCtrl:InitView()
    -- 注册事件
    self.view.onAddFriend = function()
        local pidTable = {{pid = self.pid, sid = tostring(self.sid)}}
        self:OnAddFriend(pidTable)
    end

    self.view.onPrivateChat = function()
        if self.playerDetailModel:GetIsUseBlock() then
            DialogManager.ShowToastByLang("friends_block_chat_disable")
            return
        end
        clr.coroutine(function()
            self.view:Close()
            coroutine.yield(UnityEngine.WaitForEndOfFrame())
            local isShow = cache.getIsChatViewOpen()
            self.chatMainModel:SetCurrentPlayerPid(self.pid, self.sid)
            -- 如果是从聊天界面打开，就不要再打开聊天界面了
            if not isShow then
                cache.setChatSideData(self.chatDialogModel)
                res.PushDialog("ui.controllers.chat.ChatMainCtrl", CHAT_TYPE.PLAYER)
            else
                EventSystem.SendEvent("ChatTipDialog_SideChat", self.chatDialogModel)
            end
        end)
    end

    self.view.onStartMatch = function() self:OnStartMatch() end
    self.view.onDeleteFriend = function () self:OnDeleteFriend() end
    self.view.onApplyGuild = function() self:JoinGuild() end
    self.view.onFriendsBlock = function() self:OnFriendsBlock() end

    local sameGuild = false
    local friendGuildID = self.playerDetailModel:GetGuildID()
    local myGuild = self.playerInfoModel:GetGuild()
    if myGuild then
        if myGuild.gid == friendGuildID then
            sameGuild = true
        end
    end
    sameGuild = sameGuild or (self.playerInfoModel:GetSID() ~= self.sid)
    local isMe = false
    if self.pid == self.playerInfoModel:GetID() then
        isMe = true
    end
    self.playerDetailModel:SetIsMe(isMe)
    self.view:InitView(self.playerDetailModel, self.guildDetailModel, self.honorPalaceModel, sameGuild, isMe, self.showIndex, self.hideFunBtn, self.specialEventsMatchId)
end

-- 恢复UI时，传入的参数
function PeakPlayerDetailCtrl:GetStatusData()
    return self.data, self.pid, self.sid, self.hideFunBtn, self.playerDetailModel:GetIndex(), self.friendManagerModel, self.specialEventsMatchId, self.playerDetailModel:GetArenaType()
end

function PeakPlayerDetailCtrl:OnEnterScene()
    EventSystem.AddEvent("ClickPlayerCardCircle", self, self.OnCardClick)
end

function PeakPlayerDetailCtrl:OnExitScene()
    EventSystem.RemoveEvent("ClickPlayerCardCircle", self, self.OnCardClick)
end

function PeakPlayerDetailCtrl:OnStartMatch()
    clr.coroutine(function()
        local response = req.friendsMatch(self.pid, self.sid)
        if api.success(response) then
            MatchLoader.startMatch(response.val)
        end
    end)
end

-- 删除好友确认面板
function PeakPlayerDetailCtrl:OnDeleteFriend()
    DialogManager.ShowConfirmPop(lang.trans("friends_manager_item_deleteFriend"), lang.trans("friends_delete_tip", self.playerDetailModel:GetPlayerName()), function ()
        self:OnDelFriend(self.pid, self.sid)
        self.view:Close()
    end, nil)
end

-- 点击球员
function PeakPlayerDetailCtrl:OnCardClick(pcId)
    local cids = self.playerDetailModel:GetChemicalCids()
    local otherPlayerTeamsModel = self.playerDetailModel:GetOtherPlayerTeamsModel()
    local playerCardModelsMap = self.playerDetailModel:GetOtherPlayerCardsMapModel()
    local otherLegendCardsMapModel = self.playerDetailModel:GetOtherPlayerLegendCardModel()
    local currentModel = CardBuilder.GetOtherCardModel(pcId, cids, playerCardModelsMap, otherPlayerTeamsModel, otherLegendCardsMapModel)
    res.PushScene("ui.controllers.cardDetail.CardDetailMainCtrl", {pcId}, 1, currentModel)
end

-- 入口
-- @param hideFunBtn 是否隐藏右侧功能按钮 true:隐藏 不传递就不隐藏（是否同服）
-- @param showIndex 打开面板后显示那个页面,不传递默认打开第一个页面
-- @param arenaType 冠军联赛战区信
function PeakPlayerDetailCtrl.ShowPlayerDetailView(reqPlayerDetailFunc, pid, sid, hideFunBtn, showIndex, friendManagerModel, specialEventsMatchId, arenaType)
    if type(reqPlayerDetailFunc) == "function" then
        clr.coroutine(function()
            local response = reqPlayerDetailFunc()
            if api.success(response) then
                local data = response.val
                res.PushDialog("ui.controllers.playerDetail.PeakPlayerDetailCtrl", data, pid, sid, hideFunBtn, showIndex, friendManagerModel, specialEventsMatchId, arenaType)
            end
        end)
    end
end

-- 添加好友
function PeakPlayerDetailCtrl:OnAddFriend(pidTable)
    clr.coroutine(function()
        local response = req.friendsRequest({pidArray = pidTable})
        if api.success(response) then
            local data = response.val
            if data["ok"] then
                DialogManager.ShowToastByLang("friends_applySendHint")
            end
        end
    end)
end

-- 删除好友
function PeakPlayerDetailCtrl:OnDelFriend(pid, sid)
    clr.coroutine(function()
        local response = req.friendsRemove(pid, sid)
        if api.success(response) then
            local data = response.val
            local playerInfoModel = PlayerInfoModel.new()
            local friendNum = playerInfoModel:GetFriendsCount() - 1
            playerInfoModel:SetFriendsCount(friendNum)
            if self.friendManagerModel then
                self.friendManagerModel:UpdateFriendsList(pid)
            end
        end
    end)
end

-- 申请加入公会
function PeakPlayerDetailCtrl:JoinGuild()
    if self.guildDetailModel == nil then
        return
    end
    clr.coroutine(function()
        local response = req.sendGuildRequest(self.guildDetailModel:GetID())
        if api.success(response) then
            local data = response.val
            local isAuto = self.guildDetailModel:GetisAutoRequest()
            if isAuto then
                local response2 = req.guildIndex()
                if api.success(response2) then
                    local data2 = response2.val
                    if data2.base.isExsit == true then
                        res.PushScene("ui.controllers.guild.GuildHomeCtrl", data2) 
                    end
                end
            else
                DialogManager.ShowToastByLang("guild_joinSuccess")
            end
        end
    end)
end

-- 屏蔽玩家发言
function PeakPlayerDetailCtrl:OnFriendsBlock()
    if self.playerDetailModel:GetBlockRemainCnt() < 1 then
        DialogManager.ShowToastByLang("friends_block_limit")
        return
    end
    local function BlockConfirm(pid, cid, isBlock)
        clr.coroutine(function()
            local response = req.friendsBlock(pid, cid, isBlock)
            if api.success(response) then
                local blockState = response.val.isBlock
                self.playerDetailModel:SetIsBlock(blockState)
                self.view:SetFriendsBlockText(blockState)
                if blockState then
                    DialogManager.ShowToast(lang.trans("friends_block_success"))
                else
                    DialogManager.ShowToast(lang.trans("friends_block_undo_success"))
                end
            end
        end)
    end
    local isBlock = self.playerDetailModel:GetIsBlock()
    local title = lang.trans("tips")
    local msg = lang.trans("friends_block_confirm")
    if isBlock then
        msg = lang.trans("friends_block_undo_confirm")
    end
    DialogManager.ShowMessageBox(title, msg, function() BlockConfirm(self.pid, self.sid, not isBlock) end, nil, nil)
end

return PeakPlayerDetailCtrl