local MallView = class(unity.base)
local GameObjectHelper = require("ui.common.GameObjectHelper")

function MallView:ctor()
    self.menuScript = self.___ex.menuScript
    self.pageArea = self.___ex.pageArea
    EventSystem.AddEvent("VIPLevelUpEnd", self, self.IsV14)
end

function MallView:start()
    local menu = self.menuScript.menu
    for key, page in pairs(menu) do
        page:regOnButtonClick(function()
            self:OnBtnMenu(key)
        end)
    end
    
    local isForbidden = luaevt.trig("___EVENT__NOT_OPEN_FORBIDDEN_VN")
    GameObjectHelper.FastSetActive(self.menuScript.menu.playerPiece.gameObject, not isForbidden)

    -- 屏蔽月卡商城
    GameObjectHelper.FastSetActive(self.menuScript.menu.monthCard.gameObject, false)
end

function MallView:OnBtnMenu(key)
    if key == self.currentPageTag then return end
    self.currentPageTag = key
    self:OnBtnPage(key)
    self.menuScript:selectMenuItem(key)
end

function MallView:OnBtnPage(key)
    if self.clickPage then 
        self.clickPage(key)
    end
end

function MallView:InitView(page)
    self.currentPageTag = nil
    self.pageTag = page
    self:OnBtnMenu(self.pageTag)
end

function MallView:IsShowHonorStore(flag)
    GameObjectHelper.FastSetActive(self.menuScript.menu.honorStore.gameObject, flag)
end

function MallView:IsV14(val)
   if require("ui.models.PlayerInfoModel").new():IsVip14() then
       self:IsShowHonorStore(true)
   end
end

function MallView:onDestroy()
    EventSystem.RemoveEvent("VIPLevelUpEnd", self, self.IsV14)
end

return MallView
