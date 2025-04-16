CLASS.name = "Police Detective"
CLASS.faction = FACTION_CITIZEN
CLASS.description = "An experienced investigator solving complex crimes to maintain order."
function CLASS:OnCanBe(client)
    local character = client:GetCharacter()
    return character:GetClass() == CLASS_POLICERECRUIT and character:GetData("police_xp", 0) >= 100
end
CLASS.pay = 15
CLASS_POLICE_DETECTIVE = CLASS.index