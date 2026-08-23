-- Nana Hub More Tab (more.lua)
local MoreTab = {}

function MoreTab.Create(container, UI, backgroundImage)

    -- =====================================================
    -- SETTINGS
    -- =====================================================

    local MenuImages = {
        ["1"] = "rbxassetid://87216058850864",
        ["2"] = "rbxassetid://80180772119955",
        ["3"] = "rbxassetid://139389295695753",
        ["4"] = "rbxassetid://130618081155480",
        ["5"] = "rbxassetid://84744590711663",
        ["6"] = "rbxassetid://116222439691339"
    }

    -- Ảnh ban đầu
    local originalImage = ""

    if backgroundImage then
        originalImage = backgroundImage.Image
    end

    local selectedImage = nil
    local selectedIndex = nil
    local dropdownOpen = false
    
    -- Canvas size: Closed = 430, Open = 500 (cho phép hiển thị 6 button + Apply/Reset)
    local CANVAS_SIZE_CLOSED = 430
    local CANVAS_SIZE_OPENED = 560  -- 6 buttons * 42 + title + spacing + apply/reset


    -- =====================================================
    -- CANVAS
    -- =====================================================

    container.CanvasSize = UDim2.new(0, 0, 0, CANVAS_SIZE_CLOSED)


    -- =====================================================
    -- TITLE
    -- =====================================================

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "MoreTitle"
    titleLabel.Size = UDim2.new(1, -20, 0, 35)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 17
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Other More"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 1
    titleLabel.Parent = container


    -- =====================================================
    -- MENU IMAGE TITLE
    -- =====================================================

    local imageTitle = Instance.new("TextLabel")
    imageTitle.Name = "MenuImageTitle"
    imageTitle.Size = UDim2.new(1, -20, 0, 30)
    imageTitle.Position = UDim2.new(0, 10, 0, 50)
    imageTitle.BackgroundTransparency = 1
    imageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    imageTitle.TextSize = 15
    imageTitle.Font = Enum.Font.GothamBold
    imageTitle.Text = "Menu Image"
    imageTitle.TextXAlignment = Enum.TextXAlignment.Left
    imageTitle.ZIndex = 1
    imageTitle.Parent = container


    -- =====================================================
    -- SELECT BUTTON
    -- =====================================================

    local imageSelect = Instance.new("TextButton")
    imageSelect.Name = "ImageSelect"
    imageSelect.Size = UDim2.new(1, -20, 0, 45)
    imageSelect.Position = UDim2.new(0, 10, 0, 85)
    imageSelect.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    imageSelect.TextColor3 = Color3.fromRGB(255, 255, 255)
    imageSelect.TextSize = 15
    imageSelect.Font = Enum.Font.GothamBold
    imageSelect.Text = "Select Image ▼"
    imageSelect.ZIndex = 2
    imageSelect.Parent = container

    local selectCorner = Instance.new("UICorner")
    selectCorner.CornerRadius = UDim.new(0, 8)
    selectCorner.Parent = imageSelect


    -- =====================================================
    -- IMAGE BUTTONS
    -- =====================================================

    local imageButtons = {}

    for i = 1, 6 do

        local index = tostring(i)

        local imgBtn = Instance.new("TextButton")
        imgBtn.Name = "ImageButton_" .. index
        imgBtn.Size = UDim2.new(1, -20, 0, 38)
        imgBtn.Position = UDim2.new(
            0,
            10,
            0,
            135 + ((i - 1) * 42)
        )

        imgBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        imgBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
        imgBtn.TextSize = 14
        imgBtn.Font = Enum.Font.GothamBold
        imgBtn.Text = "Image " .. index
        imgBtn.Visible = false
        imgBtn.ZIndex = 3  -- Cao hơn select button
        imgBtn.Parent = container

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 7)
        corner.Parent = imgBtn

        imageButtons[index] = imgBtn


        -- =================================================
        -- SELECT IMAGE
        -- =================================================

        imgBtn.MouseButton1Click:Connect(function()

            selectedImage = MenuImages[index]
            selectedIndex = index

            -- Preview
            if backgroundImage then
                backgroundImage.Image = selectedImage
            end

            imageSelect.Text = "Image " .. index .. " ▼"

            -- Đóng dropdown
            dropdownOpen = false
            container.CanvasSize = UDim2.new(0, 0, 0, CANVAS_SIZE_CLOSED)

            for _, button in pairs(imageButtons) do
                button.Visible = false
            end

        end)

    end


    -- =====================================================
    -- APPLY BUTTON
    -- Luôn hiển thị bên ngoài dropdown
    -- =====================================================

    local applyButton = Instance.new("TextButton")
    applyButton.Name = "ApplyImage"
    applyButton.Size = UDim2.new(0.48, -5, 0, 45)
    applyButton.Position = UDim2.new(0, 10, 0, 395)
    applyButton.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
    applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyButton.TextSize = 15
    applyButton.Font = Enum.Font.GothamBold
    applyButton.Text = "Apply"
    applyButton.ZIndex = 2
    applyButton.Parent = container

    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 8)
    applyCorner.Parent = applyButton


    -- =====================================================
    -- RESET BUTTON
    -- Luôn hiển thị bên ngoài dropdown
    -- =====================================================

    local resetButton = Instance.new("TextButton")
    resetButton.Name = "ResetImage"
    resetButton.Size = UDim2.new(0.48, -5, 0, 45)
    resetButton.Position = UDim2.new(0.52, 0, 0, 395)
    resetButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.TextSize = 15
    resetButton.Font = Enum.Font.GothamBold
    resetButton.Text = "Reset"
    resetButton.ZIndex = 2
    resetButton.Parent = container

    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 8)
    resetCorner.Parent = resetButton


    -- =====================================================
    -- APPLY
    -- =====================================================

    applyButton.MouseButton1Click:Connect(function()

        if selectedImage then

            -- Xác nhận ảnh hiện tại
            originalImage = selectedImage

            if backgroundImage then
                backgroundImage.Image = originalImage
            end

            selectedImage = nil
            selectedIndex = nil

            if UI.Notify then
                UI.Notify("Menu Image Applied", 2)
            end

        end

    end)


    -- =====================================================
    -- RESET
    -- =====================================================

    resetButton.MouseButton1Click:Connect(function()

        if backgroundImage then
            backgroundImage.Image = originalImage
        end

        selectedImage = nil
        selectedIndex = nil

        imageSelect.Text = "Select Image ▼"

        if UI.Notify then
            UI.Notify("Menu Image Reset", 2)
        end

    end)


    -- =====================================================
    -- DROPDOWN
    -- =====================================================

    imageSelect.MouseButton1Click:Connect(function()

        dropdownOpen = not dropdownOpen

        -- Cập nhật canvas size khi dropdown mở/đóng
        if dropdownOpen then
            container.CanvasSize = UDim2.new(0, 0, 0, CANVAS_SIZE_OPENED)
        else
            container.CanvasSize = UDim2.new(0, 0, 0, CANVAS_SIZE_CLOSED)
        end

        for _, button in pairs(imageButtons) do
            button.Visible = dropdownOpen
        end

    end)

end

return MoreTab
