-- Nana Hub Main (ui.lua)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

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
    titleLabel.Text = "NANA HUB 1.2"
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

    local tabCombatBtn = Instance.new("TextButton")
    tabCombatBtn.Size = UDim2.new(0.9, 0, 0, 38)
    tabCombatBtn.Position = UDim2.new(0.05, 0, 0.17, 0)
    tabCombatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tabCombatBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabCombatBtn.TextSize = 13
    tabCombatBtn.Font = Enum.Font.GothamBold
    tabCombatBtn.Text = "Combat"
    tabCombatBtn.Parent = sideBar

    local tcCorner = Instance.new("UICorner")
    tcCorner.CornerRadius = UDim.new(0, 8)
    tcCorner.Parent = tabCombatBtn

    local tabOtherBtn = Instance.new("TextButton")
    tabOtherBtn.Size = UDim2.new(0.9, 0, 0, 38)
    tabOtherBtn.Position = UDim2.new(0.05, 0, 0.29, 0)
    tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabOtherBtn.TextSize = 13
    tabOtherBtn.Font = Enum.Font.GothamBold
    tabOtherBtn.Text = "ESP"
    tabOtherBtn.Parent = sideBar

    local toCorner = Instance.new("UICorner")
    toCorner.CornerRadius = UDim.new(0, 8)
    toCorner.Parent = tabOtherBtn

    -- Hàm hỗ trợ tối ưu ScrollingFrame để tránh dính kéo nhầm bảng chính
    local function setupScrollingFrame(container)
        container.ScrollingEnabled = true
        container.Selectable = true
        container.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                -- Giữ tập trung tương tác cho việc cuộn nội dung con
            end
        end)
    end

    local mainContainer = Instance.new("ScrollingFrame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(1, -145, 1, -50)
    mainContainer.Position = UDim2.new(0, 145, 0, 45)
    mainContainer.BackgroundTransparency = 1
    mainContainer.BorderSizePixel = 0
    mainContainer.CanvasSize = UDim2.new(0, 0, 0, 560)
    mainContainer.ScrollBarThickness = 4
    mainContainer.Visible = true
    mainContainer.Parent = mainFrame
    setupScrollingFrame(mainContainer)

    local combatContainer = Instance.new("ScrollingFrame")
    combatContainer.Name = "CombatContainer"
    combatContainer.Size = UDim2.new(1, -145, 1, -50)
    combatContainer.Position = UDim2.new(0, 145, 0, 45)
    combatContainer.BackgroundTransparency = 1
    combatContainer.BorderSizePixel = 0
    combatContainer.CanvasSize = UDim2.new(0, 0, 0, 240)
    combatContainer.ScrollBarThickness = 4
    combatContainer.Visible = false
    combatContainer.Parent = mainFrame
    setupScrollingFrame(combatContainer)

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
    setupScrollingFrame(otherContainer)

    tabMainBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = true
        combatContainer.Visible = false
        otherContainer.Visible = false
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabCombatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabCombatBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    tabCombatBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = false
        combatContainer.Visible = true
        otherContainer.Visible = false
        tabCombatBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabCombatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMainBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    tabOtherBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = false
        combatContainer.Visible = false
        otherContainer.Visible = true
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabOtherBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMainBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabCombatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabCombatBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    -- Elements tab Main
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
Elements.CreateToggleRow(mainContainer, 380, "Soru (Click Tele)", function(state)
    if UI.OnSoruToggled then UI.OnSoruToggled(state) end
end)

    Elements.CreateToggleRow(mainContainer, 435, "FPS Boost", function(state)
        if UI.OnFPSBoostToggled then UI.OnFPSBoostToggled(state) end
    end)

    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    resetBtn.Position = UDim2.new(0.05, 0, 0, 490)
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

    -- Elements tab Combat
    local function getPlayerNames()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player then
                table.insert(list, p.Name)
            end
        end
        return list
    end

    local dropdownObj, updateDropFunc = Elements.CreateDropdown(combatContainer, 15, "Target Player", getPlayerNames(), function(selectedName)
        if UI.OnAimbotTargetChanged then UI.OnAimbotTargetChanged(selectedName) end
    end)

    Players.PlayerAdded:Connect(function() updateDropFunc(getPlayerNames()) end)
    Players.PlayerRemoving:Connect(function() updateDropFunc(getPlayerNames()) end)

    local flyToTargetBtn = Instance.new("TextButton")
    flyToTargetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    flyToTargetBtn.Position = UDim2.new(0.05, 0, 0, 65)
    flyToTargetBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 180)
    flyToTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    flyToTargetBtn.TextSize = 13
    flyToTargetBtn.Font = Enum.Font.GothamBold
    flyToTargetBtn.Text = "Fly to Selected Target"
    flyToTargetBtn.Parent = combatContainer

    local fttCorner = Instance.new("UICorner")
    fttCorner.CornerRadius = UDim.new(0, 8)
    fttCorner.Parent = flyToTargetBtn

    flyToTargetBtn.MouseButton1Click:Connect(function()
        if UI.OnFlyToTargetClicked then UI.OnFlyToTargetClicked() end
    end)

    Elements.CreateToggleRow(combatContainer, 115, "Aimbot Nearest", function(state)
        if state then
            if UI.OnAimbotModeChanged then UI.OnAimbotModeChanged("Nearest") end
        end
        if UI.OnAimbotToggled then UI.OnAimbotToggled(state) end
    end)

    Elements.CreateToggleRow(combatContainer, 170, "Aimbot Selected", function(state)
        if state then
            if UI.OnAimbotModeChanged then UI.OnAimbotModeChanged("Selected") end
        end
        if UI.OnAimbotToggled then UI.OnAimbotToggled(state) end
    end)

    -- Elements tab ESP
    Elements.CreateSlider(otherContainer, 15, "ESP Text Size", 8, 30, 12, function(val)
        if UI.OnESPTextSizeChanged then UI.OnESPTextSizeChanged(val) end
    end)

    Elements.CreateToggleRow(otherContainer, 80, "ESP Player", function(state)
        if UI.OnESPToggled then UI.OnESPToggled(state) end
    end)

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
UI.OnSoruToggled = nil
UI.OnFPSBoostToggled = nil
UI.OnESPToggled = nil
UI.OnESPTextSizeChanged = nil
UI.OnResetClicked = nil
UI.OnAimbotToggled = nil
UI.OnAimbotModeChanged = nil
UI.OnAimbotTargetChanged = nil
UI.OnFlyToTargetClicked = nil

return UI
