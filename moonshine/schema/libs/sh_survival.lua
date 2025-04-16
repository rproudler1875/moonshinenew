ix.survival = ix.survival or {}

function ix.survival.Update(client)
    local character = client:GetCharacter()
    if not character then return end

    -- Hunger
    local hunger = character:GetData("hunger", 100)
    character:SetData("hunger", math.max(0, hunger - 0.01))
    if hunger <= 20 then
        client:SetWalkSpeed(client:GetWalkSpeed() * 0.8)
    elseif hunger > 20 then
        client:SetWalkSpeed(client:GetWalkSpeed() / 0.8)
    end

    -- Thirst
    local thirst = character:GetData("thirst", 100)
    character:SetData("thirst", math.max(0, thirst - 0.02))
    if thirst <= 20 then
        client:SetFOV(client:GetFOV() * 1.2, 1)
    elseif thirst > 20 then
        client:SetFOV(client:GetFOV() / 1.2, 1)
    end

    -- Fatigue
    local fatigue = character:GetData("fatigue", 0)
    character:SetData("fatigue", math.min(100, fatigue + 0.01))
    if fatigue >= 80 then
        client:SetRunSpeed(client:GetRunSpeed() * 0.7)
    elseif fatigue < 80 then
        client:SetRunSpeed(client:GetRunSpeed() / 0.7)
    end

    -- Temperature
    local temperature = character:GetAttribute("Temperature", 50)
    local weather = ix.option.Get("weather", "clear")
    if weather == "cold" then
        character:SetAttribute("Temperature", math.max(0, temperature - 0.05))
    else
        character:SetAttribute("Temperature", math.min(100, temperature + 0.05))
    end
    if temperature <= 20 or temperature >= 80 then
        client:TakeDamage(1, nil, nil)
    end

    -- Injuries
    local injury = character:GetData("injury")
    if injury == "broken_leg" then
        client:SetWalkSpeed(client:GetWalkSpeed() * 0.5)
    end
end

hook.Add("PlayerSpawn", "SurvivalInit", function(client)
    local character = client:GetCharacter()
    if character then
        character:SetData("hunger", 100)
        character:SetData("thirst", 100)
        character:SetData("fatigue", 0)
        character:SetAttribute("Temperature", 50)
    end
end)

timer.Create("SurvivalUpdate", 60, 0, function()
    for _, client in ipairs(player.GetAll()) do
        ix.survival.Update(client)
    end
end)