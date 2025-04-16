local PLAYER = FindMetaTable("Player")

function PLAYER:IsPolice()
    local character = self:GetCharacter()
    return character and (character:GetClass() == CLASS_POLICE_CHIEF or character:GetClass() == CLASS_POLICE_DETECTIVE or character:GetClass() == CLASS_POLICERECRUIT)
end