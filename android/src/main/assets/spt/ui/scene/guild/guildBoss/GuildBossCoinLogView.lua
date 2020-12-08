local DialogAnimation = require("ui.control.dialog.DialogAnimation")
local GuildBossCoinLogView = class(unity.base)

function GuildBossCoinLogView:ctor()
--------Start_Auto_Generate--------
    self.scrollerSpt = self.___ex.scrollerSpt
    self.closeBtn = self.___ex.closeBtn
--------End_Auto_Generate----------
end


function GuildBossCoinLogView:start()
    DialogAnimation.Appear(self.transform, nil)
    self:RegOnBtn()
end

function GuildBossCoinLogView:InitView(list)
    self.scrollerSpt:InitView(list)
end

function GuildBossCoinLogView:RegOnBtn()
    self.closeBtn:regOnButtonClick(function ()
        self:Close()
    end)
end

function GuildBossCoinLogView:Close()
    if type(self.closeDialog) == "function" then
        DialogAnimation.Disappear(self.transform, nil, function()
            self.closeDialog()
        end)
    end
end

return GuildBossCoinLogView
