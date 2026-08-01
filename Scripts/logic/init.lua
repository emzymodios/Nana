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

-- Cầu nối Soru
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

-- Cầu nối Aimbot mới thêm
function Logic.ToggleAimbot(state)
    AimbotModule.Toggle(state)
end

function Logic.SetAimbotMode(mode)
    AimbotModule.SetMode(mode)
end

function Logic.SetAimbotTarget(playerName)
    AimbotModule.SetTarget(playerName)
    if TeleportModule.SetTarget then
        TeleportModule.SetTarget(playerName)
    end
end

-- Cầu nối Teleport Target
function Logic.SmoothTeleportToTarget()
    if TeleportModule.FlyToTarget then
        TeleportModule.FlyToTarget()
    end
end

-- Cầu nối Position (Tab More)
function Logic.SavePosition()
    if PositionModule.Save then
        return PositionModule.Save()
    end
    return "Chưa có vị trí"
end

function Logic.ResetPosition()
    if PositionModule.Reset then
        return PositionModule.Reset()
    end
    return "[            ]"
end

function Logic.TeleportToSaved()
    if PositionModule.Teleport then
        PositionModule.Teleport()
    end
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
    if SoruModule.Toggle then
        SoruModule.Toggle(false)
    end
end

return Logic
