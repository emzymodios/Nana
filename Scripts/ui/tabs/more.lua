-- Nana Hub More Tab (more.lua)
local MoreTab = {}

function MoreTab.Create(container, UI)
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = "MoreTabContent"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 300)
    tabContent.ScrollBarThickness = 4
    tabContent.Parent = container

    -- Tiêu đề tab
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Other More"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = tabContent

    -- Nút gạt (Toggle) Godmode
    local godmodeBtn = Instance.new("TextButton")
    godmodeBtn.Size = UDim2.new(1, -20, 0, 40)
    godmodeBtn.Position = UDim2.new(0, 10, 0, 50)
    godmodeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    godmodeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    godmodeBtn.TextSize = 13
    godmodeBtn.Font = Enum.Font.GothamBold
    godmodeBtn.Text = "Godmode: OFF"
    godmodeBtn.Parent = tabContent

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

    -- Nút Rejoin Game
    local rejoinBtn = Instance.new("TextButton")
    rejoinBtn.Size = UDim2.new(1, -20, 0, 40)
    rejoinBtn.Position = UDim2.new(0, 10, 0, 105)
    rejoinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    rejoinBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    rejoinBtn.TextSize = 13
    rejoinBtn.Font = Enum.Font.GothamBold
    rejoinBtn.Text = "Rejoin Game"
    rejoinBtn.Parent = tabContent

    local btnCorner2 = Instance.new("UICorner")
    btnCorner2.CornerRadius = UDim.new(0, 8)
    btnCorner2.Parent = rejoinBtn

    rejoinBtn.MouseButton1Click:Connect(function()
        if UI.Notify then UI.Notify("Rejoining...", 2) end
        if UI.OnRejoinClicked then
            UI.OnRejoinClicked()
        end
    end)

    -- Nút Server Hop
    local serverHopBtn = Instance.new("TextButton")
    serverHopBtn.Size = UDim2.new(1, -20, 0, 40)
    serverHopBtn.Position = UDim2.new(0, 10, 0, 160)
    serverHopBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    serverHopBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    serverHopBtn.TextSize = 13
    serverHopBtn.Font = Enum.Font.GothamBold
    serverHopBtn.Text = "Server Hop"
    serverHopBtn.Parent = tabContent

    local btnCorner3 = Instance.new("UICorner")
    btnCorner3.CornerRadius = UDim.new(0, 8)
    btnCorner3.Parent = serverHopBtn

    serverHopBtn.MouseButton1Click:Connect(function()
        if UI.Notify then UI.Notify("Finding new server...", 2) end
        if UI.OnServerHopClicked then
            UI.OnServerHopClicked()
        end
    end)

    return tabContent
end

return MoreTab
