-- ╔════════════════════════════════════════╗
-- ║   NANA HUB - AIMBOT.LUA                 ║
-- ║   Kiểu: Skill Direction Lock            ║
-- ║   - Camera hoàn toàn tự do              ║
-- ║   - Hướng skill tự động tới mục tiêu   ║
-- ╚════════════════════════════════════════╝

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local AimbotModule = {}
local isAimbotEnabled = false
local aimMode = "Nearest" -- "Nearest" hoặc "Selected"
local selectedTargetPlayer = nil
local isAttacking = false

function AimbotModule.Toggle(state)
    isAimbotEnabled = state
end

function AimbotModule.SetMode(mode)
    aimMode = mode
end

function AimbotModule.SetTarget(playerName)
    if playerName and playerName ~= "" then
        selectedTargetPlayer = Players:FindFirstChild(playerName)
    else
        selectedTargetPlayer = nil
    end
end

-- Hàm lấy mục tiêu dựa trên chế độ
local function GetTarget()
    if not isAimbotEnabled then return nil end

    if aimMode == "Selected" then
        if selectedTargetPlayer and selectedTargetPlayer.Character and selectedTargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if selectedTargetPlayer ~= LocalPlayer and selectedTargetPlayer.Character.Humanoid.Health > 0 then
                return selectedTargetPlayer.Character.HumanoidRootPart
            end
        end
        return nil
    elseif aimMode == "Nearest" then
        local nearestTarget = nil
        local shortestDistance = math.huge

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local hrp = player.Character.HumanoidRootPart
                    local distance = (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestTarget = hrp
                    end
                end
            end
        end
        return nearestTarget
    end
    return nil
end

-- Phát hiện attack (click chuột)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isAttacking = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isAttacking = false
    end
end)

-- Vòng lặp: Chỉ rotate character body khi attacking (hướng skill)
RunService.RenderStepped:Connect(function()
    if isAimbotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        -- Chỉ aim khi đang attack
        if isAttacking then
            local targetPart = GetTarget()
            if targetPart then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local directionToTarget = (targetPart.Position - hrp.Position).Unit
                
                -- CHỈ ROTATE BODY - Camera không bị ảnh hưởng
                local newCFrame = CFrame.new(hrp.Position, hrp.Position + directionToTarget)
                
                -- Rotate character mượt mà
                hrp.CFrame = hrp.CFrame:Lerp(newCFrame, 0.25) -- 0.25 = smooth level
            end
        end
    end
end)

return AimbotModule
