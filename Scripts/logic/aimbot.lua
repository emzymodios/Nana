-- logic/aimbot.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local AimbotModule = {}
local isAimbotEnabled = false
local aimMode = "Nearest" -- "Nearest" hoặc "Selected"
local selectedTargetPlayer = nil

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

-- Vòng lặp camera tự động hướng về mục tiêu
RunService.RenderStepped:Connect(function()
    if isAimbotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetPart = GetTarget()
        if targetPart then
            -- Khóa tâm camera vào vị trí mục tiêu
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
        end
    end
end)

return AimbotModule
