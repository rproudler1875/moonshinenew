function Schema:CanDrive(client, entity)
    return false
end

function Schema:CanPlayerUseBusiness(client, uniqueID)
    local character = client:GetCharacter()
    if character:GetClass() == CLASS_SHOPKEEPER then
        return true
    end
    return false
end