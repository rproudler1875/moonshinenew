ITEM.name = "Methamphetamine"
ITEM.model = Model("models/props_junk/glassbottle01a.mdl")
ITEM.description = "Illegal drug for sale or use."
ITEM.category = "Contraband"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 100
ITEM.noBusiness = true

ITEM.functions.Use = {
    OnRun = function(item)
        local client = item.player
        client:SetHealth(math.min(client:Health() + 20, client:GetMaxHealth()))
        client:TakeDamage(10, client, client)
        return true
    end
}