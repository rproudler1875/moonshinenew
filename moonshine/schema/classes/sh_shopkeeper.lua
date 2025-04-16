CLASS.name = "Shopkeeper"
CLASS.faction = FACTION_CITIZEN
function CLASS:OnCanBe(client)
    return client:HasFlag("s")
end

CLASS_SHOPKEEPER = CLASS.index