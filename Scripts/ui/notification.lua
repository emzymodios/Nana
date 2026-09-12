-- Scripts/ui/notification.lua
-- Nana Hub Notification - Cyan Neon Animated Border

local Notification = {}

local players = game:GetService("Players")
local player = players.LocalPlayer

function Notification.Show(title, text, duration, iconId)
    duration = duration or 2
    local playerGui = player:WaitForChild("PlayerGui")

    -- Notification GUI riêng
    local screenGui = playerGui:FindFirstChild("NanaNotificationGui")

    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NanaNotificationGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui
    end

    --==================================================
    -- MAIN FRAME
    --==================================================

    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "Notification"
    notifFrame.Size = UDim2.new(0, 260, 0, 65)
    notifFrame.Position = UDim2.new(1, -270, 1, -85)

    -- Cyan / dark background
    notifFrame.BackgroundColor3 = Color3.fromRGB(8, 18, 25)
    notifFrame.BackgroundTransparency = 0.25
    notifFrame.BorderSizePixel = 0
    notifFrame.ClipsDescendants = false
    notifFrame.Parent = screenGui

    local nCorner = Instance.new("UICorner")
    nCorner.CornerRadius = UDim.new(0, 8)
    nCorner.Parent = notifFrame

    --==================================================
    -- STATIC CYAN BORDER
    --==================================================

    local nStroke = Instance.new("UIStroke")
    nStroke.Name = "CyanBorder"
    nStroke.Color = Color3.fromRGB(0, 220, 255)
    nStroke.Thickness = 1.5
    nStroke.Transparency = 0.15
    nStroke.Parent = notifFrame

    --==================================================
    -- OUTER GLOW
    --==================================================

    local glowStroke = Instance.new("UIStroke")
    glowStroke.Name = "CyanGlow"
    glowStroke.Color = Color3.fromRGB(0, 255, 230)
    glowStroke.Thickness = 4
    glowStroke.Transparency = 0.78
    glowStroke.Parent = notifFrame

    --==================================================
    -- MOVING BORDER EFFECT
    --==================================================

    local movingBorder = Instance.new("Frame")
    movingBorder.Name = "MovingBorder"
    movingBorder.Size = UDim2.new(1, 0, 1, 0)
    movingBorder.Position = UDim2.new(0, 0, 0, 0)
    movingBorder.BackgroundTransparency = 1
    movingBorder.BorderSizePixel = 0
    movingBorder.ZIndex = 20
    movingBorder.Parent = notifFrame

    local movingCorner = Instance.new("UICorner")
    movingCorner.CornerRadius = UDim.new(0, 8)
    movingCorner.Parent = movingBorder

    -- Gradient chạy quanh viền
    local movingStroke = Instance.new("UIStroke")
    movingStroke.Name = "MovingCyanStroke"
    movingStroke.Color = Color3.fromRGB(0, 255, 255)
    movingStroke.Thickness = 2.5
    movingStroke.Transparency = 0.05
    movingStroke.Parent = movingBorder

    local borderGradient = Instance.new("UIGradient")
    borderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.18, Color3.fromRGB(0, 255, 230)),
        ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 180, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 90, 120)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 180, 255)),
        ColorSequenceKeypoint.new(0.85, Color3.fromRGB(0, 255, 230)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    })

    borderGradient.Rotation = 0
    borderGradient.Parent = movingStroke

    -- Chạy gradient liên tục
    task.spawn(function()
        local offset = -1

        while notifFrame.Parent do
            offset += 0.025

            if offset > 1 then
                offset = -1
            end

            borderGradient.Offset = Vector2.new(offset, 0)

            -- Glow nhẹ
            local pulse = (math.sin(os.clock() * 3) + 1) / 2
            glowStroke.Transparency = 0.84 - pulse * 0.12

            task.wait(0.03)
        end
    end)

    --==================================================
    -- ICON
    --==================================================

    if iconId and iconId ~= "" then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Size = UDim2.new(0, 40, 0, 40)
        iconImg.Position = UDim2.new(0, 12, 0, 12)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = iconId
        iconImg.ZIndex = 5
        iconImg.Parent = notifFrame
    end

    local textOffsetLeft =
        (iconId and iconId ~= "") and 60 or 12

    local textWidthSize =
        (iconId and iconId ~= "") and -70 or -20

    --==================================================
    -- TITLE
    --==================================================

    local titleLbl = Instance.new("TextLabel")
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
    -- AUTO REMOVE
    -- Giữ nguyên duration
    --==================================================

    task.delay(duration, function()
        if notifFrame and notifFrame.Parent then
            notifFrame:Destroy()
        end
    end)
end

return Notification

Thời gian hiện thông báo không đổi: vẫn dùng "duration", mặc định 2 giây, và hết thời gian sẽ tự xóa như file cũ.
