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

-- Nút bấm để mở/đóng bảng (dạng ô vuông có icon)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.05, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 22
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "⚡" -- Icon, có thể đổi thành icon khác
toggleButton.BorderSizePixel = 0
toggleButton.Active = true
toggleButton.Draggable = true -- Cho phép kéo di chuyển nút
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleButton

-- Bảng (panel) sẽ hiện/ẩn khi bấm nút
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 300, 0, 200)
panel.Position = UDim2.new(0.05, 0, 0.15, 0)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
panel.BorderSizePixel = 0
panel.Visible = false -- Ban đầu ẩn
panel.Active = true
panel.Draggable = true -- Cho phép kéo di chuyển bảng
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
    -- Đổi màu nút để biết trạng thái đang mở hay đóng, icon giữ nguyên
    toggleButton.BackgroundColor3 = isOpen and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 100, 255)
end)

print("Toggle UI đã load xong!")
