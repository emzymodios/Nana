-- Nana Hub Elements (elements.lua)
-- Cyan Neon Slider + Glow Effect

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

    local box = Components.CreateFrameBox(parent, posY, 65, titleText)

    -- Label
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.9, 0, 0, 20)
    lbl.Position = UDim2.new(0.05, 0, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText .. ": " .. tostring(defaultVal)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = box

    -- Slider background
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0.9, 0, 0, 10)
    sliderBg.Position = UDim2.new(0.05, 0, 0, 32)
    sliderBg.BackgroundColor3 = Color3.fromRGB(20, 35, 45)
    sliderBg.BorderSizePixel = 0
    sliderBg.ClipsDescendants = false
    sliderBg.Parent = box

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(1, 0)
    sCorner.Parent = sliderBg

    -- Cyan border
    local sStroke = Instance.new("UIStroke")
    sStroke.Color = Color3.fromRGB(0, 210, 255)
    sStroke.Thickness = 1
    sStroke.Transparency = 0.35
    sStroke.Parent = sliderBg

    --==============================================
    -- CYAN FILL
    --==============================================

    local initialPos = (defaultVal - minVal) / (maxVal - minVal)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(initialPos, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 2
    sliderFill.Parent = sliderBg

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(1, 0)
    fCorner.Parent = sliderFill

    -- Fill glow
    local fillGlow = Instance.new("UIStroke")
    fillGlow.Color = Color3.fromRGB(0, 220, 255)
    fillGlow.Thickness = 2
    fillGlow.Transparency = 0.65
    fillGlow.Parent = sliderFill

    --==============================================
    -- CYAN CIRCLE
    --==============================================

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 15, 0, 15)
    circle.Position = UDim2.new(initialPos, -7.5, 0.5, -7.5)
    circle.BackgroundColor3 = Color3.fromRGB(0, 235, 255)
    circle.BorderSizePixel = 0
    circle.ZIndex = 4
    circle.Parent = sliderBg

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    -- Circle glow
    local cGlow = Instance.new("UIStroke")
    cGlow.Color = Color3.fromRGB(0, 225, 255)
    cGlow.Thickness = 2
    cGlow.Transparency = 0.15
    cGlow.Parent = circle

    --==============================================
    -- OUTER GLOW
    --==============================================

    local outerGlow = Instance.new("Frame")
    outerGlow.Size = UDim2.new(0, 25, 0, 25)
    outerGlow.Position = UDim2.new(initialPos, -12.5, 0.5, -12.5)
    outerGlow.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
    outerGlow.BackgroundTransparency = 0.82
    outerGlow.BorderSizePixel = 0
    outerGlow.ZIndex = 3
    outerGlow.Parent = sliderBg

    local outerCorner = Instance.new("UICorner")
    outerCorner.CornerRadius = UDim.new(1, 0)
    outerCorner.Parent = outerGlow

    --==============================================
    -- INVISIBLE DRAG BUTTON
    --==============================================

    local sliding = false

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 5
    btn.Parent = sliderBg

    --==============================================
    -- DRAG EFFECT
    --==============================================

    local function startEffect()

        circle:TweenSize(
            UDim2.new(0, 19, 0, 19),
            "Out",
            "Quad",
            0.12,
            true
        )

        outerGlow:TweenSize(
            UDim2.new(0, 32, 0, 32),
            "Out",
            "Quad",
            0.12,
            true
        )

        outerGlow:TweenPosition(
            UDim2.new(
                circle.Position.X.Scale,
                circle.Position.X.Offset - 6.5,
                0.5,
                -16
            ),
            "Out",
            "Quad",
            0.12,
            true
        )

        cGlow.Transparency = 0
        cGlow.Thickness = 3

        fillGlow.Transparency = 0.35
    end

    local function stopEffect()

        circle:TweenSize(
            UDim2.new(0, 15, 0, 15),
            "Out",
            "Quad",
            0.12,
            true
        )

        outerGlow:TweenSize(
            UDim2.new(0, 25, 0, 25),
            "Out",
            "Quad",
            0.12,
            true
        )

        cGlow.Transparency = 0.15
        cGlow.Thickness = 2

        fillGlow.Transparency = 0.65
    end

    --==============================================
    -- UPDATE SLIDER
    --==============================================

    local function update(input)

        if not input or not input.Position then
            return
        end

        local absoluteSize = sliderBg.AbsoluteSize.X

        if absoluteSize <= 0 then
            return
        end

        local rawPos =
            (input.Position.X - sliderBg.AbsolutePosition.X)
            / absoluteSize

        -- Roblox-compatible clamp
        local pos = math.max(0, math.min(1, rawPos))

        -- Fill
        sliderFill.Size = UDim2.new(
            pos,
            0,
            1,
            0
        )

        -- Circle
        circle.Position = UDim2.new(
            pos,
            -7.5,
            0.5,
            -7.5
        )

        -- Outer glow follows circle
        outerGlow.Position = UDim2.new(
            pos,
            -12.5,
            0.5,
            -12.5
        )

        -- Value
        local val = math.floor(
            minVal + (maxVal - minVal) * pos
        )

        lbl.Text =
            titleText .. ": " .. tostring(val)

        if callback then
            callback(val)
        end
    end

    --==============================================
    -- INPUT BEGAN
    --==============================================

    btn.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            sliding = true

            startEffect()
            update(input)
        end
    end)

    --==============================================
    -- INPUT ENDED
    --==============================================

    UserInputService.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            if sliding then
                sliding = false
                stopEffect()
            end
        end
    end)

    --==============================================
    -- INPUT CHANGED
    --==============================================

    UserInputService.InputChanged:Connect(function(input)

        if sliding
            and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then

            update(input)
        end
    end)

    return box
