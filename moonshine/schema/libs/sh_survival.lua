ix.survival = ix.survival or {}

function ix.survival.Update(client)
    -- Ensure client is valid and a player
    if not IsValid(client) or not client:IsPlayer() then
        print("Survival.Update: Invalid client or not a player", client)
        return
    end

    -- Ensure character exists and is valid
    local character = client:GetCharacter()
    if not character or not istable(character) or not character.SetData then
        print("Survival.Update: No valid character for", client:SteamID(), "Character:", character)
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
    local temperature = character:GetData("temperature", 50)
    local weather = ix.option.Get("weather", "clear")
    if weather == "cold" then
        temperature = math.max(0, temperature - 0.05)
    else
        temperature = math.min(100, temperature + 0.05)
    end
    character:SetData("temperature", temperature)

    if temperature <= 20 or temperature >= 80 then
        client:TakeDamage(1, nil, nil)
    end

    -- Injuries
    local injury = character:GetData("injury")
    if injury == "broken_leg" then
        client:SetWalkSpeed(client:GetWalkSpeed() * 0.5)
    end

    -- Debug logging
    print("Survival.Update: Updated for", client:SteamID(), "Hunger:", hunger, "Thirst:", thirst, "Fatigue:", fatigue)
end

hook.Add("PlayerSpawn", "SurvivalInit", function(client)
    -- Ensure client is valid and a player
    if not IsValid(client) or not client:IsPlayer() then
        print("SurvivalInit: Invalid client or not a player", client)
        return
    end

    local character = client:GetCharacter()
    if character and istable(character) and character.SetData then
        character:SetData("hunger", 100)
        character:SetData("thirst", 100)
        character:SetData("fatigue", 0)
        character:SetData("temperature", 50)
        print("SurvivalInit: Initialized for", client:SteamID())
    else
        print("SurvivalInit: No valid character for", client:SteamID(), "Character:", character)
    end
end)

-- Delay the timer start until the player has a character
hook.Add("PlayerInitialSpawn", "StartSurvivalTimer", function(client)
    -- Wait until the character is loaded
    hook.Add("CharacterLoaded", "SurvivalTimerFor_" .. client:SteamID(), function(character)
        if character:GetPlayer() == client then
            print("SurvivalTimer: Starting for", client:SteamID())
            timer.Create("SurvivalUpdate_" .. client:SteamID(), 60, 0, function()
                if IsValid(client) then
                    ix.survival.Update(client)
                else
                    timer.Remove("SurvivalUpdate_" .. client:SteamID())
                end
            end)
            -- Clean up the hook
            hook.Remove("CharacterLoaded", "SurvivalTimerFor_" .. client:SteamID())
        end
    end)
end)