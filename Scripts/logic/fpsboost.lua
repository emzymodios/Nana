-- logic/fpsboost.lua
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Terrain = workspace:FindFirstChildOfClass("Terrain")

local FPSBoostModule = {}
local isBoosted = false
local descendantConnection = nil

-- Hàm boost 1 object — áp dụng cho cả object cũ lẫn object mới spawn
local function boostObject(v)
    if v:IsA("BasePart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
        v.CastShadow = false
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") 
        or v:IsA("Trail") 
        or v:IsA("Beam") 
        or v:IsA("Fire") 
        or v:IsA("Smoke") 
        or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("SurfaceAppearance") then
        v.AlphaMode = Enum.AlphaMode.Overlay
    elseif v:IsA("Atmosphere") then
        v.Density = 0
        v.Haze = 0
    elseif v:IsA("Sky") then
        v.StarCount = 0
        v.SunAngularSize = 0
        v.MoonAngularSize = 0
    elseif v:IsA("PostEffect") then
        v.Enabled = false
    elseif v:IsA("Sound") then
        v.RollOffMaxDistance = 50
        v.RollOffMinDistance = 5
    elseif v:IsA("MeshPart") then
        v.RenderFidelity = Enum.RenderFidelity.Performance
    end
end

-- Boost toàn bộ map, chạy nền để không lag
local function boostAll()
    task.spawn(function()
        for _, v in ipairs(workspace:GetDescendants()) do
            pcall(boostObject, v)
        end
        -- Boost cả Lighting
        for _, v in ipairs(Lighting:GetDescendants()) do
            pcall(boostObject, v)
        end
    end)
end

function FPSBoostModule.Toggle(state)
    if isBoosted == state then return end
    isBoosted = state

    if isBoosted then
        -- === LIGHTING ===
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 0
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0)

        -- === QUALITY LEVEL ===
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)

        -- === TERRAIN ===
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterTransparency = 1
            Terrain.WaterReflectance = 0
            Terrain.Decoration = false
        end

        -- === WORKSPACE ===
        pcall(function()
            workspace.StreamingEnabled = true
        end)

        -- === SOUND ===
        pcall(function()
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb
            SoundService.DistanceFactor = 1
            SoundService.RolloffScale = 0
        end)

        -- === BOOST TOÀN BỘ ===
        boostAll()

        -- === BOOST PARTS MỚI SPAWN SAU NÀY ===
        if descendantConnection then
            descendantConnection:Disconnect()
        end

        descendantConnection = workspace.DescendantAdded:Connect(function(v)
            if isBoosted then
                pcall(boostObject, v)
            end
        end)
    end
end

return FPSBoostModule
