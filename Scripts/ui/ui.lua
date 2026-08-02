-- logic/init.lua
local Logic = {}

-- Hàm hỗ trợ tải module an toàn bằng pcall để tránh sập toàn bộ script nếu mạng lỗi hoặc sai link
local function safeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success and type(result) == "table" then
        return result
    else
        warn("[Nana Hub] Khong the tai module tu URL: " .. tostring(url))
        -- Trả về một bảng trống chứa các hàm giả lập để không bị lỗi attempt to index nil
        return setmetatable({}, {
            __index = function(_, k)
                return function() end
            end
        })
    end
end

-- Tải các module logic con qua hàm an toàn
local SpeedModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/speed.lua")
local FlyModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fly.lua")
local NoClipModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/noclip.lua")
local JumpModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/jump.lua")
local ESPModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/esp.lua")
local FPSBoostModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fpsboost.lua")
local AimbotModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/aimbot.lua")
local TeleportModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/teleport.lua")
local SoruModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/soru.lua")
local PositionModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/position.lua")

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

-- Cầu nối Position Teleport
function Logic.TeleportToCoords(x, y, z)
    if PositionModule.TeleportToCoords then
        PositionModule.TeleportToCoords(x, y, z)
    end
end

function Logic.GetCurrentPosition()
    if PositionModule.GetCurrentPosition then
        return PositionModule.GetCurrentPosition()
    end
    return Vector3.new(0, 0, 0)
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

-- Hàm cũ giữ lại phòng trường hợp cần dùng dạng click đơn
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
end

return Logic
