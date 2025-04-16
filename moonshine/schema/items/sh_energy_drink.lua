ITEM.name = "Energy Drink"
ITEM.model = Model("models/props_junk/popcan02a.mdl")
ITEM.description = "Boosts sprint speed temporarily."
ITEM.category = "Consumables"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 15

ITEM.functions.Drink = {
    OnRun = function(item)
        local client = item.player
        client:GetCharacter():SetData("thirst", math.min(client:GetCharacter():GetData("thirst", 100) + 15, 100))
        client:SetRunSpeed(client:GetRunSpeed() * 1.2)
        timer.Simple(300, function()
            if IsValid(client) then
                client:SetRunSpeed(client:GetRunSpeed() / 1.2)
            end
        end)
        return true
    end
}