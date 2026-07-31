local Logic = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = nil
local humanoidRootPart = nil
local humanoid = nil

local function updateCharacter(newChar)
    character = newChar
    humanoidRootPart = newChar:WaitForChild("HumanoidRootPart", 5)
    humanoid = newChar:WaitForChild("Humanoid", 5)
end

if player.Character then
    updateCharacter(player.Character)
end

player.CharacterAdded:Connect(updateCharacter)

-- Biến trạng thái
local speedValue = 16
local isFlying = false
local flySpeed = 50
local flyConnection = nil
local noclipConnection = nil

-- 1. WalkSpeed Logic
function Logic.SetSpeed(val)
    speedValue = val
    if humanoid then
        humanoid.WalkSpeed = speedValue
    end
end

-- 2. Mobile Fly Logic
function Logic.ToggleFly(state)
    isFlying = state
    if isFlying then
        flyConnection = RunService.RenderStepped:Connect(function()
            if not character or not humanoidRootPart or not humanoid or not isFlying then return end
            
            -- Đảm bảo tạo BodyVelocity / BodyGyro nếu chưa có
            local bv = humanoidRootPart:FindFirstChild("NanaFlyVelocity")
            local bg = humanoidRootPart:FindFirstChild("NanaFlyGyro")
            
            if not bv then
                bv = Instance.new("BodyVelocity")
                bv.Name = "NanaFlyVelocity"
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Parent = humanoidRootPart
            end
            
            if not bg then
                bg = Instance.new("BodyGyro")
                bg.Name = "NanaFlyGyro"
                bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bg.Parent = humanoidRootPart
            end

            local cam = Workspace.CurrentCamera
            local moveDir = humanoid.MoveDirection
            
            if moveDir.Magnitude > 0 then
                bv.Velocity = moveDir * flySpeed
            else
                bv.Velocity = Vector3.new(0, 0, 0)
            end
            bg.CFrame = cam.CFrame
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
        if humanoidRootPart and humanoidRootPart:FindFirstChild("NanaFlyVelocity") then 
            humanoidRootPart.NanaFlyVelocity:Destroy() 
        end
        if humanoidRootPart and humanoidRootPart:FindFirstChild("NanaFlyGyro") then 
            humanoidRootPart.NanaFlyGyro:Destroy() 
        end
    end
end

-- 3. NoClip Logic
function Logic.ToggleNoClip(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- 4. Reset Config Logic
function Logic.ResetConfig()
    Logic.SetSpeed(16)
    Logic.ToggleFly(false)
    Logic.ToggleNoClip(false)
end

return Logic
