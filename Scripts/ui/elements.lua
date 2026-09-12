
-- Nana Hub Elements (elements.lua)

local UserInputService = game:GetService("UserInputService")

local Components = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua"
))()

local Elements = {}

--------------------------------------------------
-- COLORS
--------------------------------------------------

local COLORS = {
    Box = Color3.fromRGB(20, 30, 45),
    SliderBackground = Color3.fromRGB(30, 45, 60),
    SliderFill = Color3.fromRGB(0, 200, 255),
    SliderHover = Color3.fromRGB(0, 255, 220),

    Text = Color3.fromRGB(200, 240, 255),

    ToggleOff = Color3.fromRGB(30, 45, 60),
    ToggleOn = Color3.fromRGB(0, 210, 110),

    Dropdown = Color3.fromRGB(30, 45, 60),
    DropdownList = Color3.fromRGB(20, 30, 45),
    DropdownHover = Color3.fromRGB(0, 120, 170)
}

--------------------------------------------------
-- SLIDER
--------------------------------------------------

function Elements.CreateSlider(parent, posY, titleText, minVal, maxVal, defaultVal, callback)

    local box = Components.CreateFrameBox(parent, posY, 65, titleText)

    box.Active = true
    box.Selectable = false
    box.ZIndex = 3

    --------------------------------------------------
    -- LABEL
    --------------------------------------------------

    local lbl = Instance.new("TextLabel")

    lbl.Size = UDim2.new(0.9, 0, 0, 20)
    lbl.Position = UDim2.new(0.05, 0, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = COLORS.Text
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText .. ": " .. tostring(defaultVal)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 5
    lbl.Parent = box

    --------------------------------------------------
    -- SLIDER BACKGROUND
    --------------------------------------------------

    local sliderBg = Instance.new("Frame")

    sliderBg.Size = UDim2.new(0.9, 0, 0, 10)
    sliderBg.Position = UDim2.new(0.05, 0, 0, 34)
    sliderBg.BackgroundColor3 = COLORS.SliderBackground
    sliderBg.BorderSizePixel = 0
    sliderBg.Active = true
    sliderBg.ZIndex = 4
    sliderBg.Parent = box

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(1, 0)
    sCorner.Parent = sliderBg

    --------------------------------------------------
    -- INITIAL VALUE
    --------------------------------------------------

    local initialPercent = 0

    if maxVal ~= minVal then
        initialPercent = math.clamp(
            (defaultVal - minVal) / (maxVal - minVal),
            0,
            1
        )
    end

    --------------------------------------------------
    -- SLIDER FILL
    --------------------------------------------------

    local sliderFill = Instance.new("Frame")

    sliderFill.Size = UDim2.new(initialPercent, 0, 1, 0)
    sliderFill.BackgroundColor3 = COLORS.SliderFill
    sliderFill.BorderSizePixel = 0
    sliderFill.Active = false
    sliderFill.ZIndex = 5
    sliderFill.Parent = sliderBg

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(1, 0)
    fCorner.Parent = sliderFill

    --------------------------------------------------
    -- ROUND THUMB
    --------------------------------------------------

    local thumb = Instance.new("Frame")

    thumb.Size = UDim2.new(0, 18, 0, 18)
    thumb.AnchorPoint = Vector2.new(0.5, 0.5)

    thumb.Position = UDim2.new(
        initialPercent,
        0,
        0.5,
        0
    )

    thumb.BackgroundColor3 = Color3.fromRGB(220, 250, 255)
    thumb.BorderSizePixel = 0
    thumb.Active = false
    thumb.ZIndex = 7
    thumb.Parent = sliderBg

    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb

    local thumbStroke = Instance.new("UIStroke")
    thumbStroke.Color = COLORS.SliderFill
    thumbStroke.Thickness = 2
    thumbStroke.Parent = thumb

    --------------------------------------------------
    -- INVISIBLE DRAG BUTTON
    --------------------------------------------------

    local btn = Instance.new("TextButton")

    -- Bao phủ cả thanh + vùng nhỏ xung quanh
    btn.Size = UDim2.new(1, 16, 0, 28)
    btn.Position = UDim2.new(0, -8, 0.5, -14)

    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Active = true
    btn.Selectable = false
    btn.ZIndex = 8
    btn.Parent = sliderBg

    --------------------------------------------------
    -- SLIDER STATE
    --------------------------------------------------

    local sliding = false
    local dragInput = nil

    local scrollParent = nil
    local oldScrollingEnabled = nil

    --------------------------------------------------
    -- FIND SCROLLING FRAME
    --------------------------------------------------

    local function findScrollingParent()

        local current = parent

        while current do

            if current:IsA("ScrollingFrame") then
                return current
            end

            current = current.Parent
        end

        return nil
    end

    --------------------------------------------------
    -- UPDATE SLIDER
    --------------------------------------------------

    local function update(input)

        if not input then
            return
        end

        local width = sliderBg.AbsoluteSize.X

        if width <= 0 then
            return
        end

        local mouseX = input.Position.X
        local startX = sliderBg.AbsolutePosition.X

        local percent = math.clamp(
            (mouseX - startX) / width,
            0,
            1
        )

        --------------------------------------------------
        -- FILL
        --------------------------------------------------

        sliderFill.Size = UDim2.new(
            percent,
            0,
            1,
            0
        )

        --------------------------------------------------
        -- THUMB
        --------------------------------------------------

        thumb.Position = UDim2.new(
            percent,
            0,
            0.5,
            0
        )

        --------------------------------------------------
        -- VALUE
        --------------------------------------------------

        local val

        if maxVal == minVal then

            val = minVal

        else

            val = math.floor(
                minVal
                + ((maxVal - minVal) * percent)
                + 0.5
            )

        end

        lbl.Text = titleText .. ": " .. tostring(val)

        --------------------------------------------------
        -- CALLBACK
        --------------------------------------------------

        if callback then
            callback(val)
        end
    end

    --------------------------------------------------
    -- START SLIDER
    --------------------------------------------------

    local function startSliding(input)

        if sliding then
            return
        end

        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        sliding = true

        --------------------------------------------------
        -- IMPORTANT:
        -- Chỉ slider này được kéo
        --------------------------------------------------

        dragInput = nil

        --------------------------------------------------
        -- Tắt scroll khi đang kéo
        --------------------------------------------------

        scrollParent = findScrollingParent()

        if scrollParent then

            oldScrollingEnabled =
                scrollParent.ScrollingEnabled

            scrollParent.ScrollingEnabled = false

        end

        update(input)
    end

    --------------------------------------------------
    -- STOP SLIDER
    --------------------------------------------------

    local function stopSliding(input)

        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        if not sliding then
            return
        end

        sliding = false
        dragInput = nil

        --------------------------------------------------
        -- Restore scroll
        --------------------------------------------------

        if scrollParent then

            scrollParent.ScrollingEnabled =
                oldScrollingEnabled ~= false

            scrollParent = nil
            oldScrollingEnabled = nil

        end

        --------------------------------------------------
        -- Reset thumb color
        --------------------------------------------------

        thumb.BackgroundColor3 =
            Color3.fromRGB(220, 250, 255)

        thumbStroke.Color =
            COLORS.SliderFill

        sliderFill.BackgroundColor3 =
            COLORS.SliderFill
    end

    --------------------------------------------------
    -- BUTTON INPUT BEGIN
    --------------------------------------------------

    btn.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            startSliding(input)

        end
    end)

    --------------------------------------------------
    -- TRACK DRAG INPUT
    --------------------------------------------------

    btn.InputChanged:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            dragInput = input

        end
    end)

    --------------------------------------------------
    -- GLOBAL INPUT CHANGE
    --------------------------------------------------

    UserInputService.InputChanged:Connect(function(input)

        if not sliding then
            return
        end

        --------------------------------------------------
        -- Mouse
        --------------------------------------------------

        if input.UserInputType == Enum.UserInputType.MouseMovement then

            update(input)

        --------------------------------------------------
        -- Touch
        --------------------------------------------------

        elseif input.UserInputType == Enum.UserInputType.Touch then

            update(input)

        end

    end)

    --------------------------------------------------
    -- INPUT END
    --------------------------------------------------

    UserInputService.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            stopSliding(input)

        end

    end)

    --------------------------------------------------
    -- HOVER
    --------------------------------------------------

    btn.MouseEnter:Connect(function()

        if not sliding then

            sliderFill.BackgroundColor3 =
                COLORS.SliderHover

            thumb.BackgroundColor3 =
                Color3.fromRGB(255, 255, 255)

            thumbStroke.Color =
                COLORS.SliderHover

        end

    end)

    btn.MouseLeave:Connect(function()

        if not sliding then

            sliderFill.BackgroundColor3 =
                COLORS.SliderFill

            thumb.BackgroundColor3 =
                Color3.fromRGB(220, 250, 255)

            thumbStroke.Color =
                COLORS.SliderFill

        end

    end)

    return box
