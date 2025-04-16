function Schema:DatabaseConnected()
    ix.db.Query([[
        CREATE TABLE IF NOT EXISTS moonshine_profiles (
            steamid VARCHAR(20),
            bio TEXT,
            stats TEXT,
            PRIMARY KEY (steamid)
        )
    ]])
end

function Schema:CharacterPreSave(character)
    local profile = ix.socialhub.GetProfile(character)
    ix.db.Query("INSERT OR REPLACE INTO moonshine_profiles (steamid, bio, stats) VALUES (?, ?, ?)",
        character:GetPlayer():SteamID64(), profile.bio, util.TableToJSON(profile.stats))
end

hook.Add("CharacterLoaded", "SurvivalDataInit", function(character)
    if not character:GetData("hunger") then
        character:SetData("hunger", 100)
    end
    if not character:GetData("thirst") then
        character:SetData("thirst", 100)
    end
    if not character:GetData("fatigue") then
        character:SetData("fatigue", 0)
    end
end)