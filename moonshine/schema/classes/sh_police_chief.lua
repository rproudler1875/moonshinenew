CLASS.name = "Police Chief"
CLASS.faction = FACTION_GOVERNMENT
CLASS.description = "The head of the city's law enforcement division, overseeing public safety."
function CLASS:OnCanBe(client)
    local count = 0
    for _, ply in ipairs(player.GetAll()) do
        local char = ply:GetCharacter()
        if char and char:GetClass() == CLASS_POLICE_CHIEF then
            count = count + 1
        end
    end
    if count > 0 then
        client:Notify("There can only be one Police Chief at a time.")
        return false
    end
    return true
end
CLASS.pay = 25

CLASS_POLICE_CHIEF = CLASS.index