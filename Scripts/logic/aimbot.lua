-- Scripts/logic/aimbot.lua (Silent Aim / Auto-Redirect cho Mobile)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local AimbotModule = {}
local isAimbotEnabled = false

function AimbotModule.Toggle(state)
    isAimbotEnabled = state
end

-- Hàm tìm kẻ địch gần nhất
local function GetNearestTarget()
    local nearestTarget = nil
    local shortestDistance = math.huge
    local myChar = LocalPlayer.Character
    
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myRoot = myChar.HumanoidRootPart

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local hrp = player.Character.HumanoidRootPart
                local distance = (hrp.Position - myRoot.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestTarget = hrp
                end
            end
        end
    end
    return nearestTarget
end

-- Hàm tự động bẻ hướng nhân vật (HumanoidRootPart) trong 1 frame khi bấm chiêu
-- Giúp chiêu thức phóng ra tự động đổi hướng về phía địch mà camera vẫn giữ nguyên tự do
local function RedirectAttack()
    if not isAimbotEnabled then return end
    
    local targetPart = GetNearestTarget()
    local myChar = LocalPlayer.Character
    
    if targetPart and myChar and myChar:FindFirstChild("HumanoidRootPart") then
        local hrp = myChar.HumanoidRootPart
        
        -- Lưu lại hướng nhìn cũ của camera (nếu cần) hoặc chỉ xoay ngang nhân vật
        local currentPos = hrp.Position
        local targetPos = Vector3.new(targetPart.Position.X, currentPos.Y, targetPart.Position.Z)
        
        -- Trong tích tắc bấm chiêu, ép nhân vật xoay mặt về phía địch để game tự động tính hướng bay của skill theo mặt nhân vật
        hrp.CFrame = CFrame.new(currentPos, targetPos)
    end
end

-- Bắt sự kiện chạm màn hình (khi bấm vào nút skill trên điện thoại)
UserInputService.TouchStarted:Connect(function(touch, gameProcessed)
    if not isAimbotEnabled then return end
    
    -- Khi bạn chạm tay vào màn hình (để ấn nút đánh/chiêu), hệ thống tự bẻ hướng skill ngầm
    RedirectAttack()
end)

return AimbotModule
