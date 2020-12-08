local DynamicLoaded = require("ui.control.utils.DynamicLoaded")
local GameObjectHelper = require("ui.common.GameObjectHelper")
local EventSystem = require("EventSystem")
local ArenaInfoBarView = class(DynamicLoaded)

local tostring = tostring
local tonumber = tonumber
local type = type

function ArenaInfoBarView:ctor()
    self.btnBack = self.___ex.btnBack
    self.silverText = self.___ex.silverText
    self.goldText = self.___ex.goldText
    self.blackGoldText = self.___ex.blackGoldText
    self.platinaText = self.___ex.platinaText
    self.peakChampionText = self.___ex.peakChampionText
end

function ArenaInfoBarView:start()
    self:RegModelHandler()
    self.btnBack:regOnButtonClick(function()
        self:OnBtnBackClick()
    end)
end

function ArenaInfoBarView:OnBtnBackClick()
    if self.clickBack then
        self.clickBack()
    end
end

function ArenaInfoBarView:InitView(arenaModel)
    self.arenaModel = arenaModel
    self:EventModelInfo(arenaModel)
end

function ArenaInfoBarView:RegModelHandler()
    EventSystem.AddEvent("ArenaModelInfo", self, self.EventModelInfo)
end

function ArenaInfoBarView:RemoveModelHandler()
    EventSystem.RemoveEvent("ArenaModelInfo", self, self.EventModelInfo)
end

function ArenaInfoBarView:EventModelInfo(arenaModel)
    self.silverText.text = tostring(arenaModel:GetSilverMoney())
    self.goldText.text = tostring(arenaModel:GetGoldMoney())
    self.blackGoldText.text = tostring(arenaModel:GetBlackGoldMoney())
    self.platinaText.text = tostring(arenaModel:GetPlatinaMoney())
    self.peakChampionText.text = tostring(arenaModel:GetPeakChampionMoney())
end

function ArenaInfoBarView:onDestroy()
    self:RemoveModelHandler()
end

return ArenaInfoBarView

