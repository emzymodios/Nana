-- logic/init.lua
local Logic = {}

-- Hàm hỗ trợ tải module an toàn, tránh sập toàn bộ Hub nếu 1 file lỗi
local function safeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success and type(result) == "table" then
        return result
    else
        warn("Không thể tải module từ: " .. url)
        -- Trả về một bảng trống chứa hàm giả để tránh lỗi "attempt to index nil"
        return setmetatable({}, {
            __index = function(_, _)
                return function() end
            end
        })
    end
end

-- Tải các module con qua hàm an toàn
local SpeedModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/speed.lua")
local FlyModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fly.lua")
local NoClipModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/noclip.lua")
local JumpModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/jump.lua")
local ESPModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/esp.lua")
local FPSBoostModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fpsboost.lua")
local AimbotModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/aimbot.lua")
local SoruModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/soru.lua")
local TeleportModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/teleport.lua")
local PositionModule = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/position.lua")

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

-- Cầu nối tính năng Position (Tab More)
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
