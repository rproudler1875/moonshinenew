CLASS.name = "Mayor"
CLASS.faction = FACTION_GOVERNMENT
CLASS.description = "The elected leader of the city, responsible for policy and administration."
CLASS.model = "models/breen.mdl"
function CLASS:OnCanBe(client)
    local count = 0
    for _, ply in ipairs(player.GetAll()) do
        local char = ply:GetCharacter()
        if char and char:GetClass() == CLASS_MAYOR then
            count = count + 1
        end
    end
    if count > 0 then
        client:Notify("There can only be one Mayor at a time.")
        return false
    end
    return true
end
CLASS.pay = 30

CLASS_MAYOR = CLASS.index