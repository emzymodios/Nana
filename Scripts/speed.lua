-- Speed Control - ĐIỆN THOẠI + PC
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Panel
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 140, 0, 130)
panel.Position = UDim2.new(0.05, 0, 0.3, 0)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = panel

-- Title (dùng để chạm/click)
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.fromRGB(255, 200, 0)
title.TextSize = 11
title.Font = Enum.Font.GothamBold
title.Text = "⚡ SPEED"
title.Parent = panel

-- Input
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

-- Apply Button
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

-- Reset Button
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

local currentSpeed = 50
local isDragging = false
local dragStart = nil
local startPos = nil

-- ✅ KÉO CHO ĐIỆN THOẠI VÀ PC
title.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        startPos = panel.Position
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                       input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        panel.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

-- Apply
applyButton.MouseButton1Click:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then
        currentSpeed = math.max(0, math.min(val, 200))
        speedInput.Text = tostring(currentSpeed)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        wait(0.2)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

-- Reset
resetButton.MouseButton1Click:Connect(function()
    currentSpeed = 50
    speedInput.Text = "50"
end)

-- Update Speed
RunService.RenderStepped:Connect(function()
    if character and humanoid and humanoid.Health > 0 then
        humanoid.WalkSpeed = currentSpeed
    end
end)
