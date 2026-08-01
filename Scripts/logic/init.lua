-- logic/init.lua
local Logic = {}

-- Tải trực tiếp các module logic con qua link Raw GitHub
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
    if SpeedModule.SetSpeed then SpeedModule.SetSpeed(val) end
end

-- Cầu nối Fly
function Logic.ToggleFly(state)
    FlyModule.Toggle(state)
end

function Logic.SetFlySpeed(val)
    if FlyModule.SetFlySpeed then FlyModule.SetFlySpeed(val) end
end

-- Cầu nối NoClip
function Logic.ToggleNoClip(state)
    NoClipModule.Toggle(state)
end

-- Cầu nối Infinite Jump
function Logic.ToggleInfiniteJump(state)
    JumpModule.Toggle(state)
end

-- Cầu nối Soru (Tab Main)
function Logic.ToggleSoru(state)
    SoruModule.Toggle(state)
end

-- Cầu nối ESP
function Logic.ToggleESP(state)
    ESPModule.Toggle(state)
end

function Logic.SetESPTextSize(size)
    if ESPModule.SetTextSize then ESPModule.SetTextSize(size) end
end

-- Cầu nối FPS Boost
function Logic.ToggleFPSBoost(state)
    FPSBoostModule.Toggle(state)
end

-- Cầu nối Aimbot & Teleport (Tab Combat)
function Logic.ToggleAimbot(state)
    AimbotModule.Toggle(state)
end

function Logic.SetAimbotMode(mode)
    if AimbotModule.SetMode then AimbotModule.SetMode(mode) end
end

function Logic.SetAimbotTarget(playerName)
    if AimbotModule.SetTarget then AimbotModule.SetTarget(playerName) end
    if TeleportModule.SetTarget then TeleportModule.SetTarget(playerName) end
end

function Logic.SmoothTeleportToTarget()
    if TeleportModule.FlyToTarget then TeleportModule.FlyToTarget() end
end

-- Cầu nối tính năng Position (Tab More) - Khớp 100% với position.lua của bạn
function Logic.SavePosition()
    if PositionModule.Save then return PositionModule.Save() end
    return "Chưa có vị trí"
end

function Logic.ResetPosition()
    if PositionModule.Reset then return PositionModule.Reset() end
    return "[            ]"
end

function Logic.TeleportToSaved()
    if PositionModule.Teleport then PositionModule.Teleport() end
end

-- Cầu nối Reset Config tổng thể
function Logic.ResetConfig()
    pcall(function()
        SpeedModule.Toggle(false)
        FlyModule.Toggle(false)
        NoClipModule.Toggle(false)
        JumpModule.Toggle(false)
        ESPModule.Toggle(false)
        FPSBoostModule.Toggle(false)
        AimbotModule.Toggle(false)
        SoruModule.Toggle(false)
    end)
end

return Logic
