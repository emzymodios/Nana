-- Nana Hub More Tab (more.lua)
local MoreTab = {}

function MoreTab.Create(container, UI)
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
