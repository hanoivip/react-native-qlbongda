local FormationCacheDataModel = require("ui.models.formation.FormationCacheDataModel")

local SpecialEventsFormationCacheDataModel = class(FormationCacheDataModel, "SpecialEventsFormationCacheDataModel")

function SpecialEventsFormationCacheDataModel:ctor(playerTeamsModel)
    SpecialEventsFormationCacheDataModel.super.ctor(self, playerTeamsModel)
end

return SpecialEventsFormationCacheDataModel
