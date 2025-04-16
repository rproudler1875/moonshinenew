CLASS.name = "Hacker"
CLASS.faction = FACTION_CITIZEN
function CLASS:OnCanBe(client)
    return client:HasFlag("h")
end

CLASS_HACKER = CLASS.index