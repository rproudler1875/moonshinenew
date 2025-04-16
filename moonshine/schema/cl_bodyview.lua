-- Client-side feature to show player's body (legs/arms) when looking down in first-person

function MoonshineBodyViewCalcView(ply, pos, angles, fov)
    if not IsValid(ply) or ply ~= LocalPlayer() or not ply:Alive() then return end
    if ply:InVehicle() or GetViewEntity() ~= ply then return end -- Skip third-person or vehicles

    local eyeAngles = angles
    local pitch = eyeAngles.p

    -- Only adjust view when looking down significantly
    if pitch < 30 then return end

    -- Adjust camera position slightly forward and down to show body
    local view = {}
    view.origin = pos + eyeAngles:Forward() * 10 + Vector(0, 0, -15) -- Shift forward and down
    view.angles = angles
    view.fov = fov
    view.drawviewer = true -- Ensure player model is drawn

    return view
end
hook.Add("CalcView", "MoonshineBodyViewCalcView", MoonshineBodyViewCalcView)

-- Render the player's body with stencil to hide the head
function MoonshineBodyViewRender()
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:Alive() or ply:InVehicle() or GetViewEntity() ~= ply then return end

    local eyeAngles = ply:EyeAngles()
    if eyeAngles.p < 30 then return end -- Only render when looking down

    -- Set up stencil to clip the head
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilWriteMask(255)
    render.SetStencilTestMask(255)
    render.SetStencilReferenceValue(1)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)

    -- Draw an invisible box to clip above the chest
    local pos = ply:GetPos() + Vector(0, 0, 50) -- Chest height
    render.SetMaterial(Material("engine/writez"))
    render.DrawBox(pos, Angle(0, 0, 0), Vector(-100, -100, 0), Vector(100, 100, 100))

    -- Only render player model where stencil is not 1 (below chest)
    render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
    render.SetStencilPassOperation(STENCIL_KEEP)

    -- Render the player's model
    render.SuppressEngineLighting(true)
    ply:DrawModel()
    render.SuppressEngineLighting(false)

    -- Disable stencil
    render.SetStencilEnable(false)
end
hook.Add("PostDrawOpaqueRenderables", "MoonshineBodyViewRender", MoonshineBodyViewRender)

-- Debug initialization
hook.Add("InitPostEntity", "MoonshineBodyViewInit", function()
    print("[Moonshine] First-person body visibility feature loaded")
end)