-- logic/speed.lua (Đã xử lý triệt để quán tính trôi)
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
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").AssemblyLinearVelocity = Vector3.new(0, LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity.Y, 0)
    end
end

function SpeedModule.SetSpeed(val)
    currentSpeed = val
end

RunService.RenderStepped:Connect(function()
    if isSpeedEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if humanoid then
            humanoid.WalkSpeed = currentSpeed
            
            -- Nếu nhân vật không bấm phím di chuyển nữa, triệt tiêu quán tính trôi ngay lập tức
            if rootPart and humanoid.MoveDirection.Magnitude == 0 then
                local currentVel = rootPart.AssemblyLinearVelocity
                rootPart.AssemblyLinearVelocity = Vector3.new(0, currentVel.Y, 0)
            end
        end
    end
end)

return SpeedModule
