ITEM.name = "Large Backpack"
ITEM.model = Model("models/props_junk/cardboard_box001b.mdl")
ITEM.description = "Increases inventory capacity by 8 slots."
ITEM.category = "Storage"
ITEM.width = 3
ITEM.height = 3
ITEM.price = 150

ITEM.functions.Equip = {
    OnRun = function(item)
        local client = item.player
        local inventory = client:GetCharacter():GetInventory()
        inventory:SetWidth(inventory:GetWidth() + 4)
        inventory:SetHeight(inventory:GetHeight() + 4)
        return false
    end
}