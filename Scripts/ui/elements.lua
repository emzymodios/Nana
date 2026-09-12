-- Nana Hub Elements (elements.lua - Đã tinh chỉnh chuẩn xác không vệt title)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Components = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua"
))()

local Elements = {}

--==================================================
-- SLIDER (Giữ chữ thông số, không có title phụ)
--==================================================

function Elements.CreateSlider(parent, posY, titleText, minVal, maxVal, defaultVal, callback)

    local box = Components.CreateFrameBox(parent, posY, 60, nil)
    box.ZIndex = 3

    -- Label hiển thị tên và số (Ví dụ: Run: 16)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.9, 0, 0, 18)
    lbl.Position = UDim2.new(0.05, 0, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText .. ": " .. tostring(defaultVal)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = box

    -- Slider background
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0.9, 0, 0, 8)
    sliderBg.Position = UDim2.new(0.05, 0, 0, 34)
    sliderBg.BackgroundColor3 = Color3.fromRGB(20, 35, 45)
    sliderBg.BorderSizePixel = 0
    sliderBg.ClipsDescendants = false
    sliderBg.ZIndex = 4
    sliderBg.Parent = box

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(1, 0)
    sCorner.Parent = sliderBg

    local sStroke = Instance.new("UIStroke")
    sStroke.Color = Color3.fromRGB(0, 210, 255)
    sStroke.Thickness = 1
    sStroke.Transparency = 0.35
    sStroke.Parent = sliderBg

    -- Fill
    local initialPos = math.max(
        0,
        math.min(
            1,
            (defaultVal - minVal) / (maxVal - minVal)
        )
    )

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(initialPos, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 5
    sliderFill.Parent = sliderBg

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(1, 0)
    fCorner.Parent = sliderFill

    local fillGlow = Instance.new("UIStroke")
    fillGlow.Color = Color3.fromRGB(0, 220, 255)
    fillGlow.Thickness = 2
    fillGlow.Transparency = 0.65
    fillGlow.Parent = sliderFill

    -- Circle
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 14, 0, 14)
    circle.Position = UDim2.new(initialPos, -7, 0.5, -7)
    circle.BackgroundColor3 = Color3.fromRGB(0, 235, 255)
    circle.BorderSizePixel = 0
    circle.ZIndex = 7
    circle.Parent = sliderBg

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local cGlow = Instance.new("UIStroke")
    cGlow.Color = Color3.fromRGB(0, 225, 255)
    cGlow.Thickness = 2
    cGlow.Transparency = 0.15
    cGlow.Parent = circle

    -- Outer glow
    local outerGlow = Instance.new("Frame")
    outerGlow.Size = UDim2.new(0, 22, 0, 22)
    outerGlow.Position = UDim2.new(initialPos, -11, 0.5, -11)
    outerGlow.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    outerGlow.BackgroundTransparency = 0.82
    outerGlow.BorderSizePixel = 0
    outerGlow.ZIndex = 6
    outerGlow.Parent = sliderBg

    local outerCorner = Instance.new("UICorner")
    outerCorner.CornerRadius = UDim.new(1, 0)
    outerCorner.Parent = outerGlow

    -- Invisible input button
    local sliding = false

    local btn = Instance.new("TextButton")
    btn.Name = "SliderInput"
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Active = true
    btn.Selectable = false
    btn.ZIndex = 10
    btn.Parent = sliderBg

    local function startEffect()
        circle:TweenSize(UDim2.new(0, 18, 0, 18), "Out", "Quad", 0.12, true)
        outerGlow:TweenSize(UDim2.new(0, 28, 0, 28), "Out", "Quad", 0.12, true)
        cGlow.Transparency = 0
        cGlow.Thickness = 3
        fillGlow.Transparency = 0.35
    end

    local function stopEffect()
        circle:TweenSize(UDim2.new(0, 14, 0, 14), "Out", "Quad", 0.12, true)
        outerGlow:TweenSize(UDim2.new(0, 22, 0, 22), "Out", "Quad", 0.12, true)
        cGlow.Transparency = 0.15
        cGlow.Thickness = 2
        fillGlow.Transparency = 0.65
    end

    local function update(input)
        if not input or not input.Position then return end
        local absoluteSize = sliderBg.AbsoluteSize.X
        if absoluteSize <= 0 then return end

        local rawPos = (input.Position.X - sliderBg.AbsolutePosition.X) / absoluteSize
        local pos = math.max(0, math.min(1, rawPos))

        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        circle.Position = UDim2.new(pos, -7, 0.5, -7)
        outerGlow.Position = UDim2.new(pos, -11, 0.5, -11)

        local val = math.floor(minVal + (maxVal - minVal) * pos + 0.5)
        lbl.Text = titleText .. ": " .. tostring(val)

        if callback then
            callback(val)
        end
    end

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            startEffect()
            update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            if sliding then
                sliding = false
                stopEffect()
            end
        end
    end)

    return box
end

--==================================================
-- TOGGLE (Giữ tên tính năng, khung sạch sẽ)
--==================================================

function Elements.CreateToggleRow(parent, posY, titleText, callback)

    local box = Components.CreateFrameBox(parent, posY, 42, nil)
    box.ZIndex = 3

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0.05, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = box

    local toggleBox = Instance.new("TextButton")
    toggleBox.Name = "ToggleButton"
    toggleBox.Size = UDim2.new(0, 42, 0, 20)
    toggleBox.Position = UDim2.new(0.75, 0, 0.5, -10)
    toggleBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    toggleBox.BorderSizePixel = 0
    toggleBox.Text = ""
    toggleBox.AutoButtonColor = false
    toggleBox.Active = true
    toggleBox.Selectable = false
    toggleBox.ZIndex = 6
    toggleBox.Parent = box

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBox

    local circle = Instance.new("Frame")
    circle.Name = "ToggleCircle"
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.ZIndex = 7
    circle.Parent = toggleBox

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local active = false

    toggleBox.MouseButton1Click:Connect(function()
        active = not active

        if active then
            circle:TweenPosition(UDim2.new(1, -18, 0.5, -8), "Out", "Quad", 0.15, true)
            toggleBox.BackgroundColor3 = Color3.fromRGB(0, 210, 110)
        else
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.15, true)
            toggleBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        end

        if callback then
            callback(active)
        end
    end)

    return box
end

return Elements

