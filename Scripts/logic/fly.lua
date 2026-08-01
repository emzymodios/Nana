local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local FlyModule = {}
local flyEnabled = false
local flySpeed = 50 -- Giá trị mặc định
local bg, bv
local flyConnection

-- Hàm nhận tốc độ mới từ Slider
function FlyModule.SetSpeed(speed)
    flySpeed = tonumber(speed) or 50
end

function FlyModule.Toggle(state)
    flyEnabled = state
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local hrp = character.HumanoidRootPart
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if flyEnabled then
        humanoid.PlatformStand = true
        
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
            
            if moveDir.Magnitude > 0 then
                local camLook = camera.CFrame.LookVector
                local camRight = camera.CFrame.RightVector
                
                local flatLook = Vector3.new(camLook.X, 0, camLook.Z).Unit
                local flatRight = Vector3.new(camRight.X, 0, camRight.Z).Unit
                
                -- Tính toán vận tốc dựa trên flySpeed hiện tại (sẽ thay đổi ngay khi bạn kéo slider)
                local velocity = (flatLook * -moveDir.Z + flatRight * moveDir.X) * flySpeed
                bv.velocity = Vector3.new(velocity.X, moveDir.Y * flySpeed, velocity.Z)
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            
            bg.cframe = camera.CFrame
        end)
    else
        humanoid.PlatformStand = false
        if bg then bg:Destroy(); bg = nil end
        if bv then bv:Destroy(); bv = nil end
        if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
    end
end

function FlyModule.IsEnabled()
    return flyEnabled
end

return FlyModule
