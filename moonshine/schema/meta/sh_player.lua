local PLAYER = FindMetaTable("Player")

function PLAYER:IsGovernment()
    return self:Team() == FACTION_GOVERNMENT
end