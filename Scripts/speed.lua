local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Tạo ScreenGui chứa giao diện
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedControlGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Tạo khung chính (Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 150)
mainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Giúp kéo thả khung giao diện
mainFrame.Parent = screenGui

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.SourceSansBold
title.Text = "Bảng Điều Khóa Tốc Độ"
title.Parent = mainFrame

-- Nút Bật/Tắt Speed
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
toggleBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 14
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Speed: OFF"
toggleBtn.Parent = mainFrame

-- Ô nhập tốc độ (hoặc hiển thị số)
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.9, 0, 0, 35)
speedBox.Position = UDim2.new(0.05, 0, 0.6, 0)
speedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.TextSize = 14
speedBox.Font = Enum.Font.SourceSans
speedBox.Text = "50" -- Tốc độ mặc định khi nhập
speedBox.PlaceholderText = "Nhập tốc độ rồi Enter"
speedBox.Parent = mainFrame

-- Logic xử lý tính năng
local speedEnabled = false
local currentSpeed = 50

toggleBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        toggleBtn.Text = "Speed: ON"
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        toggleBtn.Text = "Speed: OFF"
        -- Trả lại tốc độ mặc định (16)
        local char = localPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

speedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local num = tonumber(speedBox.Text)
        if num then
            currentSpeed = num
        else
            speedBox.Text = tostring(currentSpeed)
        end
    end
end)

-- Vòng lặp cập nhật tốc độ liên tục
game:GetService("RunService").Stepped:Connect(function()
    if speedEnabled then
        local char = localPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = currentSpeed
        end
    end
end)
