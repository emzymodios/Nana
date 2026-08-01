-- logic/fpsboost.lua
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local FPSBoostModule = {}
local isBoosted = false

function FPSBoostModule.Toggle(state)
    isBoosted = state
    if isBoosted then
        -- Giảm chất lượng đồ họa để tăng FPS
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
        
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterTransparency = 0
            Terrain.WaterReflectance = 0
        end

        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
    else
        -- Khôi phục lại đồ họa ban đầu
        Lighting.GlobalShadows = true
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end)
    end
end

return FPSBoostModule
