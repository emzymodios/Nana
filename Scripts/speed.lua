local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Xóa UI cũ nếu tồn tại
if playerGui:FindFirstChild("TogglePanelUI") then
    playerGui:FindFirstChild("TogglePanelUI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TogglePanelUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Nút toggle
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.05, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 22
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "⚡"
toggleButton.BorderSizePixel = 0
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleButton

-- Panel
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 300, 0, 280)
panel.Position = UDim2.new(0.05, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
panel.BorderSizePixel = 0
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = panel

-- Title
local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, 0, 0, 40)
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
panelTitle.TextSize = 18
panelTitle.Font = Enum.Font.GothamBold
panelTitle.Text = "Speed Control"
panelTitle.Parent = panel

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(0.8, 0, 0, 25)
speedLabel.Position = UDim2.new(0.1, 0, 0.22, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Speed: 50"
speedLabel.Parent = panel

-- Speed Input
local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(0.8, 0, 0, 25)
speedInput.Position = UDim2.new(0.1, 0, 0.42, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextSize = 12
speedInput.Font = Enum.Font.Gotham
speedInput.PlaceholderText = "Nhập số..."
speedInput.Text = "50"
speedInput.Parent = panel

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = speedInput

-- Apply Button
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.35, 0, 0, 25)
applyButton.Position = UDim2.new(0.1, 0, 0.62, 0)
applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 11
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ Apply"
applyButton.Parent = panel

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 6)
applyCorner.Parent = applyButton

-- Reset Button
local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0.35, 0, 0, 25)
resetButton.Position = UDim2.new(0.55, 0, 0.62, 0)
resetButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextSize = 11
resetButton.Font = Enum.Font.GothamBold
resetButton.Text = "✕ Reset"
resetButton.Parent = panel

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 6)
resetCorner.Parent = resetButton

-- Biến tốc độ
local currentSpeed = 50

-- Hàm cập nhật tốc độ
local function updateSpeed(newSpeed)
    currentSpeed = math.max(0, math.min(newSpeed, 200)) -- Giới hạn 0-200
    speedLabel.Text = "Speed: " .. currentSpeed
    speedInput.Text = tostring(currentSpeed)
end

-- Toggle panel
local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    panel.Visible = isOpen
    toggleButton.BackgroundColor3 = isOpen and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 100, 255)
end)

-- Apply Button Event
applyButton.MouseButton1Click:Connect(function()
    local inputValue = tonumber(speedInput.Text)
    if inputValue then
        updateSpeed(inputValue)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        task.wait(0.3)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

-- Reset Button Event
resetButton.MouseButton1Click:Connect(function()
    updateSpeed(50)
end)

-- Cập nhật WalkSpeed trong game
RunService.RenderStepped:Connect(function()
    if character and humanoid and humanoid.Health > 0 then
        humanoid.WalkSpeed = currentSpeed
    end
end)

-- Cập nhật character khi respawn
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
end)

print("✅ Speed Control UI đã load!")
