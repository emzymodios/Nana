-- Nana Hub More Tab (more.lua) - AUTO RELOAD VERSION
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

    -- Đọc ảnh đã lưu từ _G (nếu có từ lần trước)
    local savedImage = _G.NanaHubBackgroundImage or ""
    
    -- Ảnh ban đầu
    local originalImage = savedImage ~= "" and savedImage or (backgroundImage and backgroundImage.Image or "")

    if backgroundImage and originalImage ~= "" then
        backgroundImage.Image = originalImage
    end

    local selectedImage = nil
    local selectedIndex = nil
    local dropdownOpen = false


    -- =====================================================
    -- CANVAS
    -- =====================================================

    container.CanvasSize = UDim2.new(0, 0, 0, 550)


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
    -- IMAGE PREVIEW
    -- =====================================================

    local imagePreview = Instance.new("ImageLabel")
    imagePreview.Name = "ImagePreview"
    imagePreview.Size = UDim2.new(1, -20, 0, 80)
    imagePreview.Position = UDim2.new(0, 10, 0, 135)
    imagePreview.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    imagePreview.Image = originalImage
    imagePreview.ScaleType = Enum.ScaleType.Fit
    imagePreview.ZIndex = 1
    imagePreview.Parent = container

    local previewCorner = Instance.new("UICorner")
    previewCorner.CornerRadius = UDim.new(0, 8)
    previewCorner.Parent = imagePreview


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
            220 + ((i - 1) * 42)
        )

        imgBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        imgBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
        imgBtn.TextSize = 14
        imgBtn.Font = Enum.Font.GothamBold
        imgBtn.Text = "Image " .. index
        imgBtn.Visible = false
        imgBtn.ZIndex = 3
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
            imagePreview.Image = selectedImage
            imageSelect.Text = "Image " .. index .. " ▼"

            -- Đóng dropdown
            dropdownOpen = false
            container.CanvasSize = UDim2.new(0, 0, 0, 400)

            for _, button in pairs(imageButtons) do
                button.Visible = false
            end

        end)

    end


    -- =====================================================
    -- APPLY BUTTON
    -- =====================================================

    local applyButton = Instance.new("TextButton")
    applyButton.Name = "ApplyImage"
    applyButton.Size = UDim2.new(0.48, -5, 0, 40)
    applyButton.Position = UDim2.new(0, 10, 0, 220)
    applyButton.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
    applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyButton.TextSize = 14
    applyButton.Font = Enum.Font.GothamBold
    applyButton.Text = "Apply"
    applyButton.ZIndex = 2
    applyButton.Parent = container

    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 8)
    applyCorner.Parent = applyButton


    -- =====================================================
    -- RESET BUTTON
    -- =====================================================

    local resetButton = Instance.new("TextButton")
    resetButton.Name = "ResetImage"
    resetButton.Size = UDim2.new(0.48, -5, 0, 40)
    resetButton.Position = UDim2.new(0.52, 0, 0, 220)
    resetButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.TextSize = 14
    resetButton.Font = Enum.Font.GothamBold
    resetButton.Text = "Reset"
    resetButton.ZIndex = 2
    resetButton.Parent = container

    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 8)
    resetCorner.Parent = resetButton


    -- =====================================================
    -- 🔄 AUTO RELOAD FUNCTION
    -- =====================================================

    local function reloadUI()
        if UI.Notify then
            UI.Notify("⏳ Reloading UI to apply image...", 2)
        end

        -- Chờ 0.5 giây rồi destroy UI
        task.wait(0.5)

        local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        local nanaUI = playerGui:FindFirstChild("NanaHubUI")
        
        if nanaUI then
            nanaUI:Destroy()
        end

        -- Chờ UI tái khởi tạo
        task.wait(0.5)

        -- Gọi lại UI.Init() để reload
        if UI.Init then
            UI.Init()
        end

        if UI.Notify then
            UI.Notify("✅ UI Reloaded! Image Applied!", 2)
        end
    end


    -- =====================================================
    -- 🎯 APPLY - LƯU + RELOAD
    -- =====================================================

    applyButton.MouseButton1Click:Connect(function()

        if selectedImage then

            -- 1️⃣ Lưu ảnh vào _G (để persist qua reload)
            _G.NanaHubBackgroundImage = selectedImage

            -- 2️⃣ Cập nhật background image hiện tại
            originalImage = selectedImage
            imagePreview.Image = originalImage
            
            if backgroundImage then
                backgroundImage.Image = originalImage
            end

            -- 3️⃣ Reset select
            selectedImage = nil
            selectedIndex = nil
            imageSelect.Text = "Select Image ▼"

            if UI.Notify then
                UI.Notify("✅ Image saved! Reloading...", 3)
            end

            -- 4️⃣ RELOAD UI - Đây chính là phần quan trọng!
            -- Spawn async để không block
            task.spawn(function()
                reloadUI()
            end)

        else
            if UI.Notify then
                UI.Notify("⚠️ Please select an image first", 2)
            end
        end

    end)


    -- =====================================================
    -- RESET
    -- =====================================================

    resetButton.MouseButton1Click:Connect(function()

        -- Xóa ảnh đã lưu
        _G.NanaHubBackgroundImage = nil

        -- Reset preview và background về original
        imagePreview.Image = ""

        if backgroundImage then
            backgroundImage.Image = ""
        end

        selectedImage = nil
        selectedIndex = nil
        imageSelect.Text = "Select Image ▼"

        if UI.Notify then
            UI.Notify("🔄 Image Reset! Reloading...", 2)
        end

        -- Reload UI
        task.spawn(function()
            reloadUI()
        end)

    end)


    -- =====================================================
    -- DROPDOWN
    -- =====================================================

    imageSelect.MouseButton1Click:Connect(function()

        dropdownOpen = not dropdownOpen

        if dropdownOpen then
            container.CanvasSize = UDim2.new(0, 0, 0, 550)
        else
            container.CanvasSize = UDim2.new(0, 0, 0, 400)
        end

        for _, button in pairs(imageButtons) do
            button.Visible = dropdownOpen
        end

    end)

end

return MoreTab
