local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local GuildBossDamageRankView = class(unity.base)

function GuildBossDamageRankView:ctor()
--------Start_Auto_Generate--------
    self.closeBtn = self.___ex.closeBtn
    self.myRankTxt = self.___ex.myRankTxt
    self.damageTxt = self.___ex.damageTxt
    self.coinTxt = self.___ex.coinTxt
    self.scrollerSpt = self.___ex.scrollerSpt
--------End_Auto_Generate----------
end

function GuildBossDamageRankView:start()
    DialogAnimation.Appear(self.transform, nil)
    self:RegOnBtn()
end

function GuildBossDamageRankView:InitView(model)
    if not model then
        return
    end
    local selfData = model:GetSelfData()
    if selfData then
        self.myRankTxt.text = tostring(selfData.rank)
        self.damageTxt.text = tostring(selfData.damage)
        self.coinTxt.text = tostring(selfData.bossCoin)
    else
        self.myRankTxt.text = lang.transstr("train_rankOut")
        self.damageTxt.text = "0"
        self.coinTxt.text = "0"
    end
    self.scrollerSpt:InitView(model:GetDatas())
end

function GuildBossDamageRankView:RegOnBtn()
    self.closeBtn:regOnButtonClick(function ()
        self:Close()
    end)
end

function GuildBossDamageRankView:Close()
    if type(self.closeDialog) == "function" then
        DialogAnimation.Disappear(self.transform, nil, function()
            self.closeDialog()
        end)
    end
end

return GuildBossDamageRankView
