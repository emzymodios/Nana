-- logic/init.lua
local Logic = {}

local function loadModule(name, url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success and type(result) == "table" then
        return result
    else
        warn("[Nana Hub] Failed to load module:", name, "| Error:", result)
        -- Trả về bảng trống an toàn để không làm sập toàn bộ Hub nếu thiếu file
        return setmetatable({}, {
            __index = function()
                return function() end
            end
        })
    end
end

local baseUrl = "https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/"

local SpeedModule = loadModule("Speed", baseUrl .. "speed.lua")
local FlyModule = loadModule("Fly", baseUrl .. "fly.lua")
local NoClipModule = loadModule("NoClip", baseUrl .. "noclip.lua")
local JumpModule = loadModule("Jump", baseUrl .. "jump.lua")
local ESPModule = loadModule("ESP", baseUrl .. "esp.lua")
local FPSBoostModule = loadModule("FPSBoost", baseUrl .. "fpsboost.lua")
local AimbotModule = loadModule("Aimbot", baseUrl .. "aimbot.lua")
local SoruModule = loadModule("Soru", baseUrl .. "soru.lua")
local TeleportModule = loadModule("Teleport", baseUrl .. "teleport.lua")
local PositionModule = loadModule("Position", baseUrl .. "position.lua")

-- Cầu nối Speed
function Logic.ToggleSpeed(state) SpeedModule.Toggle(state) end
function Logic.SetSpeed(val) if SpeedModule.SetSpeed then SpeedModule.SetSpeed(val) end end

-- Cầu nối Fly
function Logic.ToggleFly(state) FlyModule.Toggle(state) end
function Logic.SetFlySpeed(val) if SpeedModule.SetFlySpeed then SpeedModule.SetFlySpeed(val) end end

-- Cầu nối NoClip
function Logic.ToggleNoClip(state) NoClipModule.Toggle(state) end

-- Cầu nối Infinite Jump
function Logic.ToggleInfiniteJump(state) JumpModule.Toggle(state) end

-- Cầu nối Soru (Thay thế Auto Click ở tab Main)
function Logic.ToggleSoru(state) SoruModule.Toggle(state) end

-- Cầu nối ESP
function Logic.ToggleESP(state) ESPModule.Toggle(state) end
function Logic.SetESPTextSize(size) if ESPModule.SetTextSize then ESPModule.SetTextSize(size) end end

-- Cầu nối FPS Boost
function Logic.ToggleFPSBoost(state) FPSBoostModule.Toggle(state) end

-- Cầu nối Aimbot & Teleport (Nằm chung ở tab Combat)
function Logic.ToggleAimbot(state) AimbotModule.Toggle(state) end
function Logic.SetAimbotMode(mode) if AimbotModule.SetMode then AimbotModule.SetMode(mode) end end
function Logic.SetAimbotTarget(playerName) 
    if AimbotModule.SetTarget then AimbotModule.SetTarget(playerName) end
    if TeleportModule.SetTarget then TeleportModule.SetTarget(playerName) end
end
function Logic.SmoothTeleportToTarget() if TeleportModule.FlyToTarget then TeleportModule.FlyToTarget() end end

-- Cầu nối tính năng Position (Tab More)
function Logic.SavePosition()
    if PositionModule.Save then return PositionModule.Save() end
    return "[ Error ]"
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