end


--==================================================
-- TOGGLE
--==================================================

function Elements.CreateToggleRow(parent, posY, titleText, callback)

    local box = Components.CreateFrameBox(parent, posY, 45, nil)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0.05, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = box

    local toggleBox = Instance.new("TextButton")
    toggleBox.Size = UDim2.new(0, 45, 0, 22)
    toggleBox.Position = UDim2.new(0.75, 0, 0.5, -11)
    toggleBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    toggleBox.Text = ""
    toggleBox.Parent = box

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

            circle:TweenPosition(
                UDim2.new(1, -20, 0.5, -9),
                "Out",
                "Quad",
                0.15,
                true
            )

            toggleBox.BackgroundColor3 =
                Color3.fromRGB(0, 210, 110)

        else

            circle:TweenPosition(
                UDim2.new(0, 2, 0.5, -9),
                "Out",
                "Quad",
                0.15,
                true
            )

            toggleBox.BackgroundColor3 =
                Color3.fromRGB(35, 35, 48)
        end

        if callback then
            callback(active)
        end
    end)

    return box
end


--==================================================
-- DROPDOWN
--==================================================

function Elements.CreateDropdown(parent, posY, title, optionsList, callback)

    local container =
        Components.CreateFrameBox(parent, posY, 45, nil)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 220, 240)
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.Text = title
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local dropBtn = Instance.new("TextButton")
    dropBtn.Size = UDim2.new(0.5, 0, 0, 28)
    dropBtn.Position = UDim2.new(0.45, 0, 0.5, -14)
    dropBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    dropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropBtn.TextSize = 12
    dropBtn.Font = Enum.Font.Gotham
    dropBtn.Text = "Select Player ▾"
    dropBtn.Parent = container

    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropBtn

    local listFrame = Instance.new("ScrollingFrame")
    listFrame.Size = UDim2.new(0.5, 0, 0, 0)
    listFrame.Position = UDim2.new(0.45, 0, 1, 2)
    listFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    listFrame.BorderSizePixel = 0
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.ScrollBarThickness = 3
    listFrame.Visible = false
    listFrame.ZIndex = 5
    listFrame.Parent = container

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = listFrame

    local isOpen = false

    local function updateOptions(items)

        for _, v in ipairs(listFrame:GetChildren()) do
            if v:IsA("TextButton") then
                v:Destroy()
            end
        end

        listFrame.CanvasSize =
            UDim2.new(0, 0, 0, #items * 28)

        listFrame.Size =
            UDim2.new(
                0.5,
                0,
                0,
                math.min(#items * 28, 120)
            )

        for _, itemName in ipairs(items) do

            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 28)
            optBtn.BackgroundColor3 =
                Color3.fromRGB(35, 35, 50)
            optBtn.TextColor3 =
                Color3.fromRGB(240, 240, 240)
            optBtn.TextSize = 12
            optBtn.Font = Enum.Font.Gotham
            optBtn.Text = itemName
            optBtn.ZIndex = 6
            optBtn.Parent = listFrame

            optBtn.MouseButton1Click:Connect(function()

                dropBtn.Text =
                    itemName .. " ▾"

                isOpen = false
                listFrame.Visible = false

                if callback then
                    callback(itemName)
                end
            end)
        end
    end

    dropBtn.MouseButton1Click:Connect(function()

        isOpen = not isOpen
        listFrame.Visible = isOpen

        if isOpen and optionsList then
            updateOptions(optionsList)
        end
    end)

    return container, updateOptions
end


--==================================================
-- RETURN
--==================================================

return Elements
