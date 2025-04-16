CLASS.name = "Paramedic"
CLASS.faction = FACTION_CITIZEN
CLASS.description = "A trained medical professional dedicated to saving lives in emergencies."
function CLASS:OnCanBe(client)
    return client:HasFlag("p")
end
CLASS.pay = 15

CLASS_PARAMEDIC = CLASS.index