-- Nana Hub More Tab (more.lua)
local MoreTab = {}

function MoreTab.Create(container, UI, backgroundImage)

    container.CanvasSize = UDim2.new(0, 0, 0, 350)

    local MenuImages = {
        ["1"] = "rbxassetid://87216058850864",
        ["2"] = "rbxassetid://80180772119955",
        ["3"] = "rbxassetid://139389295695753",
        ["4"] = "rbxassetid://130618081155480",
        ["5"] = "rbxassetid://84744590711663",
        ["6"] = "rbxassetid://116222439691339"
    }

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


    -- MENU IMAGE DROPDOWN
    local imageTitle = Instance.new("TextLabel")
    imageTitle.Size = UDim2.new(1,-20,0,25)
    imageTitle.Position = UDim2.new(0,10,0,45)
    imageTitle.BackgroundTransparency = 1
    imageTitle.TextColor3 = Color3.fromRGB(255,255,255)
    imageTitle.Text = "Menu Image"
    imageTitle.Font = Enum.Font.GothamBold
    imageTitle.TextXAlignment = Enum.TextXAlignment.Left
    imageTitle.Parent = container


    local imageSelect = Instance.new("TextButton")
    imageSelect.Size = UDim2.new(1,-20,0,35)
    imageSelect.Position = UDim2.new(0,10,0,75)
    imageSelect.BackgroundColor3 = Color3.fromRGB(25,25,35)
    imageSelect.TextColor3 = Color3.fromRGB(255,255,255)
    imageSelect.Font = Enum.Font.GothamBold
    imageSelect.Text = "Select Image ▼"
    imageSelect.Parent = container


    local dropdown = false

    for i = 1,6 do

        local imgBtn = Instance.new("TextButton")
        imgBtn.Size = UDim2.new(1,-20,0,30)
        imgBtn.Position = UDim2.new(0,10,0,75+(i*35))
        imgBtn.BackgroundColor3 = Color3.fromRGB(35,35,45)
        imgBtn.TextColor3 = Color3.fromRGB(220,220,220)
        imgBtn.Text = tostring(i)
        imgBtn.Visible = false
        imgBtn.Parent = container


        imgBtn.MouseButton1Click:Connect(function()

            if backgroundImage then
                backgroundImage.Image = MenuImages[tostring(i)]
            end

            imageSelect.Text = "Image "..i.." ▼"

            for _,v in pairs(container:GetChildren()) do
                if v:IsA("TextButton") and v ~= imageSelect then
                    v.Visible = false
                end
            end

        end)

    end


    imageSelect.MouseButton1Click:Connect(function()

        dropdown = not dropdown

        for _,v in pairs(container:GetChildren()) do
            if v:IsA("TextButton") and v ~= imageSelect then
                if v.Position.Y.Offset > 100 then
                    v.Visible = dropdown
                end
            end
        end

    end)


    -- GODMODE
    local godmodeBtn = Instance.new("TextButton")
    godmodeBtn.Size = UDim2.new(1, -20, 0, 40)
    godmodeBtn.Position = UDim2.new(0, 10, 0, 310)
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
            godmodeBtn.BackgroundColor3 = Color3.fromRGB(70,50,160)
            godmodeBtn.TextColor3 = Color3.fromRGB(255,255,255)
            godmodeBtn.Text = "Godmode: ON"

            if UI.Notify then
                UI.Notify("Godmode Enabled",2)
            end

        else

            godmodeBtn.BackgroundColor3 = Color3.fromRGB(25,25,35)
            godmodeBtn.TextColor3 = Color3.fromRGB(180,180,200)
            godmodeBtn.Text = "Godmode: OFF"

            if UI.Notify then
                UI.Notify("Godmode Disabled",2)
            end

        end


        if UI.OnGodmodeToggled then
            UI.OnGodmodeToggled(godmodeState)
        end

    end)

end

return MoreTab
