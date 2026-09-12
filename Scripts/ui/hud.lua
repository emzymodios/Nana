-- Scripts/ui/hud.lua
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local HUD = {}

function HUD.Init(screenGui)
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "HUDInfoLabel"
    infoLabel.Size = UDim2.new(0, 280, 0, 25)
    infoLabel.Position = UDim2.new(1, -295, 0, 10)
    infoLabel.BackgroundColor3 = Color3.fromRGB(10, 18, 28)
    infoLabel.BackgroundTransparency = 0.2
    infoLabel.BorderSizePixel = 0
    infoLabel.TextColor3 = Color3.fromRGB(225, 250, 255)
    infoLabel.TextSize = 12
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.Text = "TIME: 00:00 | FPS: 60 | PING: 0ms"
    infoLabel.ZIndex = 100
    infoLabel.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = infoLabel

    -- Viền cyan
    local stroke = Instance.new("UIStroke")
    stroke.Name = "CyanGlow"
    stroke.Color = Color3.fromRGB(0, 220, 255)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.05
    stroke.Parent = infoLabel

    -- Viền glow bên ngoài
    local glow = Instance.new("UIStroke")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 230)
    glow.Thickness = 4
    glow.Transparency = 0.78
    glow.Parent = infoLabel

    -- Gradient cyan nhẹ
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 230)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 190, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 230))
    })
    gradient.Rotation = 0
    gradient.Parent = stroke

    -- Hiệu ứng lấp lánh/chạy viền
    task.spawn(function()
        local offset = -1

        while infoLabel.Parent do
            offset += 0.025

            if offset > 1 then
                offset = -1
            end

            gradient.Offset = Vector2.new(offset, 0)

            -- Glow nhấp nháy rất nhẹ
            local pulse = (math.sin(os.clock() * 2.5) + 1) / 2
            glow.Transparency = 0.84 - pulse * 0.12

            task.wait(0.03)
        end
    end)

    -- Biến tính FPS mượt
    local lastUpdate = tick()
    local frameCount = 0
    local currentFPS = 60

    RunService.RenderStepped:Connect(function()
        if not infoLabel.Parent then
            return
        end

        frameCount += 1
        local now = tick()

        if now - lastUpdate >= 1 then
            currentFPS = math.floor(frameCount / (now - lastUpdate) + 0.5)
            frameCount = 0
            lastUpdate = now
        end

        local timeString = os.date("%H:%M")

        local pingVal = 0
        pcall(function()
            pingVal = math.floor(
                Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5
            )
        end)

        infoLabel.Text = string.format(
            "TIME: %s | FPS: %d | PING: %dms",
            timeString,
            currentFPS,
            pingVal
        )
    end)
end

return HUD
