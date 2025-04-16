CLASS.name = "Paramedic"
CLASS.faction = FACTION_CITIZEN
function CLASS:OnCanBe(client)
    return client:HasFlag("p") -- Requires flag
end

CLASS_PARAMEDIC = CLASS.index