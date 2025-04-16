ITEM.name = "Medkit"
ITEM.model = Model("models/props_junk/Medkit01.mdl")
ITEM.description = "Heals injuries and restores health."
ITEM.category = "Medical"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 50

ITEM.functions.Use = {
    OnRun = function(item)
        local client = item.player
        client:SetHealth(math.min(client:Health() + 50, client:GetMaxHealth()))
        client:GetCharacter():SetData("injury", nil)
        return true
    end
}