ix.achievements = ix.achievements or {}

ix.achievements.list = {
    ["Millionaire"] = {description = "Earn 1,000,000 credits.", reward = {title = "Millionaire", money = 10000}},
    ["MasterThief"] = {description = "Complete 10 heists.", reward = {title = "Master Thief", item = "Grappling Hook"}}
}

function ix.achievements.Unlock(client, achievement)
    local character = client:GetCharacter()
    local achievements = character:GetData("achievements", {})
    if not achievements[achievement] then
        achievements[achievement] = true
        character:SetData("achievements", achievements)
        local reward = ix.achievements.list[achievement].reward
        if reward.title then
            character:SetData("title", reward.title)
        end
        if reward.money then
            character:GiveMoney(reward.money)
        end
        if reward.item then
            character:GetInventory():Add(reward.item)
        end
        client:Notify(L("achievementUnlocked", achievement))
    end
end