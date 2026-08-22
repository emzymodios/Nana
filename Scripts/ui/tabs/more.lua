-- Nana Hub More Tab (more.lua)
local MoreTab = {}

function MoreTab.Create(container, UI, backgroundImage)

    container.CanvasSize = UDim2.new(0, 0, 0, 520)

    local MenuImages = {
        ["1"] = "rbxassetid://87216058850864",
        ["2"] = "rbxassetid://80180772119955",
        ["3"] = "rbxassetid://139389295695753",
        ["4"] = "rbxassetid://130618081155480",
        ["5"] = "rbxassetid://84744590711663",
        ["6"] = "rbxassetid://116222439691339"
    }

    -- Lưu ảnh ban đầu
    local originalImage = nil

    if backgroundImage then
        originalImage = backgroundImage.Image
    end

    local selectedImage = nil
    local dropdownOpen = false


    -- TITLE
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 35)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 17
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Other More"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = container


    -- IMAGE TITLE
    local imageTitle = Instance.new("TextLabel")
    imageTitle.Size = UDim2.new(1, -20, 0, 30)
    imageTitle.Position = UDim2.new(0, 10, 0, 50)
    imageTitle.BackgroundTransparency = 1
    imageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    imageTitle.TextSize = 15
    imageTitle.Font = Enum.Font.GothamBold
    imageTitle.Text = "Menu Image"
    imageTitle.TextXAlignment = Enum.TextXAlignment.Left
    imageTitle.Parent = container


    -- SELECT IMAGE
    local imageSelect = Instance.new("TextButton")
    imageSelect.Size = UDim2.new(1, -20, 0, 45)
    imageSelect.Position = UDim2.new(0, 10, 0, 85)
    imageSelect.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    imageSelect.TextColor3 = Color3.fromRGB(255, 255, 255)
    imageSelect.TextSize = 15
    imageSelect.Font = Enum.Font.GothamBold
    imageSelect.Text = "Select Image ▼"
    imageSelect.Parent = container

    local selectCorner = Instance.new("UICorner")
    selectCorner.CornerRadius = UDim.new(0, 8)
    selectCorner.Parent = imageSelect


    -- IMAGE BUTTONS
    local imageButtons = {}

    for i = 1, 6 do

        local index = tostring(i)

        local imgBtn = Instance.new("TextButton")
        imgBtn.Name = "ImageButton_" .. index
        imgBtn.Size = UDim2.new(1, -20, 0, 38)
        imgBtn.Position = UDim2.new(0, 10, 0, 135 + ((i - 1) * 42))
        imgBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        imgBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
        imgBtn.TextSize = 14
        imgBtn.Font = Enum.Font.GothamBold
        imgBtn.Text = "Image " .. index
        imgBtn.Visible = false
        imgBtn.Parent = container

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 7)
        corner.Parent = imgBtn

        imageButtons[index] = imgBtn


        imgBtn.MouseButton1Click:Connect(function()

            selectedImage = MenuImages[index]

            -- Preview ngay lập tức
            if backgroundImage then
                backgroundImage.Image = selectedImage
            end

            imageSelect.Text = "Image " .. index .. " ▼"

            -- Đóng dropdown
            dropdownOpen = false

            for _, button in pairs(imageButtons) do
                button.Visible = false
            end

            -- Hiện Apply / Reset
            applyButton.Visible = true
            resetButton.Visible = true

        end)

    end


    -- APPLY BUTTON
    applyButton = Instance.new("TextButton")
    applyButton.Name = "ApplyImage"
    applyButton.Size = UDim2.new(0.48, -5, 0, 42)
    applyButton.Position = UDim2.new(0, 10, 0, 405)
    applyButton.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
    applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyButton.TextSize = 14
    applyButton.Font = Enum.Font.GothamBold
    applyButton.Text = "Apply"
    applyButton.Visible = false
    applyButton.Parent = container

    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 8)
    applyCorner.Parent = applyButton


    -- RESET BUTTON
    resetButton = Instance.new("TextButton")
    resetButton.Name = "ResetImage"
    resetButton.Size = UDim2.new(0.48, -5, 0, 42)
    resetButton.Position = UDim2.new(0.52, 0, 0, 405)
    resetButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.TextSize = 14
    resetButton.Font = Enum.Font.GothamBold
    resetButton.Text = "Reset"
    resetButton.Visible = false
    resetButton.Parent = container

    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 8)
    resetCorner.Parent = resetButton


    -- APPLY
    applyButton.MouseButton1Click:Connect(function()

        if selectedImage then

            originalImage = selectedImage
            selectedImage = nil

            applyButton.Visible = false
            resetButton.Visible = false

            if UI.Notify then
                UI.Notify("Image Applied", 2)
            end

        end

    end)


    -- RESET
    resetButton.MouseButton1Click:Connect(function()

        if backgroundImage then
            backgroundImage.Image = originalImage
        end

        selectedImage = nil

        imageSelect.Text = "Select Image ▼"

        applyButton.Visible = false
        resetButton.Visible = false

        if UI.Notify then
            UI.Notify("Image Reset", 2)
        end

    end)


    -- DROPDOWN
    imageSelect.MouseButton1Click:Connect(function()

        dropdownOpen = not dropdownOpen

        for _, button in pairs(imageButtons) do
            button.Visible = dropdownOpen
        end

    end)

end

return MoreTab