end


--------------------------------------------------
-- TOGGLE
--------------------------------------------------

function Elements.CreateToggleRow(parent, posY, titleText, callback)

    local box =
        Components.CreateFrameBox(parent, posY, 45, nil)

    box.Active = true
    box.Selectable = false
    box.ZIndex = 3

    local lbl = Instance.new("TextLabel")

    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0.05, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = COLORS.Text
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = titleText
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 4
    lbl.Parent = box

    --------------------------------------------------
    -- TOGGLE BUTTON
    --------------------------------------------------

    local toggleBox = Instance.new("TextButton")

    toggleBox.Size = UDim2.new(0, 45, 0, 22)
    toggleBox.Position = UDim2.new(0.75, 0, 0.5, -11)
    toggleBox.BackgroundColor3 = COLORS.ToggleOff
    toggleBox.BorderSizePixel = 0
    toggleBox.Text = ""
    toggleBox.AutoButtonColor = false
    toggleBox.Active = true
    toggleBox.Selectable = false
    toggleBox.ZIndex = 5
    toggleBox.Parent = box

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBox

    --------------------------------------------------
    -- CIRCLE
    --------------------------------------------------

    local circle = Instance.new("Frame")

    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 =
        Color3.fromRGB(220, 240, 255)
    circle.BorderSizePixel = 0
    circle.ZIndex = 6
    circle.Parent = toggleBox

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    --------------------------------------------------
    -- STATE
    --------------------------------------------------

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
                COLORS.ToggleOn

        else

            circle:TweenPosition(
                UDim2.new(0, 2, 0.5, -9),
                "Out",
                "Quad",
                0.15,
                true
            )

            toggleBox.BackgroundColor3 =
                COLORS.ToggleOff

        end

        if callback then
            callback(active)
        end

    end)

    return box
