ix.territory = ix.territory or {}

ix.territory.zones = {
    ["Downtown"] = {pos = Vector(0, 0, 0), radius = 1000, owner = nil}
}

function ix.territory.SetOwner(zone, faction)
    ix.territory.zones[zone].owner = faction
    for _, client in ipairs(player.GetAll()) do
        if client:GetCharacter() and client:GetCharacter():GetFaction() == faction then
            client:GetCharacter():GiveMoney(5) -- Tax income
        end
    end
end

function ix.territory.CheckPlayer(client)
    local pos = client:GetPos()
    for zone, data in pairs(ix.territory.zones) do
        if pos:Distance(data.pos) <= data.radius then
            return zone
        end
    end
    return nil
end