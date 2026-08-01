-- Nana Hub Elements (elements.lua)
local UserInputService = game:GetService("UserInputService")
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua"))()

local Elements = {}

function Elements.CreateSlider(parent, posY, titleText, minVal, maxVal, defaultVal, callback)
    local box = Components.CreateFrameBox(parent, posY, 65, titleText)
    
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

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(0.9, 0, 0, 10)
    sliderBg.Position = UDim2.new(0.05, 0, 0, 32)
    sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = box

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
            circle:TweenPosition(UDim2.new(1, -20, 0.5, -9), "Out", "Quad", 0.15, true)
            toggleBox.BackgroundColor3 = Color3.fromRGB(0, 210, 110)
        else
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -9), "Out", "Quad", 0.15, true)
            toggleBox.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        end
        callback(active)
    end)
end

function Elements.CreateDropdown(parent, posY, title, optionsList, callback)
    local container = Components.CreateFrameBox(parent, posY, 45, nil)

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
            if v:IsA("TextButton") then v:Destroy() end
        end
        
        listFrame.CanvasSize = UDim2.new(0, 0, 0, #items * 28)
        listFrame.Size = UDim2.new(0.5, 0, 0, math.min(#items * 28, 120))

        for _, itemName in ipairs(items) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 28)
            optBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            optBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
            optBtn.TextSize = 12
            optBtn.Font = Enum.Font.Gotham
            optBtn.Text = itemName
            optBtn.ZIndex = 6
            optBtn.Parent = listFrame

            optBtn.MouseButton1Click:Connect(function()
                dropBtn.Text = itemName .. " ▾"
                isOpen = false
                listFrame.Visible = false
                if callback then callback(itemName) end
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

return Elements
