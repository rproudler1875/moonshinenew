ITEM.name = "Soda"
ITEM.model = Model("models/props_junk/popcan01a.mdl")
ITEM.description = "A refreshing carbonated drink."
ITEM.category = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.noBusiness = true

ITEM.functions.Drink = {
    OnRun = function(item)
        local client = item.player
        client:GetCharacter():SetData("thirst", math.min(client:GetCharacter():GetData("thirst", 100) + 20, 100))
        return true
    end
}