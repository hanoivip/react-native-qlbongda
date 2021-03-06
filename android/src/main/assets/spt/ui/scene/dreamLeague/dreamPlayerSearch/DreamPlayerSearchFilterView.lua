local UnityEngine = clr.UnityEngine
local Object = UnityEngine.Object
local DreamLeagueCardHelper = require("ui.scene.dreamLeague.DreamLeagueCardHelper")
local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local DreamPlayerSearchFilterView = class(unity.base)
function DreamPlayerSearchFilterView:ctor()
    self.btnConfirm = self.___ex.btnConfirm
    self.btnReset = self.___ex.btnReset
    self.close = self.___ex.close
    self.posArea = self.___ex.posArea
    self.qualityArea = self.___ex.qualityArea
    self.otherArea = self.___ex.otherArea
    self.posSearchMap = {}
    self.selectPos = {}
    self.qualitySearchMap = {}
    self.selectQuality = {}
    self.lockSearchMap = {}
    self.selectLock = {}
end

function DreamPlayerSearchFilterView:start()
    self.btnConfirm:regOnButtonClick(function()
        self:OnBtnConfirm()
    end)
    self.btnReset:regOnButtonClick(function()
        self:OnBtnReset()
    end)
    self.close:regOnButtonClick(function()
        self:Close()
    end)
    DialogAnimation.Appear(self.transform)
end

function DreamPlayerSearchFilterView:Close()
    DialogAnimation.Disappear(self.transform, nil, function()
        if type(self.closeDialog) == "function" then
            self.closeDialog()
        end
    end)
end

function DreamPlayerSearchFilterView:OnBtnConfirm()
    self:ClickConfirm()
    self:Close()
end

function DreamPlayerSearchFilterView:ClickConfirm()
    if self.clickConfirm then
        self.clickConfirm(self.selectPos, self.selectQuality, self.selectLock)
    end
end

function DreamPlayerSearchFilterView:OnBtnReset()
    if self.clickReset then
        self.clickReset()
    end
end

function DreamPlayerSearchFilterView:OnReset()
    for index, v in pairs(self.selectPos) do
        local currentPos = self.posSearchMap[index]
        currentPos:ChangeState(false)
    end
    for index, v in pairs(self.selectQuality) do
        local currentQuality = self.qualitySearchMap[index]
        currentQuality:ChangeState(false)
    end
    for index, v in pairs(self.selectLock) do
        local currentQuality = self.lockSearchMap[index]
        currentQuality:ChangeState(false)
    end

    self.selectPos = {}
    self.selectQuality = {}
    self.selectLock = {}
    self:ClickConfirm()
end

function DreamPlayerSearchFilterView:ClickQualitySearch(index)
    local currentItemBar = self.qualitySearchMap[index]
    if self.selectQuality[index] then 
        self.selectQuality[index] = nil
        currentItemBar:ChangeState(false)
    else
        self.selectQuality[index] = index
        currentItemBar:ChangeState(true)
    end
end

function DreamPlayerSearchFilterView:ClickPosSearch(index)
    local currentItemBar = self.posSearchMap[index]
    if self.selectPos[index] then 
        self.selectPos[index] = nil
        currentItemBar:ChangeState(false)
    else
        self.selectPos[index] = index
        currentItemBar:ChangeState(true)
    end
end

function DreamPlayerSearchFilterView:ClickLockSearch(index)
    local currentItemBar = self.lockSearchMap[index]
    if self.selectLock[index] then 
        self.selectLock[index] = nil
        currentItemBar:ChangeState(false)
    else
        self.selectLock[index] = index
        currentItemBar:ChangeState(true)
    end
end

function DreamPlayerSearchFilterView:InitView(dreamPlayerSearchModel)
    local searchPrefab = res.LoadRes("Assets/CapstonesRes/Game/UI/Scene/PlayerList/SearchBar.prefab")
    self:InitPositionView(searchPrefab)
    self:InitQualityView(searchPrefab)
    self:InitLockView(searchPrefab)
end

function DreamPlayerSearchFilterView:InitPositionView(searchPrefab)
    local posType = DreamLeagueCardHelper.CardPositionType
    for i = 1, table.nums(posType) do
        local searchObject = Object.Instantiate(searchPrefab)
        local spt = res.GetLuaScript(searchObject)
        searchObject.transform:SetParent(self.posArea, false)
        local desc = posType[i]
        spt:InitView(desc, true)
        spt.clickSearch = function() self:ClickPosSearch(i) end
        self.posSearchMap[i] = spt
    end
end

function DreamPlayerSearchFilterView:InitQualityView(searchPrefab)
    local qualitySign = DreamLeagueCardHelper.CardQualitySign
    for i = 1, #qualitySign do
        local searchObject = Object.Instantiate(searchPrefab)
        local spt = res.GetLuaScript(searchObject)
        searchObject.transform:SetParent(self.qualityArea, false)
        local desc = qualitySign[i]
        spt:InitView(desc, true)
        spt.clickSearch = function() self:ClickQualitySearch(i) end
        self.qualitySearchMap[i] = spt
    end
end

function DreamPlayerSearchFilterView:InitLockView(searchPrefab)
    local lockText = lang.trans("dream_unLock_card")
    local lockSign = {lockText}
    for i = 1, #lockSign do
        local searchObject = Object.Instantiate(searchPrefab)
        local spt = res.GetLuaScript(searchObject)
        searchObject.transform:SetParent(self.otherArea, false)
        local desc = lockSign[i]
        spt:InitView(desc, true)
        spt.clickSearch = function() self:ClickLockSearch(i) end
        self.lockSearchMap[i] = spt
    end
end

function DreamPlayerSearchFilterView:InitSelectBar()
    -- TODO  *************************************
    -- self.selectPos = self.cardIndexViewModel:GetViewPosition()
    -- if self.selectPos then 
    --     for k, v in pairs(self.selectPos) do
    --         self.posSearchMap[k]:ChangeState(true)
    --     end
    -- end
    -- self.selectQuality = self.cardIndexViewModel:GetViewQuality()
    -- if self.selectQuality then
    --     for k, v in pairs(self.selectQuality) do
    --         self.qualitySearchMap[k]:ChangeState(true)
    --     end
    -- end
end

function DreamPlayerSearchFilterView:OnEnterScene()
    -- EventSystem.AddEvent("PlayerSearch.OnNationClick", self, self.PlayerSearchOnNationSelect)
end

function DreamPlayerSearchFilterView:OnExitScene()
    -- EventSystem.RemoveEvent("DreamPlayerSearchFilterView.UpdateSkillSelectCount", self, self.UpdateSkillSelectCount)
end

return DreamPlayerSearchFilterView
