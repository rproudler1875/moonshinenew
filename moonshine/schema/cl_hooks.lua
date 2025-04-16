function Schema:CharacterLoaded(character)
    self:ExampleFunction("@serverWelcome", character:GetName())
end

function Schema:CreateMenuButtons(tabs)
    tabs["Stock Market"] = function(panel)
        local stockPanel = vgui.Create("DPanel")
        for company, data in pairs(ix.stockmarket.companies) do
            local button = stockPanel:Add("DButton")
            button:SetText(company .. ": $" .. data.price)
            button.DoClick = function()
                net.Start("StockMarketBuy")
                net.WriteString(company)
                net.WriteUInt(1, 8)
                net.SendToServer()
            end
        end
        panel:AddPanel(stockPanel)
    end

    tabs["Crafting Bench"] = function(panel)
        local craftPanel = vgui.Create("DPanel")
        for recipe, _ in pairs(ix.crafting.recipes) do
            local button = craftPanel:Add("DButton")
            button:SetText(recipe)
            button.DoClick = function()
                net.Start("CraftItem")
                net.WriteString(recipe)
                net.SendToServer()
            end
        end
        panel:AddPanel(craftPanel)
    end
end