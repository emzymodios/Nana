local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa UI cũ nếu tồn tại để tránh bị nhân đôi
if playerGui:FindFirstChild("TogglePanelUI") then
    playerGui:FindFirstChild("TogglePanelUI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TogglePanelUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Nút toggle nhỏ
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.02, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 130, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 24
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "⚡"
toggleButton.BorderSizePixel = 0
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = toggleButton

-- Panel chính
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 350, 0, 320)
panel.Position = UDim2.new(0.02, 0, 0.12, 0)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
panel.BorderSizePixel = 0
panel.Visible = false
panel.Active = true
panel.Draggable = true
panel.Parent = screenGui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 15)
panelCorner.Parent = panel

-- Header panel
local headerPanel = Instance.new("Frame")
headerPanel.Size = UDim2.new(1, 0, 0, 50)
headerPanel.BackgroundColor3 = Color3.fromRGB(40, 80, 180)
headerPanel.BorderSizePixel = 0
headerPanel.Parent = panel

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = headerPanel

-- Title
local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, 0, 1, 0)
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
panelTitle.TextSize = 20
panelTitle.Font = Enum.Font.GothamBold
panelTitle.Text = "⚡ Speed Control"
panelTitle.Parent = headerPanel

-- Separator line
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, 0, 0, 2)
separator.Position = UDim2.new(0, 0, 0, 50)
separator.BackgroundColor3 = Color3.fromRGB(60, 130, 255)
separator.BorderSizePixel = 0
separator.Parent = panel

-- Speed display
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, -20, 0, 45)
speedLabel.Position = UDim2.new(0.05, 0, 0.18, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(100, 220, 255)
speedLabel.TextSize = 32
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Text = "50"
speedLabel.TextXAlignment = Enum.TextXAlignment.Center
speedLabel.Parent = panel

-- Label "Speed"
local speedTextLabel = Instance.new("TextLabel")
speedTextLabel.Size = UDim2.new(1, -20, 0, 20)
speedTextLabel.Position = UDim2.new(0.05, 0, 0.13, 0)
speedTextLabel.BackgroundTransparency = 1
speedTextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
speedTextLabel.TextSize = 12
speedTextLabel.Font = Enum.Font.Gotham
speedTextLabel.Text = "CURRENT SPEED"
speedTextLabel.TextXAlignment = Enum.TextXAlignment.Center
speedTextLabel.Parent = panel

-- Input speed
local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(0.9, 0, 0, 35)
speedInput.Position = UDim2.new(0.05, 0, 0.38, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextSize = 14
speedInput.Font = Enum.Font.Gotham
speedInput.PlaceholderText = "Nhập tốc độ (0-200)"
speedInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
speedInput.Text = "50"
speedInput.Parent = panel

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = speedInput

-- Apply Button
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.4, 0, 0, 35)
applyButton.Position = UDim2.new(0.05, 0, 0.58, 0)
applyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 13
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ APPLY"
applyButton.BorderSizePixel = 0
applyButton.Parent = panel

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 8)
applyCorner.Parent = applyButton

-- Reset Button
local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0.4, 0, 0, 35)
resetButton.Position = UDim2.new(0.55, 0, 0.58, 0)
resetButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextSize = 13
resetButton.Font = Enum.Font.GothamBold
resetButton.Text = "↻ RESET"
resetButton.BorderSizePixel = 0
resetButton.Parent = panel

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 8)
resetCorner.Parent = resetButton

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
statusLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "Nhập số từ 0-200"
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = panel

-- Biến tốc độ
local currentSpeed = 50

-- Hàm cập nhật
local function updateSpeed(newSpeed)
    currentSpeed = math.max(0, math.min(newSpeed, 200))
    speedLabel.Text = tostring(currentSpeed)
    speedInput.Text = tostring(currentSpeed)
    statusLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
    statusLabel.Text = "Speed: " .. currentSpeed
end

-- Toggle panel
local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    panel.Visible = isOpen
    toggleButton.BackgroundColor3 = isOpen and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 130, 255)
end)

-- Apply button
applyButton.MouseButton1Click:Connect(function()
    local inputValue = tonumber(speedInput.Text)
    if inputValue then
        updateSpeed(inputValue)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 220, 120)
        task.wait(0.2)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    else
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        statusLabel.Text = "❌ Nhập số hợp lệ!"
    end
end)

-- Reset button
resetButton.MouseButton1Click:Connect(function()
    updateSpeed(50)
    statusLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    statusLabel.Text = "Reset về 50"
end)

-- Xử lý gán tốc độ an toàn theo từng nhân vật
local function setupCharacter(char)
    local humanoid = char:WaitForChild("Humanoid", 5)
    if humanoid then
        RunService.RenderStepped:Connect(function()
            if char and char.Parent and humanoid and humanoid.Health > 0 then
                humanoid.WalkSpeed = currentSpeed
            end
        end)
    end
end

-- Khởi chạy cho nhân vật hiện tại
if player.Character then
    setupCharacter(player.Character)
end

-- Lắng nghe sự kiện hồi sinh
player.CharacterAdded:Connect(setupCharacter)

print("✅ Speed Control UI đã load thành công!")
