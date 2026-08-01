-- logic/speed.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local SpeedModule = {}

local isSpeedEnabled = false
local currentSpeed = 16

function SpeedModule.Toggle(state)
    isSpeedEnabled = state
    if not isSpeedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end

function SpeedModule.SetSpeed(val)
    currentSpeed = val
end

-- Vòng lặp cập nhật liên tục tốc độ chạy của nhân vật
RunService.RenderStepped:Connect(function()
    if isSpeedEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = currentSpeed
        end
    end
end)

return SpeedModule
