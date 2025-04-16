CLASS.name = "Police Detective"
CLASS.faction = FACTION_POLICE
function CLASS:OnCanBe(client)
    local character = client:GetCharacter()
    return character:GetClass() == CLASS_POLICE_RECRUIT and character:GetData("police_xp", 0) >= 100
end

CLASS_POLICE_DETECTIVE = CLASS.index