local CHAR = ix.meta.character

function CHAR:IsGovernment()
    return self:GetFaction() == FACTION_GOVERNMENT
end

function CHAR:GetHunger()
    return self:GetData("hunger", 100)
end

function CHAR:SetHunger(value)
    self:SetData("hunger", value)
end

function CHAR:GetThirst()
    return self:GetData("thirst", 100)
end

function CHAR:SetThirst(value)
    self:SetData("thirst", value)
end

function CHAR:GetFatigue()
    return self:GetData("fatigue", 0)
end

function CHAR:SetFatigue(value)
    self:SetData("fatigue", value)
end