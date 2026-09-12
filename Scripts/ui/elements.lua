-- Nana Hub Elements (elements.lua - Đã có đầy đủ Slider, Toggle, Dropdown)
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Components = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua"
))()

local Elements = {}

--==================================================
-- SLIDER
--==================================================
function Elements.CreateSlider(parent, posY, titleText, minVal, maxVal, defaultVal, callback)
    local box = Components.CreateFrameBox(parent, posY, 60, nil)
    box.ZIndex = 3

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

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0.9, 0, 0, 8)
    sliderBg.Position = UDim2.new(0.05, 0, 0, 34)
    sliderBg.BackgroundColor3 = Color3.fromRGB(20, 35, 45)
    sliderBg.BorderSizePixel = 0
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

    local initialPos = math.max(0, math.min(1, (defaultVal - minVal) / (maxVal - minVal)))

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(initialPos, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 5
    sliderFill.Parent = sliderBg

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(1, 0)
    fCorner.Parent = sliderFill

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

    local sliding = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 10
    btn.Parent = sliderBg

    local function update(input)
        local absoluteSize = sliderBg.AbsoluteSize.X
        if absoluteSize <= 0 then return end
        local rawPos = (input.Position.X - sliderBg.AbsolutePosition.X) / absoluteSize
        local pos = math.max(0, math.min(1, rawPos))

        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        circle.Position = UDim2.new(pos, -7, 0.5, -7)

        local val = math.floor(minVal + (maxVal - minVal) * pos + 0.5)
        lbl.Text = titleText .. ": " .. tostring(val)
        if callback then callback(val) end
    end

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)

    return box
end

--==================================================
-- TOGGLE
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
    toggleBox.Size = UDim2.new(0, 42, 0, 20)
    toggleBox.Position = UDim2.new(0.75, 0, 0.5, -10)
    toggleBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    toggleBox.BorderSizePixel = 0
    toggleBox.Text = ""
    toggleBox.ZIndex = 6
    toggleBox.Parent = box

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBox

    local circle = Instance.new("Frame")
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
        if callback then callback(active) end
    end)

    return box
end

--==================================================
-- DROPDOWN (Cực kỳ quan trọng cho tab Combat)
--==================================================
function Elements.CreateDropdown(parent, posY, titleText, options, callback)
    local box = Components.CreateFrameBox(parent, posY, 45, nil)
    box.ZIndex = 3
    box.ClipsDescendants = false

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.Position = UDim2.new(0.05, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = box

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0, 150, 0, 28)
    dropBtn.Position = UDim2.new(1, -160, 0.5, -14)
    dropBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
    dropBtn.BorderSizePixel = 0
    dropBtn.Text = "Select..."
    dropBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
    dropBtn.TextSize = 11
    dropBtn.Font = Enum.Font.GothamSemibold
    dropBtn.ZIndex = 6
    dropBtn.Parent = box

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 6)
    dCorner.Parent = dropBtn

    local dStroke = Instance.new("UIStroke")
    dStroke.Color = Color3.fromRGB(0, 200, 255)
    dStroke.Transparency = 0.4
    dStroke.Parent = dropBtn

    local listFrame = Instance.new("ScrollingFrame")
    listFrame.Size = UDim2.new(0, 150, 0, 0)
    listFrame.Position = UDim2.new(1, -160, 1, 4)
    listFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
    listFrame.BorderSizePixel = 0
    listFrame.Visible = false
    listFrame.ZIndex = 25
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.ScrollBarThickness = 3
    listFrame.Parent = box

    local lCorner = Instance.new("UICorner")
    lCorner.CornerRadius = UDim.new(0, 6)
    lCorner.Parent = listFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = listFrame

    local isOpen = false

    local function updateOptions(newOptions)
        for _, child in ipairs(listFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for _, opt in ipairs(newOptions) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 28)
            optBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
            optBtn.BackgroundTransparency = 0.2
            optBtn.Text = tostring(opt)
            optBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
            optBtn.TextSize = 11
            optBtn.Font = Enum.Font.Gotham
            optBtn.ZIndex = 26
            optBtn.Parent = listFrame

            optBtn.MouseButton1Click:Connect(function()
                dropBtn.Text = tostring(opt)
                isOpen = false
                listFrame.Visible = false
                listFrame.Size = UDim2.new(0, 150, 0, 0)
                if callback then callback(opt) end
            end)
        end
        listCanvasSize = #newOptions * 28
        listFrame.CanvasSize = UDim2.new(0, 0, 0, listCanvasSize)
    end

    updateOptions(options or {})

    dropBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        listFrame.Visible = isOpen
        if isOpen then
            local targetH = math.min((#options * 28), 120)
            listFrame.Size = UDim2.new(0, 150, 0, targetH)
        else
            listFrame.Size = UDim2.new(0, 150, 0, 0)
        end
    end)

    return box, updateOptions
end

return Elements

