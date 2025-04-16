CLASS.name = "Hacker"
CLASS.faction = FACTION_CITIZEN
CLASS.description = "A tech-savvy individual skilled at bypassing security systems for profit or mischief."
function CLASS:OnCanBe(client)
    return client:HasFlag("h")
end
CLASS.pay = 15

CLASS_HACKER = CLASS.index