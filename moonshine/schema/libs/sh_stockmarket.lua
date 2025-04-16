ix.stockmarket = ix.stockmarket or {}

ix.stockmarket.companies = {
    ["CrimeTech"] = {price = 100, volatility = 0.1},
    ["MediCorp"] = {price = 80, volatility = 0.05},
    ["TechTrend"] = {price = 120, volatility = 0.15}
}

function ix.stockmarket.UpdatePrices()
    for name, data in pairs(ix.stockmarket.companies) do
        local change = math.random(-data.volatility * 100, data.volatility * 100)
        data.price = math.max(10, data.price + change)
    end
    timer.Simple(300, ix.stockmarket.UpdatePrices)
end
ix.stockmarket.UpdatePrices()

function ix.stockmarket.BuyStock(client, company, amount)
    local character = client:GetCharacter()
    local price = ix.stockmarket.companies[company].price * amount
    if character:GetMoney() >= price then
        character:TakeMoney(price)
        local stocks = character:GetData("stocks", {})
        stocks[company] = (stocks[company] or 0) + amount
        character:SetData("stocks", stocks)
        return true
    end
    return false
end

function ix.stockmarket.SellStock(client, company, amount)
    local character = client:GetCharacter()
    local stocks = character:GetData("stocks", {})
    if stocks[company] and stocks[company] >= amount then
        local price = ix.stockmarket.companies[company].price * amount
        character:GiveMoney(price)
        stocks[company] = stocks[company] - amount
        if stocks[company] <= 0 then stocks[company] = nil end
        character:SetData("stocks", stocks)
        return true
    end
    return false
end