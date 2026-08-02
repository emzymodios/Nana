-- logic/init.lua
local Logic = {}

-- Tải các module logic con
local SpeedModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/speed.lua"))()
local FlyModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fly.lua"))()
local NoClipModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/noclip.lua"))()
local JumpModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/jump.lua"))()
local ESPModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/esp.lua"))()
local FPSBoostModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fpsboost.lua"))()
local AimbotModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/aimbot.lua"))()
local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/teleport.lua"))()
local SoruModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/soru.lua"))()
local GodmodeModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/godmode.lua"))()
local ServerModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/server.lua"))()

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

-- Cầu nối Soru (Click Teleport)
function Logic.ToggleSoru(state)
    SoruModule.Toggle(state)
end

-- Cầu nối chọn tên người chơi cho Teleport / Aimbot
function Logic.SetAimbotTarget(playerName)
    AimbotModule.SetTarget(playerName)
    TeleportModule.SetTarget(playerName)
end

-- Cầu nối Teleport qua người chơi dạng Toggle (Gạt bật/tắt)
function Logic.ToggleTeleportPlayer(state, targetName)
    if targetName and targetName ~= "" then
        TeleportModule.SetTarget(targetName)
    end

    if state then
        TeleportModule.StartContinuousFly(100)
    else
        TeleportModule.StopFly()
    end
end

function Logic.SmoothTeleportToTarget()
    TeleportModule.FlyToTarget()
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

-- Cầu nối Aimbot
function Logic.ToggleAimbot(state)
    AimbotModule.Toggle(state)
end

function Logic.SetAimbotMode(mode)
    AimbotModule.SetMode(mode)
end

-- Cầu nối Godmode
function Logic.ToggleGodmode(state)
    GodmodeModule.Toggle(state)
end

-- Cầu nối Rejoin & Server Hop
function Logic.RejoinGame()
    ServerModule.Rejoin()
end

function Logic.ServerHop()
    ServerModule.ServerHop()
end

-- Cầu nối Reset Config tổng thể
function Logic.ResetConfig()
    SpeedModule.Toggle(false)
    FlyModule.Toggle(false)
    NoClipModule.Toggle(false)
    JumpModule.Toggle(false)
    SoruModule.Toggle(false)
    ESPModule.Toggle(false)
    FPSBoostModule.Toggle(false)
    AimbotModule.Toggle(false)
    TeleportModule.StopFly()
    GodmodeModule.Toggle(false)
end

return Logic
