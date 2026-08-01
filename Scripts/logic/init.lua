-- logic/init.lua
local Logic = {}

-- Tải các module logic con cũ và mới
local SpeedModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/speed.lua"))()
local FlyModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fly.lua"))()
local NoClipModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/noclip.lua"))()
local JumpModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/jump.lua"))()
local ESPModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/esp.lua"))()
local FPSBoostModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fpsboost.lua"))()
local AimbotModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/aimbot.lua"))()
local SoruModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/soru.lua"))()
local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/teleport.lua"))()
local PositionModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/position.lua"))()

-- Cầu nối Speed
function Logic.ToggleSpeed(state)
    SpeedModule.Toggle(state)
end

function Logic.SetSpeed(val)
    SpeedModule.SetSpeed(val)
end

-- Cầu nối Fly
function Logic.ToggleFly(state)
    FlyModule.Toggle(state)
end

function Logic.SetFlySpeed(val)
    FlyModule.SetFlySpeed(val)
end

-- Cầu nối NoClip
function Logic.ToggleNoClip(state)
    NoClipModule.Toggle(state)
end

-- Cầu nối Infinite Jump
function Logic.ToggleInfiniteJump(state)
    JumpModule.Toggle(state)
end

-- Cầu nối Soru (Thay thế Auto Click ở tab Main)
function Logic.ToggleSoru(state)
    SoruModule.Toggle(state)
end

-- Cầu nối ESP
function Logic.ToggleESP(state)
    ESPModule.Toggle(state)
end

function Logic.SetESPTextSize(size)
    ESPModule.SetTextSize(size)
end

-- Cầu nối FPS Boost
function Logic.ToggleFPSBoost(state)
    FPSBoostModule.Toggle(state)
end

-- Cầu nối Aimbot & Teleport (Nằm chung ở tab Combat)
function Logic.ToggleAimbot(state)
    AimbotModule.Toggle(state)
end

function Logic.SetAimbotMode(mode)
    AimbotModule.SetMode(mode)
end

function Logic.SetAimbotTarget(playerName)
    AimbotModule.SetTarget(playerName)
    TeleportModule.SetTarget(playerName)
end

function Logic.SmoothTeleportToTarget()
    TeleportModule.FlyToTarget()
end

-- Cầu nối tính năng Position (Tab More)
function Logic.SavePosition()
    return PositionModule.Save()
end

function Logic.ResetPosition()
    return PositionModule.Reset()
end

function Logic.TeleportToSaved()
    PositionModule.Teleport()
end

-- Cầu nối Reset Config tổng thể
function Logic.ResetConfig()
    SpeedModule.Toggle(false)
    FlyModule.Toggle(false)
    NoClipModule.Toggle(false)
    JumpModule.Toggle(false)
    ESPModule.Toggle(false)
    FPSBoostModule.Toggle(false)
    AimbotModule.Toggle(false)
    SoruModule.Toggle(false)
end

return Logic
