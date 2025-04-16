ITEM.name = "Small Backpack"
ITEM.model = Model("models/props_junk/cardboard_box001a.mdl")
ITEM.description = "Increases inventory capacity by 4 slots."
ITEM.category = "Storage"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 50

ITEM.functions.Equip = {
    OnRun = function(item)
        local client = item.player
        local inventory = client:GetCharacter():GetInventory()
        inventory:SetWidth(inventory:GetWidth() + 2)
        inventory:SetHeight(inventory:GetHeight() + 2)
        return false
    end
}