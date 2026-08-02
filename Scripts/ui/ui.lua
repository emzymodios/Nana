-- Nana Hub Main (ui.lua)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function safeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if not success then
        warn("NanaHub Load Error at: " .. url .. "\nDetails: " .. tostring(result))
        return nil
    end
    return result
end

-- Tải các module cơ bản và notification an toàn
local Config = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/config.lua")
local Components = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua")
local Elements = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua")
local Notification = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/notification.lua")
local HUD = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/hud.lua")

-- Tải các module tab con nằm trong thư mục tabs/
local MainTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/main_tab.lua")
local CombatTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/combat_tab.lua")
local ESPTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/esp_tab.lua")
local MoreTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/more.lua")

local UI = {}
UI.Notify = Notification -- Đưa notification vào UI để các module khác dễ dàng sử dụng

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
    toggleBtn.Image = Config and Config.IconImageId or ""
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
    titleLabel.Text = "NANA HUB 1.4"
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

    local tabMoreBtn = Instance.new("TextButton")
    tabMoreBtn.Size = UDim2.new(0.9, 0, 0, 38)
    tabMoreBtn.Position = UDim2.new(0.05, 0, 0.41, 0)
    tabMoreBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    tabMoreBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    tabMoreBtn.TextSize = 13
    tabMoreBtn.Font = Enum.Font.GothamBold
    tabMoreBtn.Text = "More"
    tabMoreBtn.Parent = sideBar

    local tMoreCorner = Instance.new("UICorner")
    tMoreCorner.CornerRadius = UDim.new(0, 8)
    tMoreCorner.Parent = tabMoreBtn

    local function setupScrollingFrame(container)
        container.ScrollingEnabled = true
        container.Selectable = true
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

    local moreContainer = Instance.new("ScrollingFrame")
    moreContainer.Name = "MoreContainer"
    moreContainer.Size = UDim2.new(1, -145, 1, -50)
    moreContainer.Position = UDim2.new(0, 145, 0, 45)
    moreContainer.BackgroundTransparency = 1
    moreContainer.BorderSizePixel = 0
    moreContainer.CanvasSize = UDim2.new(0, 0, 0, 150)
    moreContainer.ScrollBarThickness = 4
    moreContainer.Visible = false
    moreContainer.Parent = mainFrame
    setupScrollingFrame(moreContainer)

    tabMainBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = true
        combatContainer.Visible = false
        otherContainer.Visible = false
        moreContainer.Visible = false
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabCombatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabCombatBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabMoreBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMoreBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    tabCombatBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = false
        combatContainer.Visible = true
        otherContainer.Visible = false
        moreContainer.Visible = false
        tabCombatBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabCombatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMainBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabMoreBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMoreBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    tabOtherBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = false
        combatContainer.Visible = false
        otherContainer.Visible = true
        moreContainer.Visible = false
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabOtherBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMainBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabCombatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabCombatBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabMoreBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMoreBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    tabMoreBtn.MouseButton1Click:Connect(function()
        mainContainer.Visible = false
        combatContainer.Visible = false
        otherContainer.Visible = false
        moreContainer.Visible = true
        tabMoreBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
        tabMoreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabMainBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabMainBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabCombatBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabCombatBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabOtherBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        tabOtherBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end)

    -- Gọi khởi tạo các module tab con an toàn
    if MainTab and MainTab.Create then MainTab.Create(mainContainer, UI) end
    if CombatTab and CombatTab.Create then CombatTab.Create(combatContainer, UI) end
    if ESPTab and ESPTab.Create then ESPTab.Create(otherContainer, UI) end
    if MoreTab and MoreTab.Create then MoreTab.Create(moreContainer, UI) end

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
UI.OnTeleportPlayerToggled = nil

return UI
