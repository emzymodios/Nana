-- Nana Hub Main (ui.lua)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tải trực tiếp các module con qua GitHub raw links
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/config.lua"))()
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua"))()
local Elements = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua"))()

local UI = {}

function UI.Init()
    if playerGui:FindFirstChild("NanaHubUI") then
        playerGui.NanaHubUI:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NanaHubUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Nút mở/đóng Hub
    local toggleBtn = Instance.new("ImageButton")
    toggleBtn.Name = "ToggleBtn"
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    toggleBtn.Image = Config.IconImageId
    toggleBtn.Draggable = true
    toggleBtn.Active = true
    toggleBtn.Parent = screenGui

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleBtn

    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Color = Color3.fromRGB(120, 80, 255)
    toggleStroke.Thickness = 2
    toggleStroke.Parent = toggleBtn

    -- Khung chính của Hub
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 540, 0, 360)
    mainFrame.Position = UDim2.new(0.5, -270, 0.5, -180)
    mainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = false
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(70, 50, 120)
    mainStroke.Thickness = 1.5
    mainStroke.Parent = mainFrame

    -- Topbar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 12)
    topCorner.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.Position = UDim2.new(0.04, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.Text = "NANA HUB 1.1"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -38, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.TextSize = 15
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.Parent = topBar

    local cBtnCorner = Instance.new("UICorner")
    cBtnCorner.CornerRadius = UDim.new(0, 8)
    cBtnCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)

    toggleBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- Sidebar (Chuyển Tab)
    local sideBar = Instance.new("Frame")
    sideBar.Size = UDim2.new(0, 140, 1, -40)
    sideBar.Position = UDim2.new(0, 0, 0, 40)
    sideBar.BackgroundColor3 = Color3.fromRGB(17, 17, 24)
    sideBar.BorderSizePixel = 0
    sideBar.Parent = mainFrame

    local tabMainBtn = Instance.new("TextButton")
    tabMainBtn.Size = UDim2.new(0.9, 0, 0, 38)
    tabMainBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
    tabMainBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
    tabMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabMainBtn.TextSize = 13
    tabMainBtn.Font = Enum.Font.GothamBold
    tabMainBtn.Text = "Main"
    tabMainBtn.Parent = sideBar

    local tmCorner = Instance.new("UICorner")
    tmCorner.CornerRadius = UDim.new(0, 8)
    tmCorner.Parent = tabMainBtn

    local tabOtherBtn = Instance.new("TextButton")
    tabOtherBtn.Size = UDim2.new(0.9, 0, 0, 38)
    tabOtherBtn.Position = UDim2.new(0.05, 0, 0.17, 0)
    tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabOtherBtn.TextSize = 13
    tabOtherBtn.Font = Enum.Font.GothamBold
    tabOtherBtn.Text = "ESP"
    tabOtherBtn.Parent = sideBar

    local toCorner = Instance.new("UICorner")
    toCorner.CornerRadius = UDim.new(0, 8)
    toCorner.Parent = tabOtherBtn

