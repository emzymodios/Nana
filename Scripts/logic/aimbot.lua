-- Scripts/logic/aimbot.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local AimbotModule = {}
local isAimbotEnabled = false
local aimMode = "Nearest" -- "Nearest" hoặc "Selected"
local selectedTargetPlayer = nil

-- Tùy chỉnh độ mượt (Số càng nhỏ càng mượt/chậm, từ 0.1 đến 0.5 là đẹp)
local SMOOTHNESS = 0.25 

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

-- Hàm lấy mục tiêu
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

-- Vòng lặp camera có tích hợp độ mượt (Interpolation) chống chóng mặt
RunService.RenderStepped:Connect(function()
    if isAimbotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPart = GetTarget()
        if targetPart then
            -- Tính toán góc nhìn hướng đến mục tiêu
            local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
            
            -- Dùng Lerp để camera lướt tới mục tiêu một cách mượt mà, không bị giật cục
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, SMOOTHNESS)
        end
    end
end)

return AimbotModule
