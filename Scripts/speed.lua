-- Speed Control GUI Script - CÓ THỂ KÉO
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

-- Panel chính
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 140, 0, 130)
panel.Position = UDim2.new(0.05, 0, 0.3, 0)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Parent = screenGui

-- UICorner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = panel

-- Tiêu đề (dùng để kéo)
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.TextSize = 11
title.Font = Enum.Font.GothamBold
title.Text = "⚡ SPEED"
title.Parent = panel

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

-- TextBox nhập số
local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(0.9, 0, 0, 22)
speedInput.Position = UDim2.new(0.05, 0, 0.28, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedInput.TextColor3 = Color3.fromRGB(100, 200, 255)
speedInput.TextSize = 12
speedInput.Font = Enum.Font.GothamBold
speedInput.Text = "50"
speedInput.Parent = panel

-- Button Apply
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.44, 0, 0, 20)
applyButton.Position = UDim2.new(0.05, 0, 0.62, 0)
applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 9
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ Apply"
applyButton.Parent = panel

-- Button Reset
local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0.44, 0, 0, 20)
resetButton.Position = UDim2.new(0.51, 0, 0.62, 0)
resetButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextSize = 9
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

-- ✅ KÉO PANEL - FIXED
local mouse = player:GetMouse()

title.MouseButton1Down:Connect(function()
    isDragging = true
    dragStart = mouse.Hit.Position
    startPos = panel.Position
    
    while isDragging do
        local mouseDelta = mouse.Hit.Position - dragStart
        panel.Position = startPos + UDim2.new(0, mouseDelta.X, 0, mouseDelta.Y)
        RunService.RenderStepped:Wait()
    end
end)

title.MouseButton1Up:Connect(function()
    isDragging = false
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
