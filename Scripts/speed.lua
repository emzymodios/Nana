-- Nana 1.0 by phuoc (Với nút Toggle Icon)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ✅ BIẾN CHỨC NĂNG
local speedEnabled = false
local flyEnabled = false
local noclipEnabled = false
local currentSpeed = 50
local currentFlySpeed = 50
local flyConnection = nil
local noclipConnection = nil
local menuOpen = false

-- GUI CHÍNH
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NanaGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ✅ NÚT TOGGLE ICON (Nhỏ - Bên trái trên)
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

-- ✅ BACKGROUND PANEL (Menu chính - Ban đầu ẩn)
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0, 350, 0, 400)
mainPanel.Position = UDim2.new(0.1, 0, 0.2, 0)
mainPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainPanel.BorderSizePixel = 0
mainPanel.Draggable = true
mainPanel.Active = true
mainPanel.Parent = screenGui
mainPanel.Visible = false  -- ẨN LÚC ĐẦU

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainPanel

-- ✅ HEADER
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
header.BorderSizePixel = 0
header.Parent = mainPanel

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local headerTitle = Instance.new("TextLabel")
headerTitle.Name = "Title"
headerTitle.Size = UDim2.new(1, 0, 1, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
headerTitle.TextSize = 16
headerTitle.Font = Enum.Font.GothamBold
headerTitle.Text = "Nana 1.0 by phuoc"
headerTitle.Parent = header

-- ✅ SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 100, 0, 350)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
sidebar.BorderSizePixel = 0
sidebar.Parent = mainPanel

local mainMenu = Instance.new("TextButton")
mainMenu.Name = "MainMenu"
mainMenu.Size = UDim2.new(1, 0, 0, 40)
mainMenu.Position = UDim2.new(0, 0, 0, 0)
mainMenu.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
mainMenu.TextColor3 = Color3.fromRGB(255, 255, 255)
mainMenu.TextSize = 12
mainMenu.Font = Enum.Font.GothamBold
mainMenu.Text = "📋 Main"
mainMenu.BorderSizePixel = 0
mainMenu.Parent = sidebar

-- ✅ CONTENT AREA
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(0, 250, 0, 350)
contentArea.Position = UDim2.new(0, 100, 0, 50)
contentArea.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
contentArea.BorderSizePixel = 0
contentArea.Parent = mainPanel

local contentTitle = Instance.new("TextLabel")
contentTitle.Name = "ContentTitle"
contentTitle.Size = UDim2.new(1, 0, 0, 30)
contentTitle.Position = UDim2.new(0, 0, 0, 0)
contentTitle.BackgroundTransparency = 1
contentTitle.TextColor3 = Color3.fromRGB(100, 200, 255)
contentTitle.TextSize = 14
contentTitle.Font = Enum.Font.GothamBold
contentTitle.Text = "Main"
contentTitle.Parent = contentArea

-- ✅ TOGGLE BUTTON 1 - RUN SPEED
local runSpeedToggle = Instance.new("TextButton")
runSpeedToggle.Name = "RunSpeedToggle"
runSpeedToggle.Size = UDim2.new(0, 220, 0, 40)
runSpeedToggle.Position = UDim2.new(0, 15, 0, 40)
runSpeedToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
runSpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
runSpeedToggle.TextSize = 12
runSpeedToggle.Font = Enum.Font.GothamBold
runSpeedToggle.Text = "🏃 Run Speed [OFF]"
runSpeedToggle.BorderSizePixel = 0
runSpeedToggle.Parent = contentArea

local runSpeedCorner = Instance.new("UICorner")
runSpeedCorner.CornerRadius = UDim.new(0, 6)
runSpeedCorner.Parent = runSpeedToggle

-- ✅ TOGGLE BUTTON 2 - FLY
local flyToggle = Instance.new("TextButton")
flyToggle.Name = "FlyToggle"
flyToggle.Size = UDim2.new(0, 220, 0, 40)
flyToggle.Position = UDim2.new(0, 15, 0, 90)
flyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
flyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggle.TextSize = 12
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Text = "✈️ Fly [OFF]"
flyToggle.BorderSizePixel = 0
flyToggle.Parent = contentArea

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 6)
flyCorner.Parent = flyToggle

-- ✅ TOGGLE BUTTON 3 - NOCLIP
local noclipToggle = Instance.new("TextButton")
noclipToggle.Name = "NoclipToggle"
noclipToggle.Size = UDim2.new(0, 220, 0, 40)
noclipToggle.Position = UDim2.new(0, 15, 0, 140)
noclipToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
noclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipToggle.TextSize = 12
noclipToggle.Font = Enum.Font.GothamBold
noclipToggle.Text = "👻 NoClip [OFF]"
noclipToggle.BorderSizePixel = 0
noclipToggle.Parent = contentArea

local noclipCorner = Instance.new("UICorner")
noclipCorner.CornerRadius = UDim.new(0, 6)
noclipCorner.Parent = noclipToggle

