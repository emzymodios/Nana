-- Nana 1.0 by phuoc - UI WITH TOGGLE SWITCH
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
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

-- ✅ SIDEBAR (MENU BÊN TRÁI)
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 110, 0, 400)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainPanel

-- Menu items
local menuItems = {
    {name = "Home", icon = "🏠"},
    {name = "Run Speed", icon = "🏃"},
    {name = "Fly", icon = "✈️"},
    {name = "NoClip", icon = "👻"},
}

for i, item in ipairs(menuItems) do
    local menuButton = Instance.new("TextButton")
    menuButton.Name = item.name
    menuButton.Size = UDim2.new(1, 0, 0, 50)
    menuButton.Position = UDim2.new(0, 0, 0, (i-1) * 50)
    menuButton.BackgroundColor3 = (i == 1) and Color3.fromRGB(50, 100, 255) or Color3.fromRGB(20, 20, 30)
    menuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    menuButton.TextSize = 11
    menuButton.Font = Enum.Font.GothamBold
    menuButton.Text = item.icon .. "\n" .. item.name
    menuButton.BorderSizePixel = 0
    menuButton.Parent = sidebar
    
    -- Onclick select
    menuButton.MouseButton1Click:Connect(function()
        for _, btn in ipairs(sidebar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            end
        end
        menuButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
    end)
end

-- ✅ CONTENT AREA (BÊN PHẢI)
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(0, 290, 0, 400)
contentArea.Position = UDim2.new(0, 110, 0, 50)
contentArea.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
contentArea.BorderSizePixel = 0
contentArea.Parent = mainPanel

-- Content Title
local contentTitle = Instance.new("TextLabel")
contentTitle.Name = "ContentTitle"
contentTitle.Size = UDim2.new(1, 0, 0, 40)
contentTitle.Position = UDim2.new(0, 0, 0, 10)
contentTitle.BackgroundTransparency = 1
contentTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
contentTitle.TextSize = 16
contentTitle.Font = Enum.Font.GothamBold
contentTitle.Text = "🏃 Run Speed"
contentTitle.Parent = contentArea

-- ✅ FUNCTION TẠO TOGGLE SWITCH
local function createToggleSwitch(parent, yPos, label)
    local container = Instance.new("Frame")
    container.Name = "ToggleContainer"
    container.Size = UDim2.new(0.9, 0, 0, 50)
    container.Position = UDim2.new(0.05, 0, 0, yPos)
    container.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container
    
    -- Label
    local labelText = Instance.new("TextLabel")
    labelText.Name = "Label"
    labelText.Size = UDim2.new(0.6, 0, 1, 0)
    labelText.BackgroundTransparency = 1
    labelText.TextColor3 = Color3.fromRGB(255, 255, 255)
    labelText.TextSize = 12
    labelText.Font = Enum.Font.GothamBold
    labelText.Text = label
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.Parent = container
    
    -- Toggle Background
    local toggleBg = Instance.new("Frame")
    toggleBg.Name = "ToggleBg"
    toggleBg.Size = UDim2.new(0, 50, 0, 30)
    toggleBg.Position = UDim2.new(0.65, 0, 0.1, 0)
    toggleBg.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = container
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 15)
    bgCorner.Parent = toggleBg
    
    -- Toggle Circle (hình tròn trượt)
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "ToggleCircle"
    toggleCircle.Size = UDim2.new(0, 26, 0, 26)
    toggleCircle.Position = UDim2.new(0, 2, 0.5, -13)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBg
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    -- Toggle state
    local isToggled = false
    
    -- Click để toggle
    toggleBg.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        
        if isToggled then
            -- Bật - hình tròn sang phải, nền xanh
            toggleCircle:TweenPosition(UDim2.new(0, 22, 0.5, -13), "Out", "Quad", 0.2, true)
            toggleBg:TweenColor3(Color3.fromRGB(50, 150, 255), "Out", "Quad", 0.2, true)
        else
            -- Tắt - hình tròn sang trái, nền xám
            toggleCircle:TweenPosition(UDim2.new(0, 2, 0.5, -13), "Out", "Quad", 0.2, true)
            toggleBg:TweenColor3(Color3.fromRGB(100, 100, 120), "Out", "Quad", 0.2, true)
        end
    end)
    
    -- Make toggleBg clickable
    toggleBg.Selectable = true
    toggleBg.Active = true
    
    return container, isToggled
end

-- ✅ TẠO 3 TOGGLE SWITCHES
local toggle1, state1 = createToggleSwitch(contentArea, 60, "🏃 Run Speed")
local toggle2, state2 = createToggleSwitch(contentArea, 130, "✈️ Fly")
local toggle3, state3 = createToggleSwitch(contentArea, 200, "👻 NoClip")

-- ✅ SPEED CONTROL BOX (SẼ HIỂN THỊ KHI BẬT CHỨC NĂNG)
local speedControlBox = Instance.new("Frame")
speedControlBox.Name = "SpeedControl"
speedControlBox.Size = UDim2.new(0.9, 0, 0, 80)
speedControlBox.Position = UDim2.new(0.05, 0, 0, 280)
speedControlBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
speedControlBox.BorderSizePixel = 0
speedControlBox.Parent = contentArea

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedControlBox

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 10, 0, 5)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 10
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Speed:"
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = speedControlBox

-- Speed Input
local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
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

-- Apply Button
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.9, 0, 0, 20)
applyButton.Position = UDim2.new(0.05, 0, 0, 55)
applyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 10
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ Apply"
applyButton.BorderSizePixel = 0
applyButton.Parent = speedControlBox

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 6)
applyCorner.Parent = applyButton

-- ✅ TOGGLE MENU BẰNG NÚT ICON (FIX)
local menuOpen = false

-- Tạo nút bấm thực sự
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleBtn"
toggleButton.Size = UDim2.new(1, 0, 1, 0)
toggleButton.BackgroundTransparency = 1
toggleButton.BorderSizePixel = 0
toggleButton.Text = ""
toggleButton.Parent = toggleIconButton

toggleButton.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainPanel.Visible = menuOpen
    
    if menuOpen then
        toggleIconButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        iconLabel.Text = "✓"
        print("Menu ON")
    else
        toggleIconButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        iconLabel.Text = "⚡"
        print("Menu OFF")
    end
end)

-- ✅ CLOSE BUTTON
closeButton.MouseButton1Click:Connect(function()
    mainPanel.Visible = false
    menuOpen = false
    toggleIconButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
    iconLabel.Text = "⚡"
end)

-- ✅ APPLY BUTTON EVENT
applyButton.MouseButton1Click:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then
        speedInput.Text = tostring(math.max(10, math.min(val, 200)))
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        wait(0.3)
        applyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    end
end)

print("✅ Nana 1.0 UI loaded!")
