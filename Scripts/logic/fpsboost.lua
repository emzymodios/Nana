-- logic/fpsboost.lua
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local Workspace = workspace

local Terrain = Workspace:FindFirstChildOfClass("Terrain")

local FPSBoostModule = {}
local isBoosted = false
local descendantConnection = nil

-- Bảo vệ: không đụng vào nhân vật người chơi & Terrain
local function isProtected(v)
    if v:IsDescendantOf(Players) then return true end
    if v:IsA("Terrain") then return true end
    return false
end

-- ============================================
-- 1. XÓA HIỆU ỨNG ĐỒ HỌA
-- ============================================
local function killEffects(v)
    if v:IsA("ParticleEmitter")
        or v:IsA("Trail")
        or v:IsA("Beam")
        or v:IsA("Fire")
        or v:IsA("Smoke")
        or v:IsA("Sparkles")
        or v:IsA("Explosion") then
        v:Destroy()
        return true
    end
    return false
end

-- ============================================
-- 2. GIẢM CHẤT LƯỢNG MATERIAL
-- ============================================
local function flattenMaterial(v)
    if v:IsA("BasePart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
        return true
    end
    return false
end

-- ============================================
-- 3. TẮT ĐỔ BÓNG
-- ============================================
local function killShadow(v)
    if v:IsA("BasePart") then
        v.CastShadow = false
        return true
    end
    if v:IsA("Decal") or v:IsA("Texture") then
        v.Transparency = 1
        return true
    end
    if v:IsA("SurfaceAppearance") or v:IsA("PostEffect") then
        v:Destroy()
        return true
    end
    return false
end

-- ============================================
-- 4. KHỬ TẢI VẬT THỂ XA
-- ============================================
local function optimizeDistant(v)
    if v:IsA("MeshPart") then
        v.RenderFidelity = Enum.RenderFidelity.Performance
        return true
    end
    if v:IsA("Atmosphere") then
        v.Density = 0
        v.Haze = 0
        return true
    end
    if v:IsA("Sky") then
        v.StarCount = 0
        v.SunAngularSize = 0
        v.MoonAngularSize = 0
        return true
    end
    return false
end

-- ============================================
-- Hàm boost tổng — chạy cả 4 nhóm trên 1 object
-- ============================================
local function boostObject(v)
    if isProtected(v) then return end
    
    killEffects(v)
    flattenMaterial(v)
    killShadow(v)
    optimizeDistant(v)
end

local function boostAll()
    task.spawn(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            pcall(boostObject, v)
        end
        for _, v in ipairs(Lighting:GetDescendants()) do
            pcall(boostObject, v)
        end
    end)
end

-- ============================================
-- 5. TỐI ƯU UI
-- ============================================
local UI_HIDE_LIST = {
    "Chat",
    "Topbar",
    "PlayerList",
    "Backpack",
    "Health",
    "EmotesMenu",
    "BubbleChat",
}

local function optimizeUI()
    pcall(function()
        for _, name in ipairs(UI_HIDE_LIST) do
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[name], false)
        end
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    end)
end

-- ============================================
-- TOGGLE
-- ============================================
function FPSBoostModule.Toggle(state)
    if isBoosted == state then return end
    isBoosted = state

    if not isBoosted then
        -- Tắt: khôi phục UI (effect/material đã destroy không hồi được)
        pcall(function()
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
        end)
        return
    end

    -- === 3. TẮT ĐỔ BÓNG (GLOBAL) ===
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0

    -- === 1. XÓA HIỆU ỨNG ÁNH SÁNG PHỨC TẠP ===
    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("Atmosphere") or effect:IsA("Sky") then
            effect:Destroy()
        end
    end

    -- === 4. KHỬ TẢI VẬT THỂ XA ===
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    -- Terrain
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterTransparency = 1
        Terrain.WaterReflectance = 0
        Terrain.Decoration = false
    end

    -- Sound
    pcall(function()
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 1
        SoundService.RolloffScale = 0
    end)

    -- === 1+2+3+4. BOOST TOÀN BỘ MAP ===
    boostAll()

    -- Hook parts mới spawn
    if descendantConnection then
        descendantConnection:Disconnect()
    end
    descendantConnection = Workspace.DescendantAdded:Connect(function(v)
        if isBoosted then
            pcall(boostObject, v)
        end
    end)

    -- === 5. TỐI ƯU UI ===
    optimizeUI()
end

return FPSBoostModule
