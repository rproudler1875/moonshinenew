ITEM.name = "Steak"
ITEM.model = Model("models/food/steak.mdl")
ITEM.description = "A juicy steak that boosts health."
ITEM.category = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 20

ITEM.functions.Eat = {
    OnRun = function(item)
        local client = item.player
        client:GetCharacter():SetData("hunger", math.min(client:GetCharacter():GetData("hunger", 100) + 30, 100))
        client:SetHealth(math.min(client:Health() + 10, client:GetMaxHealth()))
        return true
    end
}