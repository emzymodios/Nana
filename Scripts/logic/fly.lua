-- logic/fly.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local FlyModule = {}
local flyEnabled = false
local flySpeed = 50
local bg, bv
local flyConnection

function FlyModule.SetSpeed(speed)
    flySpeed = speed
end

function FlyModule.Toggle(state)
    flyEnabled = state
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local hrp = character.HumanoidRootPart
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if flyEnabled then
        humanoid.PlatformStand = true
        bg = Instance.new("BodyGyro")
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = hrp.CFrame
        bg.Parent = hrp

        bv = Instance.new("BodyVelocity")
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = hrp

        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled then return end
            local camera = workspace.CurrentCamera
            local moveDir = humanoid.MoveDirection
            
            if moveDir.Magnitude > 0 then
                local camCF = camera.CFrame
                local relativeDir = camCF:VectorToObjectSpace(moveDir)
                bv.velocity = camCF:VectorToWorldSpace(Vector3.new(relativeDir.X, moveDir.Y, relativeDir.Z)) * flySpeed
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            bg.cframe = camera.CFrame
        end)
    else
        humanoid.PlatformStand = false
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
    end
end

function FlyModule.IsEnabled()
    return flyEnabled
end

return FlyModule
