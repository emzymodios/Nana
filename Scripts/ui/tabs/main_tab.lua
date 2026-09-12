local Elements = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua"))()

local MainTab = {}

function MainTab.Create(mainContainer, UI)

    -- =========================================================
    -- MAIN - NANA HUB CYAN STYLE (Đã đẩy posY xuống tránh đè viền)
    -- =========================================================

    Elements.CreateSlider(mainContainer, 45, "Run", 16, 700, 16, function(val)
        if UI.OnSpeedChanged then
            UI.OnSpeedChanged(val)
        end
    end)

    Elements.CreateSlider(mainContainer, 120, "Fly", 10, 800, 50, function(val)
        if UI.OnFlySpeedChanged then
            UI.OnFlySpeedChanged(val)
        end
    end)

    Elements.CreateToggleRow(mainContainer, 195, "Speed Mode", function(state)
        if UI.OnSpeedToggled then
            UI.OnSpeedToggled(state)
        end
    end)

    Elements.CreateToggleRow(mainContainer, 250, "Fly Mode", function(state)
        if UI.OnFlyToggled then
            UI.OnFlyToggled(state)
        end
    end)

    Elements.CreateToggleRow(mainContainer, 305, "NoClip Mode", function(state)
        if UI.OnNoClipToggled then
            UI.OnNoClipToggled(state)
        end
    end)

    Elements.CreateToggleRow(mainContainer, 360, "Infinite Jump", function(state)
        if UI.OnJumpToggled then
            UI.OnJumpToggled(state)
        end
    end)

    Elements.CreateToggleRow(mainContainer, 415, "Soru (Click Tele)", function(state)
        if UI.OnSoruToggled then
            UI.OnSoruToggled(state)
        end
    end)

    Elements.CreateToggleRow(mainContainer, 470, "FPS Boost", function(state)
        if UI.OnFPSBoostToggled then
            UI.OnFPSBoostToggled(state)
        end
    end)

    -- =========================================================
    -- RESET CONFIG - ĐỒNG BỘ MÀU NANA HUB
    -- =========================================================

    local resetBtn = Instance.new("TextButton")
    resetBtn.Name = "ResetConfig"
    resetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    resetBtn.Position = UDim2.new(0.05, 0, 0, 535)

    -- Nền xanh đậm giống UI
    resetBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
    resetBtn.BackgroundTransparency = 0.15

    -- Chữ xanh sáng
    resetBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
    resetBtn.TextSize = 13
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Text = "Reset Config"

    resetBtn.BorderSizePixel = 0
    resetBtn.AutoButtonColor = false
    resetBtn.Active = true
    resetBtn.ZIndex = 4
    resetBtn.Parent = mainContainer

    -- Bo góc
    local rCorner = Instance.new("UICorner")
    rCorner.CornerRadius = UDim.new(0, 8)
    rCorner.Parent = resetBtn

    -- Viền cyan giống tab UI
    local rStroke = Instance.new("UIStroke")
    rStroke.Color = Color3.fromRGB(0, 200, 255)
    rStroke.Transparency = 0.15
    rStroke.Thickness = 1
    rStroke.Parent = resetBtn

    -- Hover / click effect
    resetBtn.MouseEnter:Connect(function()
        resetBtn.BackgroundColor3 = Color3.fromRGB(25, 45, 65)
        rStroke.Color = Color3.fromRGB(0, 255, 220)
    end)

    resetBtn.MouseLeave:Connect(function()
        resetBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
        rStroke.Color = Color3.fromRGB(0, 200, 255)
    end)

    resetBtn.MouseButton1Click:Connect(function()
        if UI.OnResetClicked then
            UI.OnResetClicked()
        end
    end)
end

return MainTab
