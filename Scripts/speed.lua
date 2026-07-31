-- Speed Control GUI Script - Mini Version
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Panel chính (NHỎ HƠN)
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 140, 0, 130)  -- Nhỏ hơn
panel.Position = UDim2.new(0.05, 0, 0.3, 0)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Parent = screenGui

-- UICorner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = panel

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.TextSize = 11
title.Font = Enum.Font.GothamBold
title.Text = "⚡ SPEED"
title.Parent = panel

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

-- TextBox nhập số (lớn hơn một chút để dễ nhập)
local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(0.9, 0, 0, 25)
speedInput.Position = UDim2.new(0.05, 0, 0.25, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedInput.TextColor3 = Color3.fromRGB(100, 200, 255)
speedInput.TextSize = 12
speedInput.Font = Enum.Font.GothamBold
speedInput.PlaceholderText = "50"
speedInput.Text = "50"
speedInput.Parent = panel

-- Button Apply (nửa trái)
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.44, 0, 0, 22)
applyButton.Position = UDim2.new(0.05, 0, 0.58, 0)
applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 10
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ Apply"
applyButton.Parent = panel

-- Button Reset (nửa phải)
local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0.44, 0, 0, 22)
resetButton.Position = UDim2.new(0.51, 0, 0.58, 0)
resetButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextSize = 10
resetButton.Font = Enum.Font.GothamBold
resetButton.Text = "✕ Reset"
resetButton.Parent = panel

-- Biến tốc độ
local currentSpeed = 50
local isDragging = false
local dragStart = nil
local startPos = nil

-- Hàm cập nhật tốc độ
local function updateSpeed(newSpeed)
    currentSpeed = math.max(0, math.min(newSpeed, 200))
    speedInput.Text = tostring(currentSpeed)
end

-- ✅ KÉO PANEL (FIX)
title.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        panel.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- Button Events
applyButton.MouseButton1Click:Connect(function()
    local inputValue = tonumber(speedInput.Text)
    if inputValue then
        updateSpeed(inputValue)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        wait(0.2)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

resetButton.MouseButton1Click:Connect(function()
    updateSpeed(50)
end)

-- Áp dụng tốc độ
RunService.RenderStepped:Connect(function()
    if character and humanoid and humanoid.Health > 0 then
        humanoid.WalkSpeed = currentSpeed
    end
end)
