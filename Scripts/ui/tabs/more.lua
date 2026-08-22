-- Nana Hub More Tab (more.lua)
local MoreTab = {}

function MoreTab.Create(container, UI, backgroundImage)
    -- Dùng luôn container (moreContainer) được truyền từ ui.lua qua, không tạo thêm khung nữa
    container.CanvasSize = UDim2.new(0, 0, 0, 150)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Other More"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = container
local MenuImages = {
    ["1"] = "rbxassetid://87216058850864",
    ["2"] = "rbxassetid://80180772119955",
    ["3"] = "rbxassetid://139389295695753",
    ["4"] = "rbxassetid://130618081155480",
    ["5"] = "rbxassetid://84744590711663",
    ["6"] = "rbxassetid://116222439691339"
}

local imageTitle = Instance.new("TextLabel")
imageTitle.Size = UDim2.new(1, -20, 0, 30)
imageTitle.Position = UDim2.new(0, 10, 0, 50)
imageTitle.BackgroundTransparency = 1
imageTitle.TextColor3 = Color3.fromRGB(255,255,255)
imageTitle.TextSize = 14
imageTitle.Font = Enum.Font.GothamBold
imageTitle.Text = "Menu Image"
imageTitle.TextXAlignment = Enum.TextXAlignment.Left
imageTitle.Parent = container


local imageDropdown = Instance.new("TextButton")
imageDropdown.Size = UDim2.new(1, -20, 0, 35)
imageDropdown.Position = UDim2.new(0,10,0,85)
imageDropdown.BackgroundColor3 = Color3.fromRGB(25,25,35)
imageDropdown.TextColor3 = Color3.fromRGB(255,255,255)
imageDropdown.Font = Enum.Font.GothamBold
imageDropdown.Text = "Select Image ▼"
imageDropdown.Parent = container


local dropdownOpen = false

for i = 1,6 do
    local imgBtn = Instance.new("TextButton")
    imgBtn.Size = UDim2.new(1,-20,0,30)
    imgBtn.Position = UDim2.new(0,10,0,85+(i*35))
    imgBtn.BackgroundColor3 = Color3.fromRGB(35,35,45)
    imgBtn.TextColor3 = Color3.fromRGB(220,220,220)
    imgBtn.Text = "Image "..i
    imgBtn.Visible = false
    imgBtn.Parent = container

    imgBtn.MouseButton1Click:Connect(function()
        if backgroundImage then
            backgroundImage.Image = MenuImages[tostring(i)]
        end

        imageDropdown.Text = "Image "..i.." ▼"

        for _,v in pairs(container:GetChildren()) do
            if v:IsA("TextButton") and v ~= imageDropdown then
                v.Visible = false
            end
        end
    end)
end


imageDropdown.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen

    for _,v in pairs(container:GetChildren()) do
        if v:IsA("TextButton") and v ~= imageDropdown then
            v.Visible = dropdownOpen
        end
    end
end)
    
    local godmodeBtn = Instance.new("TextButton")
    godmodeBtn.Size = UDim2.new(1, -20, 0, 40)
    godmodeBtn.Position = UDim2.new(0, 10, 0, 50)
    godmodeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    godmodeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    godmodeBtn.TextSize = 13
    godmodeBtn.Font = Enum.Font.GothamBold
    godmodeBtn.Text = "Godmode: OFF"
    godmodeBtn.Parent = container

    local btnCorner1 = Instance.new("UICorner")
    btnCorner1.CornerRadius = UDim.new(0, 8)
    btnCorner1.Parent = godmodeBtn

    local godmodeState = false
    godmodeBtn.MouseButton1Click:Connect(function()
        godmodeState = not godmodeState
        if godmodeState then
            godmodeBtn.BackgroundColor3 = Color3.fromRGB(70, 50, 160)
            godmodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            godmodeBtn.Text = "Godmode: ON"
            if UI.Notify then UI.Notify("Godmode Enabled", 2) end
        else
            godmodeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            godmodeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
            godmodeBtn.Text = "Godmode: OFF"
            if UI.Notify then UI.Notify("Godmode Disabled", 2) end
        end

        if UI.OnGodmodeToggled then
            UI.OnGodmodeToggled(godmodeState)
        end
    end)
end

return MoreTab
