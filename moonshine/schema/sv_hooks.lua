function Schema:GetPlayerDeathSound(client)
    local character = client:GetCharacter()
    if character and (character:GetClass() == CLASS_POLICE_CHIEF or character:GetClass() == CLASS_POLICE_DETECTIVE or character:GetClass() == CLASS_POLICERECRUIT) then
        return "NPC_MetroPolice.Die"
    end
end

function Schema:PlayerEarnSalary(client, faction)
    local zone = ix.territory.CheckPlayer(client)
    if zone and ix.territory.zones[zone].owner == FACTION_CITIZEN then
        return true
    end
    return false
end