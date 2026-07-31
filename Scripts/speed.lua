-- Nana 1.0 - FULL VERSION (UI + Chức năng)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ✅ BIẾN TRẠNG THÁI
local speedEnabled = false
local flyEnabled = false
local noclipEnabled = false
local currentSpeed = 50
local currentFlySpeed = 50
local flyConnection = nil
local noclipConnection = nil

-- ✅ GUI
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

-- ✅ BẢNG MENU
local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Size = UDim2.new(0, 400, 0, 450)
menu.Position = UDim2.new(0.1, 0, 0.15, 0)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
menu.BorderSizePixel = 0
menu.Draggable = true
menu.Active = true
menu.Visible = false
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

-- ✅ HÀM TẠO TOGGLE
local function createToggle(yPos, label, onToggle)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.9, 0, 0, 50)
    bg.Position = UDim2.new(0.05, 0, 0, yPos)
    bg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    bg.BorderSizePixel = 0
    bg.Parent = menu
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 8)
    bgCorner.Parent = bg
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = label
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = bg
    
    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 50, 0, 30)
    switchBg.Position = UDim2.new(0.65, 0, 0.1, 0)
    switchBg.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
    switchBg.BorderSizePixel = 0
    switchBg.Parent = bg
    
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(0, 15)
    switchCorner.Parent = switchBg
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 26, 0, 26)
    circle.Position = UDim2.new(0, 2, 0.5, -13)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = switchBg
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle
    
    local state = false
    
    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.Parent = switchBg
    
    clickBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            circle:TweenPosition(UDim2.new(0, 22, 0.5, -13), "Out", "Quad", 0.2, true)
            switchBg:TweenColor3(Color3.fromRGB(50, 150, 255), "Out", "Quad", 0.2, true)
        else
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -13), "Out", "Quad", 0.2, true)
            switchBg:TweenColor3(Color3.fromRGB(100, 100, 120), "Out", "Quad", 0.2, true)
        end
        onToggle(state)
    end)
    
    return state
end

-- ✅ TOGGLE 1 - RUN SPEED
local t1State = createToggle(110, "🏃 Run Speed", function(state)
    speedEnabled = state
    if state then
        print("✅ Run Speed ON")
    else
        print("❌ Run Speed OFF")
        humanoid.WalkSpeed = 16
    end
end)

-- ✅ TOGGLE 2 - FLY
local t2State = createToggle(170, "✈️ Fly", function(state)
    flyEnabled = state
    if state then
        print("✅ Fly ON - WASD để di chuyển, Space lên, Ctrl xuống")
        
        if flyConnection then flyConnection:Disconnect() end
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        bodyVelocity.Parent = rootPart
        
        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled then 
                if bodyVelocity then bodyVelocity:Destroy() end
                return 
            end
            
            local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then 
                moveDir = moveDir + rootPart.CFrame.LookVector 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then 
                moveDir = moveDir - rootPart.CFrame.LookVector 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then 
                moveDir = moveDir - rootPart.CFrame.RightVector 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then 
                moveDir = moveDir + rootPart.CFrame.RightVector 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then 
                moveDir = moveDir + Vector3.new(0, 1, 0) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then 
                moveDir = moveDir - Vector3.new(0, 1, 0) 
            end
            
            bodyVelocity.Velocity = moveDir * currentFlySpeed
        end)
    else
        print("❌ Fly OFF")
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        local bv = rootPart:FindFirstChildOfClass("BodyVelocity")
        if bv then bv:Destroy() end
    end
end)

-- ✅ TOGGLE 3 - NOCLIP
local t3State = createToggle(230, "👻 NoClip", function(state)
    noclipEnabled = state
    if state then
        print("✅ NoClip ON")
        
        if noclipConnection then noclipConnection:Disconnect() end
        
        noclipConnection = RunService.RenderStepped:Connect(function()
            if not noclipEnabled then return end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        print("❌ NoClip OFF")
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
end)

-- ✅ SPEED CONTROL
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.9, 0, 0, 20)
speedLabel.Position = UDim2.new(0.05, 0, 0, 290)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 10
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Speed:"
speedLabel.Parent = menu

local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.9, 0, 0, 25)
speedInput.Position = UDim2.new(0.05, 0, 0, 315)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInput.TextSize = 12
speedInput.Font = Enum.Font.GothamBold
speedInput.Text = "50"
speedInput.Parent = menu

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = speedInput

local applyBtn = Instance.new("TextButton")
applyBtn.Size = UDim2.new(0.9, 0, 0, 25)
applyBtn.Position = UDim2.new(0.05, 0, 0, 355)
applyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
applyBtn.TextSize = 11
applyBtn.Font = Enum.Font.GothamBold
applyBtn.Text = "✓ Apply"
applyBtn.BorderSizePixel = 0
applyBtn.Parent = menu

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 6)
applyCorner.Parent = applyBtn

-- ✅ APPLY BUTTON
applyBtn.MouseButton1Click:Connect(function()
    local val = tonumber(speedInput.Text)
    if val then
        if speedEnabled then
            currentSpeed = math.max(10, math.min(val, 200))
        elseif flyEnabled then
            currentFlySpeed = math.max(10, math.min(val, 200))
        end
        speedInput.Text = tostring(val)
        applyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        wait(0.3)
        applyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
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
    else
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        toggleBtn.Text = "⚡"
    end
end)

-- ✅ CLOSE BUTTON
closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
    menuOpen = false
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
    toggleBtn.Text = "⚡"
end)

-- ✅ UPDATE SPEED REALTIME
RunService.RenderStepped:Connect(function()
    if speedEnabled and character and humanoid then
        humanoid.WalkSpeed = currentSpeed
    end
end)

print("✅ Nana 1.0 loaded! Bấm nút ⚡ để mở menu")
