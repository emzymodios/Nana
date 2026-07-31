-- Nana Hub UI (ui.lua) - FULL VERSION
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local UI = {}

function UI.Init()
    -- ✅ Chống trùng lặp: Xóa UI cũ nếu đã tồn tại trước đó
    if playerGui:FindFirstChild("NanaHubUI") then
        playerGui.NanaHubUI:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NanaHubUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- ✅ Nút icon mở/đóng Hub góc màn hình
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleBtn"
    toggleBtn.Size = UDim2.new(0, 45, 0, 45)
    toggleBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    toggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
    toggleBtn.TextSize = 20
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "⚡"
    toggleBtn.Draggable = true
    toggleBtn.Active = true
    toggleBtn.Parent = screenGui

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn

    -- ✅ Khung chính của Hub
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 520, 0, 320)
    mainFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Visible = false
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame

    -- Topbar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 35)
    topBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 10)
    topCorner.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    titleLabel.Position = UDim2.new(0.03, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Nana Hub | Main Menu"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundTransparency = 1
    closeBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.Parent = topBar

    closeBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
    end)

    toggleBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- Sidebar
    local sideBar = Instance.new("Frame")
    sideBar.Size = UDim2.new(0, 130, 1, -35)
    sideBar.Position = UDim2.new(0, 0, 0, 35)
    sideBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    sideBar.BorderSizePixel = 0
    sideBar.Parent = mainFrame

    local mainTabBtn = Instance.new("TextButton")
    mainTabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    mainTabBtn.Position = UDim2.new(0.05, 0, 0.05, 0)
    mainTabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    mainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainTabBtn.TextSize = 13
    mainTabBtn.Font = Enum.Font.GothamBold
    mainTabBtn.Text = "🏠 Main"
    mainTabBtn.Parent = sideBar

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = mainTabBtn

    -- Container
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -135, 1, -45)
    container.Position = UDim2.new(0, 135, 0, 40)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.CanvasSize = UDim2.new(0, 0, 0, 260)
    container.ScrollBarThickness = 4
    container.Parent = mainFrame

    local function createSlider(posY, titleText, minVal, maxVal, defaultVal, callback)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.9, 0, 0, 20)
        lbl.Position = UDim2.new(0.05, 0, 0, posY)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
        lbl.TextSize = 13
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = titleText .. ": " .. tostring(defaultVal)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = container

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(0.9, 0, 0, 10)
        sliderBg.Position = UDim2.new(0.05, 0, 0, posY + 22)
        sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = container

        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(1, 0)
        sCorner.Parent = sliderBg

        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
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

    local function createToggleRow(posY, titleText, callback)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.7, 0, 0, 35)
        lbl.Position = UDim2.new(0.05, 0, 0, posY)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
        lbl.TextSize = 13
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = titleText
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = container

        local toggleBox = Instance.new("TextButton")
        toggleBox.Size = UDim2.new(0, 45, 0, 22)
        toggleBox.Position = UDim2.new(0.8, 0, 0, posY + 6)
        toggleBox.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        toggleBox.Text = ""
        toggleBox.Parent = container

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
                toggleBox.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            else
                circle:TweenPosition(UDim2.new(0, 2, 0.5, -9), "Out", "Quad", 0.15, true)
                toggleBox.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
            end
            callback(active)
        end)
    end

    -- Khởi tạo các sự kiện kết nối ra ngoài
    createSlider(10, "🏃 Run Speed", 16, 200, 16, function(val)
        if UI.OnSpeedChanged then UI.OnSpeedChanged(val) end
    end)

    createSlider(75, "✈️ Fly Speed", 10, 300, 50, function(val)
        if UI.OnFlySpeedChanged then UI.OnFlySpeedChanged(val) end
    end)

    createToggleRow(140, "✈️ Fly Mode", function(state)
        if UI.OnFlyToggled then UI.OnFlyToggled(state) end
    end)

    createToggleRow(185, "👻 NoClip Mode", function(state)
        if UI.OnNoClipToggled then UI.OnNoClipToggled(state) end
    end)

    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    resetBtn.Position = UDim2.new(0.05, 0, 0, 230)
    resetBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.TextSize = 13
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Text = "🔄 Reset Config"
    resetBtn.Parent = container

    local rCorner = Instance.new("UICorner")
    rCorner.CornerRadius = UDim.new(0, 6)
    rCorner.Parent = resetBtn

    resetBtn.MouseButton1Click:Connect(function()
        if UI.OnResetClicked then UI.OnResetClicked() end
    end)

    -- Resize button
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
            mainFrame.Size = UDim2.new(0, math.clamp(startSize.X + delta.X, 400, 800), 0, math.clamp(startSize.Y + delta.Y, 250, 600))
        end
    end)
end

-- Callback hooks khai báo sẵn
UI.OnSpeedChanged = nil
UI.OnFlySpeedChanged = nil
UI.OnFlyToggled = nil
UI.OnNoClipToggled = nil
UI.OnResetClicked = nil

return UI
