-- Scripts/ui/hud.lua
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")

local HUD = {}

function HUD.Init(screenGui)
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "HUDInfoLabel"
    infoLabel.Size = UDim2.new(0, 280, 0, 25)
    infoLabel.Position = UDim2.new(1, -295, 0, 10)
    infoLabel.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    infoLabel.BackgroundTransparency = 0.3
    infoLabel.BorderSizePixel = 0
    infoLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    infoLabel.TextSize = 12
    infoLabel.Font = Enum.Font.GothamBold
    infoLabel.Text = "TIME: 00:00 | FPS: 60 | PING: 0ms"
    infoLabel.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = infoLabel

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(70, 50, 120)
    stroke.Thickness = 1
    stroke.Parent = infoLabel

    -- Biến tính toán FPS mượt
    local lastUpdate = tick()
    local frameCount = 0
    local currentFPS = 60

    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = tick()
        if now - lastUpdate >= 1 then
            currentFPS = math.floor(frameCount / (now - lastUpdate) + 0.5)
            frameCount = 0
            lastUpdate = now
        end

        -- Lấy thời gian thực (giờ địa phương)
        local timeString = os.date("%H:%M")

        -- Lấy chỉ số Ping (ms)
        local pingVal = 0
        pcall(function()
            pingVal = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
        end)

        infoLabel.Text = string.format("TIME: %s | FPS: %d | PING: %dms", timeString, currentFPS, pingVal)
    end)
end

return HUD
