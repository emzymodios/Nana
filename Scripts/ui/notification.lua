-- Scripts/ui/notification.lua
-- Nana Hub Notification - Clean Thick Cyan Border

local Notification = {}

local Players = game:GetService("Players")

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

    --==================================================
    -- ROUNDED CORNER
    --==================================================

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = notifFrame

    --==================================================
    -- THICK CYAN BORDER
    -- Gấp 2 lần viền cũ
    --==================================================

    local stroke = Instance.new("UIStroke")
    stroke.Name = "Border"
    stroke.Color = Color3.fromRGB(0, 230, 255)
    stroke.Thickness = 2.8
    stroke.Transparency = 0
    stroke.Parent = notifFrame

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
    -- AUTO REMOVE
    --==================================================

    task.delay(duration, function()
        if notifFrame and notifFrame.Parent then
            notifFrame:Destroy()
        end
    end)
end

return Notification
