local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
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
    if not character or not character:FindFirstChild("HumanoidRootPart") then 
        FlyModule.Cleanup()
        return 
    end

    local hrp = character.HumanoidRootPart
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if flyEnabled then
        humanoid.PlatformStand = true
        
        -- Dọn dẹp đối tượng cũ nếu có
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end

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
            if not flyEnabled or not hrp or not hrp.Parent then 
                FlyModule.Toggle(false)
                return 
            end
            
            local camera = workspace.CurrentCamera
            local moveDir = humanoid.MoveDirection
            
            -- Tính toán vận tốc dựa hoàn toàn vào hướng camera để bay mượt theo góc nhìn
            local velocity = Vector3.new(0, 0, 0)
            if moveDir.Magnitude > 0 then
                velocity = camera.CFrame.LookVector * (moveDir.Z * -flySpeed) + camera.CFrame.RightVector * (moveDir.X * flySpeed)
            end
            
            bv.velocity = velocity
            bg.cframe = camera.CFrame
        end)
    else
        FlyModule.Cleanup()
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

function FlyModule.Cleanup()
    flyEnabled = false
    if bg then bg:Destroy(); bg = nil end
    if bv then bv:Destroy(); bv = nil end
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
end

function FlyModule.IsEnabled()
    return flyEnabled
end

return FlyModule
