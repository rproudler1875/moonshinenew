function Schema:SlapPlayer(client)
    if IsValid(client) and client:IsPlayer() then
        client:SetVelocity(Vector(math.random(-50, 50), math.random(-50, 50), math.random(0, 20)))
        client:TakeDamage(math.random(5, 10))
    end
end

net.Receive("StockMarketBuy", function(len, client)
    local company = net.ReadString()
    local amount = net.ReadUInt(8)
    if ix.stockmarket.BuyStock(client, company, amount) then
        client:Notify("Purchased " .. amount .. " shares of " .. company)
    else
        client:Notify("Failed to purchase shares")
    end
end)

net.Receive("CraftItem", function(len, client)
    local recipe = net.ReadString()
    if ix.crafting.Craft(client, recipe) then
        client:Notify("Crafted " .. recipe)
    else
        client:Notify("Failed to craft item")
    end
end)