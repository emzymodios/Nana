local Logic = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local flyEnabled = false
local noclipEnabled = false
local currentSpeed = 16
local flySpeed = 50

local bg, bv
local noclipConnection, flyConnection

function Logic.SetSpeed(speed)
    currentSpeed = speed
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    end
end

function Logic.SetFlySpeed(speed)
    flySpeed = speed
end

function Logic.ToggleFly(state)
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
                -- Đồng bộ hướng di chuyển theo góc nhìn Camera và Joystick trên Mobile
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

function Logic.ToggleNoClip(state)
    noclipEnabled = state
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
    end
end

function Logic.ResetConfig()
    Logic.ToggleFly(false)
    Logic.ToggleNoClip(false)
    Logic.SetSpeed(16)
end

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(1)
    if flyEnabled then Logic.ToggleFly(true) end
    if noclipEnabled then Logic.ToggleNoClip(true) end
    Logic.SetSpeed(currentSpeed)
end)

return Logic
