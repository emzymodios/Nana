-- Scripts/ui/notification.lua
-- Nana Hub Notification - Cyan Animated Border

local Notification = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

function Notification.Show(title, text, duration, iconId)
    duration = duration or 2

    local playerGui = player:WaitForChild("PlayerGui")

    local screenGui = playerGui:FindFirstChild("NanaNotificationGui")

    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NanaNotificationGui"
        screenGui.ResetOnSpawn = false
        screenGui.DisplayOrder = 999
        screenGui.Parent = playerGui
    end

    --==================================================
    -- MAIN
    --==================================================

    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "Notification"
    notifFrame.Size = UDim2.new(0, 260, 0, 65)
    notifFrame.Position = UDim2.new(1, -270, 1, -85)
    notifFrame.BackgroundColor3 = Color3.fromRGB(8, 18, 25)
    notifFrame.BackgroundTransparency = 0.2
    notifFrame.BorderSizePixel = 0
    notifFrame.ZIndex = 1
    notifFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notifFrame

    -- Viền cyan chính
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 220, 255)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.15
    stroke.Parent = notifFrame

    --==================================================
    -- MOVING CYAN LIGHT
    --==================================================

    local light = Instance.new("Frame")
    light.Name = "MovingLight"
    light.Size = UDim2.new(0, 45, 0, 2)
    light.Position = UDim2.new(0, -45, 0, 0)
    light.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    light.BorderSizePixel = 0
    light.ZIndex = 4
    light.Parent = notifFrame

    local lightCorner = Instance.new("UICorner")
    lightCorner.CornerRadius = UDim.new(1, 0)
    lightCorner.Parent = light

    -- Glow của tia sáng
    local lightGlow = Instance.new("Frame")
    lightGlow.Name = "Glow"
    lightGlow.Size = UDim2.new(1, 0, 0, 5)
    lightGlow.Position = UDim2.new(0, 0, 0.5, -2)
    lightGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    lightGlow.BackgroundTransparency = 0.65
    lightGlow.BorderSizePixel = 0
    lightGlow.ZIndex = 3
    lightGlow.Parent = light

    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(1, 0)
    glowCorner.Parent = lightGlow

    --==================================================
    -- ICON
    --==================================================

    if iconId and iconId ~= "" then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "Icon"
        iconImg.Size = UDim2.new(0, 40, 0, 40)
        iconImg.Position = UDim2.new(0, 12, 0, 12)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = iconId
        iconImg.ZIndex = 5
        iconImg.Parent = notifFrame
    end

    local textOffsetLeft = 12
    local textWidthSize = -20

    if iconId and iconId ~= "" then
        textOffsetLeft = 60
        textWidthSize = -70
    end

    --==================================================
    -- TITLE
    --==================================================

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Name = "Title"
    titleLbl.Size = UDim2.new(1, textWidthSize, 0, 22)
    titleLbl.Position = UDim2.new(0, textOffsetLeft, 0, 6)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = Color3.fromRGB(235, 255, 255)
    titleLbl.TextSize = 13
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 5
    titleLbl.Parent = notifFrame

    --==================================================
    -- DESCRIPTION
    --==================================================

    local descLbl = Instance.new("TextLabel")
    descLbl.Name = "Description"
    descLbl.Size = UDim2.new(1, textWidthSize, 0, 30)
    descLbl.Position = UDim2.new(0, textOffsetLeft, 0, 28)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = text
    descLbl.TextColor3 = Color3.fromRGB(120, 225, 245)
    descLbl.TextSize = 11
    descLbl.Font = Enum.Font.GothamMedium
    descLbl.TextWrapped = true
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.ZIndex = 5
    descLbl.Parent = notifFrame

    --==================================================
    -- ANIMATION
    -- Tia sáng chạy quanh 4 cạnh
    --==================================================

    local connection

    connection = RunService.RenderStepped:Connect(function()
        if not notifFrame.Parent then
            if connection then
                connection:Disconnect()
            end
            return
        end

        local t = (os.clock() * 0.8) % 4
        local side = math.floor(t)
        local progress = t - side

        if side == 0 then
            -- Trên: trái -> phải
            light.Size = UDim2.new(0, 45, 0, 2)
            light.Position = UDim2.new(progress, -22, 0, 0)

        elseif side == 1 then
            -- Phải: trên -> dưới
            light.Size = UDim2.new(0, 2, 0, 45)
            light.Position = UDim2.new(1, -2, progress, -22)

        elseif side == 2 then
            -- Dưới: phải -> trái
            light.Size = UDim2.new(0, 45, 0, 2)
            light.Position = UDim2.new(1 - progress, -22, 1, -2)

        else
            -- Trái: dưới -> trên
            light.Size = UDim2.new(0, 2, 0, 45)
            light.Position = UDim2.new(0, 0, 1 - progress, -22)
        end
    end)

    --==================================================
    -- AUTO REMOVE
    -- Giữ nguyên duration
    --==================================================

    task.delay(duration, function()
        if connection then
            connection:Disconnect()
        end

        if notifFrame and notifFrame.Parent then
            notifFrame:Destroy()
        end
    end)
end

return Notification
