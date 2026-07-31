-- Speed Control - Nút to + Bấm được
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ✅ NÚT TOGGLE TO HƠN (50x50)
local toggleButton = Instance.new("Frame")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)  -- TO HƠN
toggleButton.Position = UDim2.new(0.02, 0, 0.3, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
toggleButton.BorderSizePixel = 0
toggleButton.Draggable = true
toggleButton.Active = true
toggleButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleButton

-- Icon
local toggleLabel = Instance.new("TextLabel")
toggleLabel.Name = "ToggleLabel"
toggleLabel.Size = UDim2.new(1, 0, 1, 0)
toggleLabel.BackgroundTransparency = 1
toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleLabel.TextSize = 20
toggleLabel.Font = Enum.Font.GothamBold
toggleLabel.Text = "⚡"
toggleLabel.Parent = toggleButton

-- ✅ BẢNG SPEED
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 140, 0, 130)
panel.Position = UDim2.new(0.10, 0, 0.3, 0)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Draggable = true
panel.Active = true
panel.Parent = screenGui
panel.Visible = false

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = panel

-- Title
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
local isOpen = false

-- ✅ BẤM NÚT TOGGLE (FIX)
toggleButton.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        isOpen = not isOpen
        panel.Visible = isOpen
        
        print("Toggle: " .. tostring(isOpen))  -- Debug
        
        if isOpen then
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            toggleLabel.Text = "✓"
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            toggleLabel.Text = "⚡"
        end
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
