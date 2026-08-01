-- logic/teleport.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local TeleportModule = {}
local selectedTargetName = nil
local isFlyingToTarget = false

function TeleportModule.SetTarget(name)
    selectedTargetName = name
end

function TeleportModule.FlyToTarget()
    if isFlyingToTarget then return end
    local targetPlayer = Players:FindFirstChild(selectedTargetName)
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = char.HumanoidRootPart
    local targetRoot = targetPlayer.Character.HumanoidRootPart

    isFlyingToTarget = true
    local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear)
    
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            targetRoot = targetPlayer.Character.HumanoidRootPart
        end
    end)

    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)})
    tween:Play()
    
    tween.Completed:Connect(function()
        if connection then connection:Disconnect() end
        isFlyingToTarget = false
    end)
end

return TeleportModule
