-- Nana 1.0 - SIMPLE TEST
local player = game:GetService("Players").LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NanaGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ✅ NÚT ICON
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.02, 0, 0.05, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 20
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Text = "⚡"
toggleBtn.BorderSizePixel = 0
toggleBtn.Draggable = true
toggleBtn.Active = true
toggleBtn.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleBtn

-- ✅ BẢNG MENU (Ban đầu ẩn)
local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Size = UDim2.new(0, 400, 0, 450)
menu.Position = UDim2.new(0.1, 0, 0.15, 0)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
menu.BorderSizePixel = 0
menu.Draggable = true
menu.Active = true
menu.Visible = false  -- ẨN LÚC ĐẦU
menu.Parent = screenGui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 15)
menuCorner.Parent = menu

-- Header
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.TextSize = 18
header.Font = Enum.Font.GothamBold
header.Text = "Nana 1.0 by phuoc"
header.BorderSizePixel = 0
header.Parent = menu

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "✕"
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 10, 0, 60)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Text = "🏃 Run Speed"
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu

-- Toggle 1
local toggle1Bg = Instance.new("Frame")
toggle1Bg.Size = UDim2.new(0.9, 0, 0, 50)
toggle1Bg.Position = UDim2.new(0.05, 0, 0, 110)
toggle1Bg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
toggle1Bg.BorderSizePixel = 0
toggle1Bg.Parent = menu

local t1Corner = Instance.new("UICorner")
t1Corner.CornerRadius = UDim.new(0, 8)
t1Corner.Parent = toggle1Bg

local t1Label = Instance.new("TextLabel")
t1Label.Size = UDim2.new(0.6, 0, 1, 0)
t1Label.BackgroundTransparency = 1
t1Label.TextColor3 = Color3.fromRGB(255, 255, 255)
t1Label.TextSize = 12
t1Label.Font = Enum.Font.GothamBold
t1Label.Text = "🏃 Run Speed"
t1Label.TextXAlignment = Enum.TextXAlignment.Left
t1Label.Parent = toggle1Bg

local t1Switch = Instance.new("Frame")
t1Switch.Size = UDim2.new(0, 50, 0, 30)
t1Switch.Position = UDim2.new(0.65, 0, 0.1, 0)
t1Switch.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
t1Switch.BorderSizePixel = 0
t1Switch.Parent = toggle1Bg

local t1SwitchCorner = Instance.new("UICorner")
t1SwitchCorner.CornerRadius = UDim.new(0, 15)
t1SwitchCorner.Parent = t1Switch

local t1Circle = Instance.new("Frame")
t1Circle.Size = UDim2.new(0, 26, 0, 26)
t1Circle.Position = UDim2.new(0, 2, 0.5, -13)
t1Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
t1Circle.BorderSizePixel = 0
t1Circle.Parent = t1Switch

local t1CircleCorner = Instance.new("UICorner")
t1CircleCorner.CornerRadius = UDim.new(1, 0)
t1CircleCorner.Parent = t1Circle

local t1State = false
local t1ClickArea = Instance.new("TextButton")
t1ClickArea.Size = UDim2.new(1, 0, 1, 0)
t1ClickArea.BackgroundTransparency = 1
t1ClickArea.Text = ""
t1ClickArea.Parent = t1Switch

t1ClickArea.MouseButton1Click:Connect(function()
    t1State = not t1State
    if t1State then
        t1Circle:TweenPosition(UDim2.new(0, 22, 0.5, -13), "Out", "Quad", 0.2, true)
        t1Switch:TweenColor3(Color3.fromRGB(50, 150, 255), "Out", "Quad", 0.2, true)
        print("✅ Run Speed ON")
    else
        t1Circle:TweenPosition(UDim2.new(0, 2, 0.5, -13), "Out", "Quad", 0.2, true)
        t1Switch:TweenColor3(Color3.fromRGB(100, 100, 120), "Out", "Quad", 0.2, true)
        print("❌ Run Speed OFF")
    end
end)

-- Toggle 2
local toggle2Bg = Instance.new("Frame")
toggle2Bg.Size = UDim2.new(0.9, 0, 0, 50)
toggle2Bg.Position = UDim2.new(0.05, 0, 0, 170)
toggle2Bg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
toggle2Bg.BorderSizePixel = 0
toggle2Bg.Parent = menu

local t2Corner = Instance.new("UICorner")
t2Corner.CornerRadius = UDim.new(0, 8)
t2Corner.Parent = toggle2Bg

local t2Label = Instance.new("TextLabel")
t2Label.Size = UDim2.new(0.6, 0, 1, 0)
t2Label.BackgroundTransparency = 1
t2Label.TextColor3 = Color3.fromRGB(255, 255, 255)
t2Label.TextSize = 12
t2Label.Font = Enum.Font.GothamBold
t2Label.Text = "✈️ Fly"
t2Label.TextXAlignment = Enum.TextXAlignment.Left
t2Label.Parent = toggle2Bg

local t2Switch = Instance.new("Frame")
t2Switch.Size = UDim2.new(0, 50, 0, 30)
t2Switch.Position = UDim2.new(0.65, 0, 0.1, 0)
t2Switch.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
t2Switch.BorderSizePixel = 0
t2Switch.Parent = toggle2Bg

