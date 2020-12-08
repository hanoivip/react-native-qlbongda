local ScrollViewSameSize = require("ui.control.scroll.ScrollViewSameSize")
local GuildBossScrollViewSameSize = class(ScrollViewSameSize)

function GuildBossScrollViewSameSize:ctor()
    GuildBossScrollViewSameSize.super.ctor(self)
end

function GuildBossScrollViewSameSize:RefreshShow(data)
	self.data = data
    for i, v in ipairs(self.data) do
        local spt = self:getItem(i)
        if spt ~= nil then
            spt:InitView(v)
        end
    end
end

function GuildBossScrollViewSameSize:CloseFlagEffect()
    for i, v in ipairs(self.data) do
        local spt = self:getItem(i)
        if spt ~= nil then
            spt:CloseFlagEffect()
        end
    end
end

function GuildBossScrollViewSameSize:ShowArrowEffect(layer)
	for i, v in ipairs(self.data) do
        local spt = self:getItem(i)
        if spt ~= nil then
            spt:ShowArrowEffect(layer)
        end
    end
end

function GuildBossScrollViewSameSize:ShowFlagEffect(layer)
	for i, v in ipairs(self.data) do
        local spt = self:getItem(i)
        if spt ~= nil then
            spt:ShowFlagEffect(layer)
        end
    end
end

function GuildBossScrollViewSameSize:ShowFlagLoopEffect(layer)
	for i, v in ipairs(self.data) do
        local spt = self:getItem(i)
        if spt ~= nil then
            spt:ShowFlagLoopEffect(layer)
        end
    end
end

return GuildBossScrollViewSameSize
