local CHAR = ix.meta.character

function CHAR:IsPolice()
    return self:GetFaction() == FACTION_POLICE
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

function CHAR:GetTemperature()
    return self:GetAttribute("Temperature", 50)
end

function CHAR:SetTemperature(value)
    self:SetAttribute("Temperature", value)
end