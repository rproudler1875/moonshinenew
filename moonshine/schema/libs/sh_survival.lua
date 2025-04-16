ix.survival = ix.survival or {}

function ix.survival.Update(client)
    -- Ensure client is valid and a player
    if not IsValid(client) or not client:IsPlayer() then
        return
    end

    -- Ensure character exists
    local character = client:GetCharacter()
    if not character then
        return
    end

    -- Hunger
    local hunger = character:GetData("hunger", 100)
    character:SetData("hunger", math.max(0, hunger - 0.01))
    if hunger <= 20 then
        client:SetWalkSpeed(client:GetWalkSpeed() * 0.8)
    elseif hunger > 20 then
        -- Only reset walk speed if it was previously reduced
        if client:GetWalkSpeed() < ix.config.Get("walkSpeed", 130) then
            client:SetWalkSpeed(ix.config.Get("walkSpeed", 130))
        end
    end

    -- Thirst
    local thirst = character:GetData("thirst", 100)
    character:SetData("thirst", math.max(0, thirst - 0.02))
    if thirst <= 20 then
        client:SetFOV(client:GetFOV() * 1.2, 1)
    elseif thirst > 20 then
        -- Only reset FOV if it was previously increased
        if client:GetFOV() > 0 then
            client:SetFOV(0, 1) -- Reset to default FOV
        end
    end

    -- Fatigue
    local fatigue = character:GetData("fatigue", 0)
    character:SetData("fatigue", math.min(100, fatigue + 0.01))
    if fatigue >= 80 then
        client:SetRunSpeed(client:GetRunSpeed() * 0.7)
    elseif fatigue < 80 then
        -- Only reset run speed if it was previously reduced
        if client:GetRunSpeed() < ix.config.Get("runSpeed", 240) then
            client:SetRunSpeed(ix.config.Get("runSpeed", 240))
        end
    end

    -- Temperature
    local temperature = character:GetData("temperature", 50) -- Use GetData instead of GetAttribute
    local weather = ix.option.Get("weather", "clear")
    if weather == "cold" then
        temperature = math.max(0, temperature - 0.05)
    else
        temperature = math.min(100, temperature + 0.05)
    end
    character:SetData("temperature", temperature) -- Store temperature in data

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
    -- Ensure client is valid and a player
    if not IsValid(client) or not client:IsPlayer() then
        return
    end

    local character = client:GetCharacter()
    if character then
        character:SetData("hunger", 100)
        character:SetData("thirst", 100)
        character:SetData("fatigue", 0)
        character:SetData("temperature", 50) -- Initialize temperature in data
    end
end)

timer.Create("SurvivalUpdate", 60, 0, function()
    for _, client in ipairs(player.GetAll()) do
        ix.survival.Update(client)
    end
end)