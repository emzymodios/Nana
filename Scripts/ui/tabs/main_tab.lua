local MainTab = {}

function MainTab.Create(mainContainer, UI)
    Elements.CreateSlider(mainContainer, 10, "Run Speed", 16, 200, 16, function(val)
        if UI.OnSpeedChanged then UI.OnSpeedChanged(val) end
    end)

    Elements.CreateSlider(mainContainer, 85, "Fly Speed", 10, 300, 50, function(val)
        if UI.OnFlySpeedChanged then UI.OnFlySpeedChanged(val) end
    end)

    Elements.CreateToggleRow(mainContainer, 160, "Speed Mode", function(state)
        if UI.OnSpeedToggled then UI.OnSpeedToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 215, "Fly Mode", function(state)
        if UI.OnFlyToggled then UI.OnFlyToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 270, "NoClip Mode", function(state)
        if UI.OnNoClipToggled then UI.OnNoClipToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 325, "Infinite Jump", function(state)
        if UI.OnJumpToggled then UI.OnJumpToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 380, "Soru (Click Tele)", function(state)
        if UI.OnSoruToggled then UI.OnSoruToggled(state) end
    end)

    Elements.CreateToggleRow(mainContainer, 435, "FPS Boost", function(state)
        if UI.OnFPSBoostToggled then UI.OnFPSBoostToggled(state) end
    end)

    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.9, 0, 0, 35)
    resetBtn.Position = UDim2.new(0.05, 0, 0, 490)
    resetBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 60)
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.TextSize = 13
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Text = "Reset Config"
    resetBtn.Parent = mainContainer

    local rCorner = Instance.new("UICorner")
    rCorner.CornerRadius = UDim.new(0, 8)
    rCorner.Parent = resetBtn
    
    local rStroke = Instance.new("UIStroke")
    rStroke.Color = Color3.fromRGB(220, 80, 80)
    rStroke.Thickness = 1
    rStroke.Parent = resetBtn

    resetBtn.MouseButton1Click:Connect(function()
        if UI.OnResetClicked then UI.OnResetClicked() end
    end)
end

return MainTab
