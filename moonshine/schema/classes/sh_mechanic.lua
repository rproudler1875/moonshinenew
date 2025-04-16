CLASS.name = "Mechanic"
CLASS.faction = FACTION_CITIZEN
CLASS.description = "A skilled technician adept at repairing vehicles and crafting mechanical devices."
function CLASS:OnCanBe(client)
    return client:HasFlag("m")
end
CLASS.pay = 12

CLASS_MECHANIC = CLASS.index