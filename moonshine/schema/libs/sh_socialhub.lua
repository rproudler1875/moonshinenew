ix.socialhub = ix.socialhub or {}

function ix.socialhub.GetProfile(character)
    return {
        name = character:GetName(),
        bio = character:GetData("bio", ""),
        stats = {
            money = character:GetMoney(),
            achievements = character:GetData("achievements", {})
        }
    }
end