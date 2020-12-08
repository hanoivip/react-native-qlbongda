--local FancyCardHelper = require("ui.models.fancy.FancyCardHelper")
local UnityEngine = clr.UnityEngine
local Color = UnityEngine.Color

local FancyCardHelper = {}

FancyCardHelper.QualitySign =
{
    [1] = "quality_sign_4",       -- A品质
    [2] = "quality_sign_5",       -- S品质
    [3] = "quality_sign_6",       -- SS品质
}

FancyCardHelper.PieceQualityColor =
{
    [1] = {Color(1, 0.969, 0.702), Color(1, 0.969, 0.702)},      -- A品质
    [2] = {Color(1, 0.969, 0.702), Color(1, 0.969, 0.702)},       -- S品质
    [3] = {Color(0.345, 0.196, 0.09), Color(0.345, 0.196, 0.09)},       -- SS品质
}

return FancyCardHelper
