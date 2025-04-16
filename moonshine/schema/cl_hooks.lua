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

-- Add hunger, thirst, and fatigue bars
function Schema:CreateBars()
    -- Hunger bar
    ix.bar.Add(function()
        local character = LocalPlayer():GetCharacter()
        if not character then
            return 0
        end
        return character:GetData("hunger", 100) / 100
    end, Color(200, 100, 50), 4, "hunger")

    -- Thirst bar
    ix.bar.Add(function()
        local character = LocalPlayer():GetCharacter()
        if not character then
            return 0
        end
        return character:GetData("thirst", 100) / 100
    end, Color(50, 100, 200), 5, "thirst")

    -- Fatigue bar
    ix.bar.Add(function()
        local character = LocalPlayer():GetCharacter()
        if not character then
            return 0
        end
        return character:GetData("fatigue", 0) / 100
    end, Color(100, 50, 100), 6, "fatigue")
end