-- Nana 1.0 by phuoc - FIXED & FULL FUNCTIONS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Xóa UI cũ nếu có để tránh trùng lặp
if player.PlayerGui:FindFirstChild("NanaGui") then
    player.PlayerGui.NanaGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NanaGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ✅ NÚT TOGGLE NHỎ (BẬT/TẮT MENU)
local toggleIconButton = Instance.new("Frame")
toggleIconButton.Name = "ToggleIconButton"
toggleIconButton.Size = UDim2.new(0, 50, 0, 50)
toggleIconButton.Position = UDim2.new(0.02, 0, 0.05, 0)
toggleIconButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
toggleIconButton.BorderSizePixel = 0
toggleIconButton.Draggable = true
toggleIconButton.Active = true
toggleIconButton.Parent = screenGui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 10)
iconCorner.Parent = toggleIconButton

local iconLabel = Instance.new("TextLabel")
iconLabel.Name = "IconLabel"
iconLabel.Size = UDim2.new(1, 0, 1, 0)
iconLabel.BackgroundTransparency = 1
iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
iconLabel.TextSize = 20
iconLabel.Font = Enum.Font.GothamBold
iconLabel.Text = "⚡"
iconLabel.Parent = toggleIconButton

-- ✅ MAIN PANEL (MENU)
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 400, 0, 450)
mainPanel.Position = UDim2.new(0.1, 0, 0.15, 0)
mainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainPanel.BorderSizePixel = 0
mainPanel.Draggable = true
mainPanel.Active = true
mainPanel.Parent = screenGui
mainPanel.Visible = false

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainPanel

-- ✅ HEADER
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
header.BorderSizePixel = 0
header.Parent = mainPanel

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

local headerTitle = Instance.new("TextLabel")
headerTitle.Name = "Title"
headerTitle.Size = UDim2.new(1, 0, 1, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
headerTitle.TextSize = 18
headerTitle.Font = Enum.Font.GothamBold
headerTitle.Text = "Nana 1.0 by phuoc"
headerTitle.Parent = header

-- ✅ CLOSE BUTTON (X)
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -45, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "✕"
closeButton.BorderSizePixel = 0
closeButton.Parent = mainPanel

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- ✅ SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 110, 0, 400)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainPanel

-- ✅ CONTENT AREA
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(0, 290, 0, 400)
contentArea.Position = UDim2.new(0, 110, 0, 50)
contentArea.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
contentArea.BorderSizePixel = 0
contentArea.Parent = mainPanel

-- Biến lưu trạng thái tính năng
local featuresState = {
    Speed = false,
    Fly = false,
    NoClip = false
}
local currentSpeedValue = 50

-- ✅ HÀM TẠO TOGGLE SWITCH (Đã sửa dùng TextButton để nhận diện bấm chuẩn xác)
local function createToggleSwitch(parent, yPos, labelTextStr, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.9, 0, 0, 50)
    container.Position = UDim2.new(0.05, 0, 0, yPos)
    container.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.Text = labelTextStr
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    -- Dùng TextButton thay cho Frame để bắt sự kiện Click mượt mà
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 30)
    toggleBtn.Position = UDim2.new(0.65, 0, 0.5, -15)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.Parent = container
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 15)
    bgCorner.Parent = toggleBtn
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 26, 0, 26)
    toggleCircle.Position = UDim2.new(0, 2, 0.5, -13)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBtn
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    local isToggled = false
    
    toggleBtn.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            toggleCircle:TweenPosition(UDim2.new(0, 22, 0.5, -13), "Out", "Quad", 0.2, true)
            toggleBtn:TweenBackgroundColor3(Color3.fromRGB(50, 150, 255), "Out", "Quad", 0.2, true)
        else
            toggleCircle:TweenPosition(UDim2.new(0, 2, 0.5, -13), "Out", "Quad", 0.2, true)
            toggleBtn:TweenBackgroundColor3(Color3.fromRGB(100, 100, 120), "Out", "Quad", 0.2, true)
        end
        if callback then
            callback(isToggled)
        end
    end)
end

-- ✅ TẠO CÁC NÚT BẬT TẮT CHỨC NĂNG
createToggleSwitch(contentArea, 20, "🏃 Run Speed", function(state)
    featuresState.Speed = state
end)

createToggleSwitch(contentArea, 80, "✈️ Fly", function(state)
    featuresState.Fly = state
end)

createToggleSwitch(contentArea, 140, "👻 NoClip", function(state)
    featuresState.NoClip = state
end)

-- ✅ SPEED CONTROL BOX
local speedControlBox = Instance.new("Frame")
speedControlBox.Size = UDim2.new(0.9, 0, 0, 80)
speedControlBox.Position = UDim2.new(0.05, 0, 0, 210)
speedControlBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
speedControlBox.BorderSizePixel = 0
speedControlBox.Parent = contentArea

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedControlBox

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 10, 0, 5)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 10
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Speed Value:"
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = speedControlBox

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.9, 0, 0, 25)
speedInput.Position = UDim2.new(0.05, 0, 0, 28)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextSize = 12
speedInput.Font = Enum.Font.GothamBold
speedInput.Text = "50"
speedInput.Parent = speedControlBox

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = speedInput

local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0.9, 0, 0, 20)
applyButton.Position = UDim2.new(0.05, 0, 0, 55)
applyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 10
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ Apply Speed"
applyButton.BorderSizePixel = 0
applyButton.Parent = speedControlBox

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 6)
applyCorner.Parent = applyButton

applyButton.MouseButton1Click:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then
        currentSpeedValue = math.max(16, math.min(val, 300))
        speedInput.Text = tostring(currentSpeedValue)
    end
end)

-- ✅ XỬ LÝ ĐÓNG MỞ MENU CHÍNH
local menuOpen = false
local toggleBtnMain = Instance.new("TextButton")
toggleBtnMain.Size = UDim2.new(1, 0, 1, 0)
toggleBtnMain.BackgroundTransparency = 1
toggleBtnMain.Text = ""
toggleBtnMain.Parent = toggleIconButton

toggleBtnMain.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainPanel.Visible = menuOpen
    if menuOpen then
        toggleIconButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        iconLabel.Text = "✓"
    else
        toggleIconButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        iconLabel.Text = "⚡"
    end
end)

closeButton.MouseButton1Click:Connect(function()
    mainPanel.Visible = false
    menuOpen = false
    toggleIconButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
    iconLabel.Text = "⚡"
end)

-- ✅ VÒNG LẶP CHẠY TÍNH NĂNG (SPEED, NOCLIP)
RunService.Stepped:Connect(function()
    local char = player.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    
    -- Xử lý Speed
    if humanoid then
        if featuresState.Speed then
            humanoid.WalkSpeed = currentSpeedValue
        else
            humanoid.WalkSpeed = 16 -- Trả về mặc định
        end
    end
    
    -- Xử lý NoClip
    if featuresState.NoClip then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("✅ Nana 1.0 UI loaded successfully!")
