CLASS.name = "Mechanic"
CLASS.faction = FACTION_CITIZEN
function CLASS:OnCanBe(client)
    return client:HasFlag("m")
end

CLASS_MECHANIC = CLASS.index