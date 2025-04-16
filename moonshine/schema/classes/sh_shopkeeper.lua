CLASS.name = "Shopkeeper"
CLASS.faction = FACTION_CITIZEN
CLASS.description = "A merchant running a business, trading goods with the city's residents."
function CLASS:OnCanBe(client)
    return client:HasFlag("s")
end
CLASS.pay = 12

CLASS_SHOPKEEPER = CLASS.index