local t2SwitchCorner = Instance.new("UICorner")
t2SwitchCorner.CornerRadius = UDim.new(0, 15)
t2SwitchCorner.Parent = t2Switch

local t2Circle = Instance.new("Frame")
t2Circle.Size = UDim2.new(0, 26, 0, 26)
t2Circle.Position = UDim2.new(0, 2, 0.5, -13)
t2Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
t2Circle.BorderSizePixel = 0
t2Circle.Parent = t2Switch

local t2CircleCorner = Instance.new("UICorner")
t2CircleCorner.CornerRadius = UDim.new(1, 0)
t2CircleCorner.Parent = t2Circle

local t2State = false
local t2ClickArea = Instance.new("TextButton")
t2ClickArea.Size = UDim2.new(1, 0, 1, 0)
t2ClickArea.BackgroundTransparency = 1
t2ClickArea.Text = ""
t2ClickArea.Parent = t2Switch

t2ClickArea.MouseButton1Click:Connect(function()
    t2State = not t2State
    if t2State then
        t2Circle:TweenPosition(UDim2.new(0, 22, 0.5, -13), "Out", "Quad", 0.2, true)
        t2Switch:TweenColor3(Color3.fromRGB(50, 150, 255), "Out", "Quad", 0.2, true)
        print("✅ Fly ON")
    else
        t2Circle:TweenPosition(UDim2.new(0, 2, 0.5, -13), "Out", "Quad", 0.2, true)
        t2Switch:TweenColor3(Color3.fromRGB(100, 100, 120), "Out", "Quad", 0.2, true)
        print("❌ Fly OFF")
    end
end)

-- Toggle 3
local toggle3Bg = Instance.new("Frame")
toggle3Bg.Size = UDim2.new(0.9, 0, 0, 50)
toggle3Bg.Position = UDim2.new(0.05, 0, 0, 230)
toggle3Bg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
toggle3Bg.BorderSizePixel = 0
toggle3Bg.Parent = menu

local t3Corner = Instance.new("UICorner")
t3Corner.CornerRadius = UDim.new(0, 8)
t3Corner.Parent = toggle3Bg

local t3Label = Instance.new("TextLabel")
t3Label.Size = UDim2.new(0.6, 0, 1, 0)
t3Label.BackgroundTransparency = 1
t3Label.TextColor3 = Color3.fromRGB(255, 255, 255)
t3Label.TextSize = 12
t3Label.Font = Enum.Font.GothamBold
t3Label.Text = "👻 NoClip"
t3Label.TextXAlignment = Enum.TextXAlignment.Left
t3Label.Parent = toggle3Bg

local t3Switch = Instance.new("Frame")
t3Switch.Size = UDim2.new(0, 50, 0, 30)
t3Switch.Position = UDim2.new(0.65, 0, 0.1, 0)
t3Switch.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
t3Switch.BorderSizePixel = 0
t3Switch.Parent = toggle3Bg

local t3SwitchCorner = Instance.new("UICorner")
t3SwitchCorner.CornerRadius = UDim.new(0, 15)
t3SwitchCorner.Parent = t3Switch

local t3Circle = Instance.new("Frame")
t3Circle.Size = UDim2.new(0, 26, 0, 26)
t3Circle.Position = UDim2.new(0, 2, 0.5, -13)
t3Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
t3Circle.BorderSizePixel = 0
t3Circle.Parent = t3Switch

local t3CircleCorner = Instance.new("UICorner")
t3CircleCorner.CornerRadius = UDim.new(1, 0)
t3CircleCorner.Parent = t3Circle

local t3State = false
local t3ClickArea = Instance.new("TextButton")
t3ClickArea.Size = UDim2.new(1, 0, 1, 0)
t3ClickArea.BackgroundTransparency = 1
t3ClickArea.Text = ""
t3ClickArea.Parent = t3Switch

t3ClickArea.MouseButton1Click:Connect(function()
    t3State = not t3State
    if t3State then
        t3Circle:TweenPosition(UDim2.new(0, 22, 0.5, -13), "Out", "Quad", 0.2, true)
        t3Switch:TweenColor3(Color3.fromRGB(50, 150, 255), "Out", "Quad", 0.2, true)
        print("✅ NoClip ON")
    else
        t3Circle:TweenPosition(UDim2.new(0, 2, 0.5, -13), "Out", "Quad", 0.2, true)
        t3Switch:TweenColor3(Color3.fromRGB(100, 100, 120), "Out", "Quad", 0.2, true)
        print("❌ NoClip OFF")
    end
end)

-- ✅ TOGGLE MENU
local menuOpen = false
toggleBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    menu.Visible = menuOpen
    
    if menuOpen then
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        toggleBtn.Text = "✓"
        print("📋 Menu ON")
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        toggleBtn.Text = "⚡"
        print("📋 Menu OFF")
    end
end)

-- ✅ CLOSE BUTTON
closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
    menuOpen = false
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
    toggleBtn.Text = "⚡"
end)

print("✅ Nana 1.0 loaded - Bấm nút ⚡ để mở menu!")
