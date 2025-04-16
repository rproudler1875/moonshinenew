ix.crafting = ix.crafting or {}

ix.crafting.recipes = {
    ["Steak"] = {ingredients = {["Wheat"] = 1, ["Meat"] = 2}, result = "Steak", tool = "Oven"},
    ["Energy Drink"] = {ingredients = {["Sugar"] = 1, ["Water"] = 1}, result = "Energy Drink", tool = "Mixer"}
}

function ix.crafting.Craft(client, recipe)
    local character = client:GetCharacter()
    local inventory = character:GetInventory()
    local recipeData = ix.crafting.recipes[recipe]

    for item, amount in pairs(recipeData.ingredients) do
        if not inventory:HasItem(item, amount) then
            return false
        end
    end

    for item, amount in pairs(recipeData.ingredients) do
        inventory:RemoveItem(item, amount)
    end
    inventory:Add(recipeData.result)
    return true
end