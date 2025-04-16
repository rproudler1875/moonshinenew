CLASS.name = "Police Chief"
CLASS.faction = FACTION_POLICE
function CLASS:OnCanBe(client)
    return false -- Admin-only
end

CLASS_POLICE_CHIEF = CLASS.index