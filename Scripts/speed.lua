-- Simple Toggle Panel UI
-- Đặt script này làm LocalScript, để trong StarterGui (hoặc StarterPlayerScripts nếu bạn để trong PlayerGui từ code)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Xóa UI cũ nếu có, tránh bị trùng khi chạy lại
if player.PlayerGui:FindFirstChild("SimpleToggleGui") then
    player.PlayerGui.SimpleToggleGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SimpleToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Nút bấm để mở/đóng bảng
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.05, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "Mở Bảng"
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleButton

-- Bảng (panel) sẽ hiện/ẩn khi bấm nút
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 300, 0, 200)
panel.Position = UDim2.new(0.05, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
panel.BorderSizePixel = 0
panel.Visible = false -- Ban đầu ẩn
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

-- Logic bật/tắt
local isOpen = false

toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    panel.Visible = isOpen
    toggleButton.Text = isOpen and "Đóng Bảng" or "Mở Bảng"
end)

print("Toggle UI đã load xong!")
