ITEM.name = "Grappling Hook"
ITEM.model = Model("models/props_junk/harpoon01.mdl")
ITEM.description = "A tool for climbing walls."
ITEM.category = "Tools"
ITEM.width = 2
ITEM.height = 2
ITEM.price = 200

ITEM.functions.Use = {
    OnRun = function(item)
        local client = item.player
        local trace = client:GetEyeTrace()
        if trace.HitPos:Distance(client:GetPos()) < 500 then
            client:SetVelocity((trace.HitPos - client:GetPos()):GetNormalized() * 1000)
        end
        return false
    end
}