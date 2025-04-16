function Schema:CharacterLoaded(character)
    self:ExampleFunction("@serverWelcome", character:GetName())

    -- Re-add bars when character loads to ensure they appear
    print("Re-adding survival bars on character load")
    self:CreateBars()
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

-- Add hunger, thirst, and fatigue bars below health, armor, and stamina
function Schema:CreateBars()
    print("Creating survival bars")

    -- Hunger bar
    ix.bar.Add(function()
        local character = LocalPlayer():GetCharacter()
        if not character then
            print("No character for hunger bar")
            return 0
        end
        local value = character:GetData("hunger", 100) / 100
        return value
    end, Color(200, 100, 50), 4, "hunger")

    -- Thirst bar
    ix.bar.Add(function()
        local character = LocalPlayer():GetCharacter()
        if not character then
            print("No character for thirst bar")
            return 0
        end
        local value = character:GetData("thirst", 100) / 100
        return value
    end, Color(50, 100, 200), 5, "thirst")

    -- Fatigue bar
    ix.bar.Add(function()
        local character = LocalPlayer():GetCharacter()
        if not character then
            print("No character for fatigue bar")
            return 0
        end
        local value = character:GetData("fatigue", 0) / 100
        return value
    end, Color(100, 50, 100), 6, "fatigue")
end

-- Initialize bars after gamemode loads
hook.Add("PostGamemodeLoaded", "MoonshineCreateBars", function()
    print("PostGamemodeLoaded: Initializing survival bars")
    Schema:CreateBars()
end)