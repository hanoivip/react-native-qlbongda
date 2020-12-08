local Tweening = clr.DG.Tweening
local DOTween = Tweening.DOTween
local ShortcutExtensions = Tweening.ShortcutExtensions
local TweenSettingsExtensions = Tweening.TweenSettingsExtensions
local Ease = Tweening.Ease
local LoopType = Tweening.LoopType

local GameObjectHelper = require("ui.common.GameObjectHelper")

local AntiAddictionView = class(unity.base)

function AntiAddictionView:ctor()
    self.label00 = self.___ex.label00 -- gameObject
    self.tipsCanvasGroup = self.___ex.tipsCanvasGroup -- gameObject
    self.countdownTimeText = self.___ex.countdownTimeText -- text
    self.overtimePanel = self.___ex.overtimePanel -- gameObject
    self.btnOvertimeConfirm = self.___ex.btnOvertimeConfirm -- luabutton
end

function AntiAddictionView:start()
    self.btnOvertimeConfirm:regOnButtonClick(function()
        if type(self.onOvertimeConfirmClick) == "function" then
            self.onOvertimeConfirmClick()
        end
    end)
end

function AntiAddictionView:Hide()
    self:ShowLabel00(false)
    self:ShowTips(false)
    self:ShowCountdown(false)
    self:ShowOvertimePanel(false)
end

function AntiAddictionView:Init()
    self:ShowLabel00(true)
    self:ShowTips(false)
    self:ShowCountdown(true)
    self:ShowOvertimePanel(false)
end

function AntiAddictionView:ShowLabel00(isShow)
    GameObjectHelper.FastSetActive(self.label00, tobool(isShow))
end

function AntiAddictionView:ShowTips(isShow)
    if isShow then
        local tweener = ShortcutExtensions.DOFade(self.tipsCanvasGroup, 1, 1.5)
        TweenSettingsExtensions.SetEase(tweener, Ease.OutQuint)
        TweenSettingsExtensions.SetLoops(tweener, 2, LoopType.Yoyo)
    else
        self.tipsCanvasGroup.alpha = 0
    end
end

function AntiAddictionView:ShowOvertimePanel(isShow)
    GameObjectHelper.FastSetActive(self.overtimePanel, tobool(isShow))
end

function AntiAddictionView:ShowCountdown(isShow)
    GameObjectHelper.FastSetActive(self.countdownTimeText.gameObject, tobool(isShow))
end

function AntiAddictionView:SetCountdown(remainSeconds)
    self.countdownTimeText.text = tostring(string.convertSecondToTime(remainSeconds))
end


return AntiAddictionView
