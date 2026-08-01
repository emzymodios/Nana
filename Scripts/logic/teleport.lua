-- logic/teleport.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local TeleportModule = {}
local selectedTargetName = nil
local isFlyingToTarget = false
local flyConnection = nil

-- Thiết lập tên người chơi mục tiêu
function TeleportModule.SetTarget(name)
    selectedTargetName = name
end

-- Dừng bay và mở khóa vật lý nhân vật
function TeleportModule.StopFly()
    isFlyingToTarget = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Anchored = false
    end
end

-- Bắt đầu vòng lặp bay bám sát người chơi liên tục (Dạng Toggle)
function TeleportModule.StartContinuousFly(speed)
    if isFlyingToTarget or not selectedTargetName then return end
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = char.HumanoidRootPart
    isFlyingToTarget = true
    rootPart.Anchored = true -- Khóa trọng lực để bay mượt mà
    
    local flySpeed = speed or 100

    flyConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not isFlyingToTarget then 
            TeleportModule.StopFly()
            return 
        end

        local targetPlayer = Players:FindFirstChild(selectedTargetName)
        -- Kiểm tra an toàn: Nếu target rời game hoặc mất nhân vật
        if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            TeleportModule.StopFly()
            return
        end
        
        local targetChar = targetPlayer.Character
        local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
        -- Kiểm tra an toàn: Nếu target chết (máu <= 0) thì tự động dừng bay
        if humanoid and humanoid.Health <= 0 then
            TeleportModule.StopFly()
            return
        end

        local targetRoot = targetChar.HumanoidRootPart
        -- Tính toán vị trí bám sát phía sau mục tiêu
        local targetCFrame = targetRoot.CFrame * CFrame.new(0, 3, -3) 
        local currentCFrame = rootPart.CFrame
        
        local distance = (targetCFrame.Position - currentCFrame.Position).Magnitude
        
        -- Nếu đã đến rất gần, giữ vị trí đồng bộ với mục tiêu
        if distance < 3 then
            rootPart.CFrame = targetCFrame
        else
            local moveStep = math.min(flySpeed * deltaTime, distance)
            rootPart.CFrame = currentCFrame:Lerp(targetCFrame, moveStep / distance)
        end
    end)
end

-- Hàm tương thích cũ (nếu gọi dạng bấm nút đơn một lần)
function TeleportModule.FlyToTarget()
    TeleportModule.StartContinuousFly(100)
end

return TeleportModule