-- ✅ CONTROL PANEL
local controlPanel = Instance.new("Frame")
controlPanel.Name = "ControlPanel"
controlPanel.Size = UDim2.new(0, 200, 0, 200)
controlPanel.Position = UDim2.new(0, 370, 0, 80)
controlPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
controlPanel.BorderSizePixel = 0
controlPanel.Draggable = true
controlPanel.Active = true
controlPanel.Parent = screenGui
controlPanel.Visible = false

local controlCorner = Instance.new("UICorner")
controlCorner.CornerRadius = UDim.new(0, 12)
controlCorner.Parent = controlPanel

local controlTitle = Instance.new("TextLabel")
controlTitle.Name = "ControlTitle"
controlTitle.Size = UDim2.new(1, 0, 0, 35)
controlTitle.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
controlTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
controlTitle.TextSize = 12
controlTitle.Font = Enum.Font.GothamBold
controlTitle.Text = "⚙️ Settings"
controlTitle.BorderSizePixel = 0
controlTitle.Parent = controlPanel

local controlTitleCorner = Instance.new("UICorner")
controlTitleCorner.CornerRadius = UDim.new(0, 12)
controlTitleCorner.Parent = controlTitle

local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(0.9, 0, 0, 20)
speedLabel.Position = UDim2.new(0.05, 0, 0.18, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 10
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Speed:"
speedLabel.Parent = controlPanel

local speedInput = Instance.new("TextBox")
speedInput.Name = "SpeedInput"
speedInput.Size = UDim2.new(0.9, 0, 0, 25)
speedInput.Position = UDim2.new(0.05, 0, 0.35, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextSize = 12
speedInput.Font = Enum.Font.GothamBold
speedInput.Text = "50"
speedInput.Parent = controlPanel

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = speedInput

local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.9, 0, 0, 25)
applyButton.Position = UDim2.new(0.05, 0, 0.65, 0)
applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 11
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ Apply"
applyButton.BorderSizePixel = 0
applyButton.Parent = controlPanel

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 6)
applyCorner.Parent = applyButton

-- ✅ TOGGLE MENU BẰNG NÚT ICON
toggleIconButton.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        menuOpen = not menuOpen
        mainPanel.Visible = menuOpen
        
        if menuOpen then
            toggleIconButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            iconLabel.Text = "✓"
        else
            toggleIconButton.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
            iconLabel.Text = "⚡"
        end
    end
end)

-- ✅ CHỨC NĂNG RUN SPEED
local function toggleRunSpeed()
    speedEnabled = not speedEnabled
    
    if speedEnabled then
        runSpeedToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        runSpeedToggle.Text = "🏃 Run Speed [ON]"
        controlPanel.Visible = true
        speedInput.Text = tostring(currentSpeed)
    else
        runSpeedToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        runSpeedToggle.Text = "🏃 Run Speed [OFF]"
        humanoid.WalkSpeed = 16
        controlPanel.Visible = false
    end
end

-- ✅ CHỨC NĂNG FLY
local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        flyToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        flyToggle.Text = "✈️ Fly [ON]"
        controlPanel.Visible = true
        speedInput.Text = tostring(currentFlySpeed)
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Parent = rootPart
        
        if flyConnection then
            flyConnection:Disconnect()
        end
        
        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled then return end
            
            local moveDirection = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + (rootPart.CFrame.LookVector) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - (rootPart.CFrame.LookVector) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - (rootPart.CFrame.RightVector) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + (rootPart.CFrame.RightVector) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end
            
            bodyVelocity.Velocity = moveDirection * currentFlySpeed
        end)
    else
        flyToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        flyToggle.Text = "✈️ Fly [OFF]"
        controlPanel.Visible = false
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        local bv = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bv then bv:Destroy() end
    end
end

-- ✅ CHỨC NĂNG NOCLIP
local function toggleNoClip()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        noclipToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
        noclipToggle.Text = "👻 NoClip [ON]"
        
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        
        noclipConnection = RunService.RenderStepped:Connect(function()
            if not noclipEnabled then return end
            
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        noclipToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        noclipToggle.Text = "👻 NoClip [OFF]"
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- ✅ APPLY BUTTON
applyButton.MouseButton1Click:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then
        if speedEnabled then
            currentSpeed = math.max(10, math.min(val, 200))
            speedInput.Text = tostring(currentSpeed)
            humanoid.WalkSpeed = currentSpeed
        elseif flyEnabled then
            currentFlySpeed = math.max(10, math.min(val, 200))
            speedInput.Text = tostring(currentFlySpeed)
        end
        
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        wait(0.3)
        applyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

-- ✅ TOGGLE EVENTS
runSpeedToggle.MouseButton1Click:Connect(toggleRunSpeed)
flyToggle.MouseButton1Click:Connect(toggleFly)
noclipToggle.MouseButton1Click:Connect(toggleNoClip)

-- ✅ UPDATE SPEED REALTIME
RunService.RenderStepped:Connect(function()
    if speedEnabled and character and humanoid then
        humanoid.WalkSpeed = currentSpeed
    end
end)

print("✅ Nana 1.0 by phuoc loaded!")
