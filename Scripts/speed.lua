local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Kiểm tra xem UI đã tồn tại chưa
if playerGui:FindFirstChild("TogglePanelUI") then
    playerGui:FindFirstChild("TogglePanelUI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TogglePanelUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Nút bấm
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
panel.Size = UDim2.new(0, 300, 0, 200)
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

local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, 0, 0, 40)
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
panelTitle.TextSize = 18
panelTitle.Font = Enum.Font.GothamBold
panelTitle.Text = "Đây là bảng của bạn"
panelTitle.Parent = panel

-- Logic toggle
local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    panel.Visible = isOpen
    toggleButton.BackgroundColor3 = isOpen and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 100, 255)
end)
