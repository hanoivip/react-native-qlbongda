local FaceBookItemView = class(unity.base)

function FaceBookItemView:ctor()
    self.btnViewDetail = self.___ex.btnViewDetail
    self.nameTxt = self.___ex.name
    self.level = self.___ex.level
    self.facebookName = self.___ex.facebookName
    self.teamLogo = self.___ex.teamLogo
end

function FaceBookItemView:start()
    self.btnViewDetail:regOnButtonClick(function()
        if self.onViewDetail then
            self.onViewDetail()
        end
    end)
end

function FaceBookItemView:InitView(data, facebookModel)
    self.nameTxt.text = data.name
    self.level.text = lang.trans("friends_manager_item_level", data.lvl)
    local facebookName = facebookModel:GetFacebookData(data.socialID).name or ""
    self.facebookName.text = "(" .. lang.transstr("facebook_id") .. " : " .. facebookName .. ")"
    self:InitTeamLogo()
end

function FaceBookItemView:InitTeamLogo()
    if self.onInitTeamLogo then
        self.onInitTeamLogo()
    end
end

function FaceBookItemView:GetTeamLogoGameObject()
    return self.teamLogo
end

return FaceBookItemView