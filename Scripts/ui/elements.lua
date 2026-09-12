-- Nana Hub Elements
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua"))()

local Elements = {}

local COLORS = {
    Text = Color3.fromRGB(220, 245, 255),
    SubText = Color3.fromRGB(150, 190, 205),
    Cyan = Color3.fromRGB(0, 220, 255),
    CyanBright = Color3.fromRGB(0, 255, 230),
    SliderBg = Color3.fromRGB(25, 35, 48),
    Toggle = Color3.fromRGB(0, 210, 180),
}

local function findScrollParent(obj)
    local p = obj.Parent
    while p do
        if p:IsA("ScrollingFrame") then
            return p
        end
        p = p.Parent
    end
    return nil
end

function Elements.CreateSlider(parent, posY, titleText, minValue, maxValue, defaultValue, callback)
    -- nil titleText để không tạo tag tím của Components
    local box = Components.CreateFrameBox(parent, posY, 65, nil)
    box.Active = true
    box.Selectable = false
    box.ZIndex = 3

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -24, 0, 22)
    label.Position = UDim2.new(0, 12, 0, 7)
    label.BackgroundTransparency = 1
    label.Text = tostring(titleText) .. ": " .. tostring(defaultValue)
    label.TextColor3 = COLORS.Text
    label.TextSize = 12
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = box

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -24, 0, 8)
    sliderBg.Position = UDim2.new(0, 12, 0, 38)
    sliderBg.BackgroundColor3 = COLORS.SliderBg
    sliderBg.BorderSizePixel = 0
    sliderBg.Active = true
    sliderBg.ZIndex = 4
    sliderBg.Parent = box

    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = sliderBg

    local range = math.max(maxValue - minValue, 0.0001)
    local initial = math.clamp(defaultValue, minValue, maxValue)
    local percent = (initial - minValue) / range

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(percent, 0, 1, 0)
    fill.BackgroundColor3 = COLORS.Cyan
    fill.BorderSizePixel = 0
    fill.ZIndex = 5
    fill.Parent = sliderBg

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 14, 0, 14)
    thumb.AnchorPoint = Vector2.new(0.5, 0.5)
    thumb.Position = UDim2.new(percent, 0, 0.5, 0)
    thumb.BackgroundColor3 = COLORS.CyanBright
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 6
    thumb.Parent = sliderBg

    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 16, 1, 18)
    btn.Position = UDim2.new(0, -8, 0, -9)
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Active = true
    btn.ZIndex = 7
    btn.Parent = sliderBg

    local sliding = false
    local scrollParent = findScrollParent(box)

    local function setValueFromX(x)
        local left = sliderBg.AbsolutePosition.X
        local width = math.max(sliderBg.AbsoluteSize.X, 1)
        local p = math.clamp((x - left) / width, 0, 1)
        local value = minValue + (maxValue - minValue) * p

        -- Giữ số nguyên nếu range là số nguyên
        if minValue % 1 == 0 and maxValue % 1 == 0 then
            value = math.floor(value + 0.5)
        else
            value = math.floor(value * 100 + 0.5) / 100
        end

        local finalP = (value - minValue) / range
        fill.Size = UDim2.new(finalP, 0, 1, 0)
        thumb.Position = UDim2.new(finalP, 0, 0.5, 0)
        label.Text = tostring(titleText) .. ": " .. tostring(value)

        if callback then
            pcall(callback, value)
        end
    end

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            setValueFromX(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not sliding then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            setValueFromX(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)

    btn.MouseEnter:Connect(function()
        thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end)

    btn.MouseLeave:Connect(function()
        if not sliding then
            thumb.BackgroundColor3 = COLORS.CyanBright
        end
    end)

    return box
end

function Elements.CreateToggleRow(parent, posY, titleText, defaultValue, callback)
    local row = Components.CreateFrameBox(parent, posY, 48, nil)
    row.Active = true
    row.Selectable = false
    row.ZIndex = 3

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = tostring(titleText)
    label.TextColor3 = COLORS.Text
    label.TextSize = 12
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = row

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 44, 0, 24)
    toggle.Position = UDim2.new(1, -56, 0.5, -12)
    toggle.BackgroundColor3 = defaultValue and COLORS.Toggle or Color3.fromRGB(55, 65, 75)
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Active = true
    toggle.ZIndex = 6
    toggle.Parent = row

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggle

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.AnchorPoint = Vector2.new(0, 0.5)
    circle.Position = defaultValue and UDim2.new(1, -21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.ZIndex = 7
    circle.Parent = toggle

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local state = defaultValue

    local function setState(value)
        state = value

        TweenService:Create(toggle, TweenInfo.new(0.15), {
            BackgroundColor3 = state and COLORS.Toggle or Color3.fromRGB(55, 65, 75)
        }):Play()

        TweenService:Create(circle, TweenInfo.new(0.15), {
            Position = state
                and UDim2.new(1, -21, 0.5, 0)
                or UDim2.new(0, 3, 0.5, 0)
        }):Play()

        if callback then
            pcall(callback, state)
        end
    end

    toggle.MouseButton1Click:Connect(function()
        setState(not state)
    end)

    return row
end

function Elements.CreateDropdown(parent, posY, titleText, options, defaultIndex, callback)
    local height = 48
    local row = Components.CreateFrameBox(parent, posY, height, nil)
    row.Active = true
    row.Selectable = false
    row.ZIndex = 3

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = tostring(titleText)
    label.TextColor3 = COLORS.Text
    label.TextSize = 12
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 5
    label.Parent = row

    local currentIndex = math.clamp(defaultIndex or 1, 1, math.max(#options, 1))
    local drop = Instance.new("TextButton")
    drop.Size = UDim2.new(0, 145, 0, 30)
    drop.Position = UDim2.new(1, -157, 0.5, -15)
    drop.BackgroundColor3 = Color3.fromRGB(20, 35, 48)
    drop.BorderSizePixel = 0
    drop.TextColor3 = COLORS.Text
    drop.TextSize = 11
    drop.Font = Enum.Font.GothamSemibold
    drop.Text = options[currentIndex] or "Select"
    drop.AutoButtonColor = false
    drop.Active = true
    drop.ZIndex = 6
    drop.Parent = row

    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = drop

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(0, 145, 0, 120)
    list.Position = UDim2.new(1, -157, 1, 4)
    list.BackgroundColor3 = Color3.fromRGB(15, 22, 30)
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 3
    list.ScrollBarImageColor3 = COLORS.Cyan
    list.Visible = false
    list.Active = true
    list.ScrollingEnabled = true
    list.ZIndex = 20
    list.CanvasSize = UDim2.new(0, 0, 0, #options * 30)
    list.Parent = row

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = list

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = list

    local function updateSelection(index)
        currentIndex = index
        drop.Text = options[index] or "Select"
        if callback then
            pcall(callback, options[index], index)
        end
    end

    for index, option in ipairs(options) do
        local optionBtn = Instance.new("TextButton")
        optionBtn.Size = UDim2.new(1, -6, 0, 28)
        optionBtn.Position = UDim2.new(0, 3, 0, 0)
        optionBtn.BackgroundColor3 = Color3.fromRGB(22, 32, 42)
        optionBtn.BorderSizePixel = 0
        optionBtn.TextColor3 = COLORS.Text
        optionBtn.TextSize = 11
        optionBtn.Font = Enum.Font.Gotham
        optionBtn.Text = tostring(option)
        optionBtn.AutoButtonColor = false
        optionBtn.Active = true
        optionBtn.ZIndex = 21
        optionBtn.Parent = list

        optionBtn.MouseButton1Click:Connect(function()
            updateSelection(index)
            list.Visible = false
        end)
    end

    drop.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible
    end)

    return row
end

return Elements
