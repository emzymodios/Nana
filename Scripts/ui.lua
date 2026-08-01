-- Nana Hub UI (ui.lua) - REDESIGNED & MULTI-TAB
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local UI = {}

-- ⚙️ THAY ĐỔI ID ẢNH NÚT MỞ HUB TẠI ĐÂY (Ví dụ: rbxassetid://6023426915 hoặc để trống nếu dùng icon chữ)
local ICON_IMAGE_ID = "rbxassetid://93925828218201"

function UI.Init()
    if playerGui:FindFirstChild("NanaHubUI") then
        playerGui.NanaHubUI:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NanaHubUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- ✅ Nút mở/đóng Hub dạng Ảnh độc đáo
    local toggleBtn = Instance.new("ImageButton")
    toggleBtn.Name = "ToggleBtn"
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    toggleBtn.Image = ICON_IMAGE_ID
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

    -- ✅ Khung chính của Hub (Thiết kế cao cấp hơn)
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
    titleLabel.Font = Enum.Font.GothamBlack -- In đậm nổi bật
    titleLabel.Text = " NANA HUB 1.2| "
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -38, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.TextSize = 15
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
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

    -- Khung chứa nội dung Tab Main
    local mainContainer = Instance.new("ScrollingFrame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(1, -145, 1, -50)
    mainContainer.Position = UDim2.new(0, 145, 0, 45)
    mainContainer.BackgroundTransparency = 1
    mainContainer.BorderSizePixel = 0
    mainContainer.CanvasSize = UDim2.new(0, 0, 0, 350)
    mainContainer.ScrollBarThickness = 4
    mainContainer.Visible = true
    mainContainer.Parent = mainFrame

    -- Khung chứa nội dung Tab Other ESP
    local otherContainer = Instance.new("ScrollingFrame")
    otherContainer.Name = "OtherContainer"
    otherContainer.Size = UDim2.new(0, 385, 1, -50)
    otherContainer.Position = UDim2.new(0, 145, 0, 45)
    otherContainer.BackgroundTransparency = 1
    otherContainer.BorderSizePixel = 0
    otherContainer.CanvasSize = UDim2.new(0, 0, 0, 100)
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

    -- Hàm tạo UI Slider
    local function createSlider(parent, posY, titleText, minVal, maxVal, defaultVal, callback)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.9, 0, 0, 20)
        lbl.Position = UDim2.new(0.05, 0, 0, posY)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
        lbl.TextSize = 13
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = titleText .. ": " .. tostring(defaultVal)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = parent

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(0.9, 0, 0, 10)
        sliderBg.Position = UDim2.new(0.05, 0, 0, posY + 22)
        sliderBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = parent

        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(1, 0)
        sCorner.Parent = sliderBg

        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(110, 80, 255)
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderBg

        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(1, 0)
        fCorner.Parent = sliderFill

        local sliding = false
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = sliderBg

        local function update(input)
            local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(minVal + (maxVal - minVal) * pos)
            lbl.Text = titleText .. ": " .. tostring(val)
            callback(val)
        end

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = true
                update(input)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                update(input)
            end
        end)
    end

    -- Hàm tạo UI Toggle
    local function createToggleRow(parent, posY, titleText, callback)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.7, 0, 0, 35)
        lbl.Position = UDim2.new(0.05, 0, 0, posY)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
        lbl.TextSize = 13
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = titleText
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = parent

        local toggleBox = Instance.new("TextButton")
        toggleBox.Size = UDim2.new(0, 45, 0, 22)
        toggleBox.Position = UDim2.new(0.8, 0, 0, posY + 6)
        toggleBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        toggleBox.Text = ""
        toggleBox.Parent = parent

        local tCorner = Instance.new("UICorner")
        tCorner.CornerRadius = UDim.new(1, 0)
        tCorner.Parent = toggleBox

        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 18, 0, 18)
        circle.Position = UDim2.new(0, 2, 0.5, -9)
        circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        circle.Parent = toggleBox

        local cCorner = Instance.new("UICorner")
        cCorner.CornerRadius = UDim.new(1, 0)
        cCorner.Parent = circle

        local active = false
        toggleBox.MouseButton1Click:Connect(function()
            active = not active
            if active then
                circle:TweenPosition(UDim2.new(1, -20, 0.5, -9), "Out", "Quad", 0.15, true)
                toggleBox.BackgroundColor3 = Color3.fromRGB(0, 210, 110)
            else
                circle:TweenPosition(UDim2.new(0, 2, 0.5, -9), "Out", "Quad", 0.15, true)
                toggleBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
            end
            callback(active)
        end)
    end

    -- Đưa các thành phần vào Tab Main
    createSlider(mainContainer, 10, "Run Speed", 16, 200, 16, function(val)
        if UI.OnSpeedChanged then UI.OnSpeedChanged(val) end
    end)

    createSlider(mainContainer, 75, "Fly Speed", 10, 300, 50, function(val)
        if UI.OnFlySpeedChanged then UI.OnFlySpeedChanged(val) end
    end)

    createToggleRow(mainContainer, 140, "Speed Mode", function(state)
        if UI.OnSpeedToggled then UI.OnSpeedToggled(state) end
    end)

    createToggleRow(mainContainer, 185, "Fly Mode", function(state)
        if UI.OnFlyToggled then UI.OnFlyToggled(state) end
    end)

    createToggleRow(mainContainer, 230, "NoClip Mode", function(state)
        if UI.OnNoClipToggled then UI.OnNoClipToggled(state) end
    end)

    createToggleRow(mainContainer, 275, "Infinite Jump", function(state)
        if UI.OnJumpToggled then UI.OnJumpToggled(state) end
    end)

    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    resetBtn.Position = UDim2.new(0.05, 0, 0, 330)
    resetBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 60)
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.TextSize = 13
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Text = " Reset Config "
    resetBtn.Parent = mainContainer

    local rCorner = Instance.new("UICorner")
    rCorner.CornerRadius = UDim.new(0, 8)
    rCorner.Parent = resetBtn

    resetBtn.MouseButton1Click:Connect(function()
        if UI.OnResetClicked then UI.OnResetClicked() end
    end)

    -- Đưa ESP Player vào Tab Other ESP
    createToggleRow(otherContainer, 15, "ESP Player", function(state)
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
UI.OnESPToggled = nil
UI.OnResetClicked = nil

return UI
