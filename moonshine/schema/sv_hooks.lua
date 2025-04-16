function Schema:GetPlayerDeathSound(client)
    local character = client:GetCharacter()
    if character and character:IsPolice() then
        return "NPC_MetroPolice.Die"
    end
end

function Schema:PlayerEarnSalary(client, faction)
    local zone = ix.territory.CheckPlayer(client)
    if zone and ix.territory.zones[zone].owner == faction.index then
        return true
    end
    return false
end