-- Khung chứa nội dung Tab Main (Đã tăng CanvasSize lên 500 để không bị che nút Reset)
    local mainContainer = Instance.new("ScrollingFrame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(1, -145, 1, -50)
    mainContainer.Position = UDim2.new(0, 145, 0, 45)
    mainContainer.BackgroundTransparency = 1
    mainContainer.BorderSizePixel = 0
    mainContainer.CanvasSize = UDim2.new(0, 0, 0, 500)
    mainContainer.ScrollBarThickness = 4
    mainContainer.Visible = true
    mainContainer.Parent = mainFrame

    -- Khung chứa nội dung Tab ESP
    local otherContainer = Instance.new("ScrollingFrame")
    otherContainer.Name = "OtherContainer"
    otherContainer.Size = UDim2.new(1, -145, 1, -50)
    otherContainer.Position = UDim2.new(0, 145, 0, 45)
    otherContainer.BackgroundTransparency = 1
    otherContainer.BorderSizePixel = 0
    otherContainer.CanvasSize = UDim2.new(0, 0, 0, 150)
    otherContainer.ScrollBarThickness = 4
    otherContainer.Visible = false
    otherContainer.Parent = mainFrame

    -- Logic chuyển Tab
    tabMainBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = true
        otherContainer.Visible = false
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    tabOtherBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = false
        otherContainer.Visible = true
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabOtherBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMainBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    -- Thêm các phần tử vào Tab Main thông qua Elements module
    Elements.CreateSlider(mainContainer, 10, "Run Speed", 16, 200, 16, function(val)
        if UI.OnSpeedChanged then UI.OnSpeedChanged(val) end
    end)

    Elements.CreateSlider(mainContainer, 85, "Fly Speed", 10, 300, 50, function(val)
        if UI.OnFlySpeedChanged then UI.OnFlySpeedChanged(val) end
    end)

    Elements.CreateToggleRow(mainContainer, 160, "Speed Mode", function(state)
        if UI.OnSpeedToggled then UI.OnSpeedToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 215, "Fly Mode", function(state)
        if UI.OnFlyToggled then UI.OnFlyToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 270, "NoClip Mode", function(state)
        if UI.OnNoClipToggled then UI.OnNoClipToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 325, "Infinite Jump", function(state)
        if UI.OnJumpToggled then UI.OnJumpToggled(state) end
    end)

    -- Thêm nút FPS Boost vào tab Main
    Elements.CreateToggleRow(mainContainer, 380, "FPS Boost", function(state)
        if UI.OnFPSBoostToggled then UI.OnFPSBoostToggled(state) end
    end)

    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    resetBtn.Position = UDim2.new(0.05, 0, 0, 435)
    resetBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 60)
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.TextSize = 13
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Text = "Reset Config"
    resetBtn.Parent = mainContainer

    local rCorner = Instance.new("UICorner")
    rCorner.CornerRadius = UDim.new(0, 8)
    rCorner.Parent = resetBtn
    
    local rStroke = Instance.new("UIStroke")
    rStroke.Color = Color3.fromRGB(220, 80, 80)
    rStroke.Thickness = 1
    rStroke.Parent = resetBtn

    resetBtn.MouseButton1Click:Connect(function()
        if UI.OnResetClicked then UI.OnResetClicked() end
    end)

    -- Thêm các phần tử vào Tab ESP
    Elements.CreateSlider(otherContainer, 15, "ESP Text Size", 8, 30, 12, function(val)
        if UI.OnESPTextSizeChanged then UI.OnESPTextSizeChanged(val) end
    end)

    Elements.CreateToggleRow(otherContainer, 80, "ESP Player", function(state)
        if UI.OnESPToggled then UI.OnESPToggled(state) end
    end)

    -- Kéo giãn khung (Resize)
    local resizeBtn = Instance.new("TextButton")
    resizeBtn.Size = UDim2.new(0, 15, 0, 15)
    resizeBtn.Position = UDim2.new(1, -15, 1, -15)
    resizeBtn.BackgroundTransparency = 1
    resizeBtn.Text = "◢"
    resizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    resizeBtn.TextSize = 12
    resizeBtn.Parent = mainFrame

    local resizing = false
    local dragStart, startSize

    resizeBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            dragStart = input.Position
            startSize = mainFrame.AbsoluteSize
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Size = UDim2.new(0, math.clamp(startSize.X + delta.X, 450, 800), 0, math.clamp(startSize.Y + delta.Y, 300, 600))
        end 
    end)
end

UI.OnSpeedToggled = nil
UI.OnSpeedChanged = nil
UI.OnFlySpeedChanged = nil
UI.OnFlyToggled = nil
UI.OnNoClipToggled = nil
UI.OnJumpToggled = nil
UI.OnFPSBoostToggled = nil
UI.OnESPToggled = nil
UI.OnESPTextSizeChanged = nil
UI.OnResetClicked = nil

return UI