end


--------------------------------------------------
-- DROPDOWN
--------------------------------------------------

function Elements.CreateDropdown(parent, posY, title, optionsList, callback)

    local container =
        Components.CreateFrameBox(parent, posY, 45, nil)

    container.Active = true
    container.Selectable = false
    container.ZIndex = 3

    --------------------------------------------------
    -- LABEL
    --------------------------------------------------

    local label = Instance.new("TextLabel")

    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = COLORS.Text
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.Text = title
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 4
    label.Parent = container

    --------------------------------------------------
    -- DROPDOWN BUTTON
    --------------------------------------------------

    local dropBtn = Instance.new("TextButton")

    dropBtn.Size = UDim2.new(0.5, 0, 0, 28)
    dropBtn.Position = UDim2.new(0.45, 0, 0.5, -14)
    dropBtn.BackgroundColor3 = COLORS.Dropdown
    dropBtn.TextColor3 = COLORS.Text
    dropBtn.TextSize = 12
    dropBtn.Font = Enum.Font.Gotham
    dropBtn.Text = "Select Player ▾"
    dropBtn.AutoButtonColor = false
    dropBtn.Active = true
    dropBtn.Selectable = false
    dropBtn.ZIndex = 5
    dropBtn.Parent = container

    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropBtn

    --------------------------------------------------
    -- DROPDOWN LIST
    --------------------------------------------------

    local listFrame = Instance.new("ScrollingFrame")

    listFrame.Size = UDim2.new(0.5, 0, 0, 0)
    listFrame.Position = UDim2.new(0.45, 0, 1, 2)
    listFrame.BackgroundColor3 = COLORS.DropdownList
    listFrame.BorderSizePixel = 0
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.ScrollBarThickness = 3
    listFrame.Visible = false
    listFrame.Active = true
    listFrame.Selectable = false
    listFrame.ZIndex = 10
    listFrame.Parent = container

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = listFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = listFrame

    local isOpen = false

    --------------------------------------------------
    -- UPDATE OPTIONS
    --------------------------------------------------

    local function updateOptions(items)

        for _, v in ipairs(listFrame:GetChildren()) do

            if v:IsA("TextButton") then
                v:Destroy()
            end

        end

        if not items then
            items = {}
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

        for index, itemName in ipairs(items) do

            local optBtn =
                Instance.new("TextButton")

            optBtn.Size =
                UDim2.new(1, 0, 0, 28)

            optBtn.BackgroundColor3 =
                COLORS.Dropdown

            optBtn.TextColor3 =
                COLORS.Text

            optBtn.TextSize = 12
            optBtn.Font = Enum.Font.Gotham
            optBtn.Text = tostring(itemName)
            optBtn.AutoButtonColor = false
            optBtn.Active = true
            optBtn.Selectable = false
            optBtn.LayoutOrder = index
            optBtn.ZIndex = 11
            optBtn.Parent = listFrame

            local optionCorner =
                Instance.new("UICorner")

            optionCorner.CornerRadius =
                UDim.new(0, 4)

            optionCorner.Parent = optBtn

            optBtn.MouseEnter:Connect(function()

                optBtn.BackgroundColor3 =
                    COLORS.DropdownHover

            end)

            optBtn.MouseLeave:Connect(function()

                optBtn.BackgroundColor3 =
                    COLORS.Dropdown

            end)

            optBtn.MouseButton1Click:Connect(function()

                dropBtn.Text =
                    tostring(itemName) .. " ▾"

                isOpen = false
                listFrame.Visible = false

                if callback then
                    callback(itemName)
                end

            end)

        end
    end

    --------------------------------------------------
    -- OPEN / CLOSE
    --------------------------------------------------

    dropBtn.MouseButton1Click:Connect(function()

        isOpen = not isOpen

        listFrame.Visible = isOpen

        if isOpen and optionsList then
            updateOptions(optionsList)
        end

    end)

    return container, updateOptions
end

return Elements

