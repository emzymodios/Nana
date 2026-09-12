-- Scripts/ui/notification.lua
-- Nana Hub Notification - 3 Cyan Animated Border Lights

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
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = notifFrame

    --==================================================
    -- BASE BORDER
    --==================================================

    local stroke = Instance.new("UIStroke")
    stroke.Name = "Border"
    stroke.Color = Color3.fromRGB(0, 180, 215)
    stroke.Thickness = 1.4
    stroke.Transparency = 0.35
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
    -- BORDER LIGHT SYSTEM
    --
    -- 3 tia chạy quanh toàn bộ notification.
    -- Mỗi tia cách nhau 1/3 vòng.
    --==================================================

    local lights = {}

    local function createLight(index)
        local light = Instance.new("Frame")
        light.Name = "BorderLight_" .. index
        light.Size = UDim2.new(0, 34, 0, 2)
        light.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        light.BackgroundTransparency = 0.05
        light.BorderSizePixel = 0
        light.ZIndex = 4
        light.Parent = notifFrame

        local lightCorner = Instance.new("UICorner")
        lightCorner.CornerRadius = UDim.new(1, 0)
        lightCorner.Parent = light

        -- Glow
        local glow = Instance.new("Frame")
        glow.Name = "Glow"
        glow.Size = UDim2.new(1, 0, 0, 7)
        glow.Position = UDim2.new(0, 0, 0.5, -3.5)
        glow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        glow.BackgroundTransparency = 0.78
        glow.BorderSizePixel = 0
        glow.ZIndex = 3
        glow.Parent = light

        local glowCorner = Instance.new("UICorner")
        glowCorner.CornerRadius = UDim.new(1, 0)
        glowCorner.Parent = glow

        lights[index] = light
    end

    for i = 1, 3 do
        createLight(i)
    end

    --==================================================
    -- ROUNDED RECTANGLE PATH
    --
    -- Path gồm:
    -- Top
    -- Góc phải trên
    -- Right
    -- Góc phải dưới
    -- Bottom
    -- Góc trái dưới
    -- Left
    -- Góc trái trên
    --==================================================

    local width = 260
    local height = 65
    local radius = 10

    local straightTop = width - radius * 2
    local straightSide = height - radius * 2

    local arcLength = math.pi * radius / 2

    local perimeter =
        straightTop +
        arcLength +
        straightSide +
        arcLength +
        straightTop +
        arcLength +
        straightSide +
        arcLength

    -- Trả về vị trí + hướng của một điểm trên border.
    local function getPoint(distance)

        distance = distance % perimeter

        -- TOP: trái -> phải
        if distance <= straightTop then
            local x = radius + distance
            return x, 0, true
        end

        distance -= straightTop

        -- TOP RIGHT CORNER
        if distance <= arcLength then
            local a = -math.pi / 2 + (distance / arcLength) * (math.pi / 2)

            local cx = width - radius
            local cy = radius

            local x = cx + math.cos(a) * radius
            local y = cy + math.sin(a) * radius

            return x, y, false
        end

        distance -= arcLength

        -- RIGHT
        if distance <= straightSide then
            local y = radius + distance
            return width, y, false
        end

        distance -= straightSide

        -- BOTTOM RIGHT CORNER
        if distance <= arcLength then
            local a = (distance / arcLength) * (math.pi / 2)

            local cx = width - radius
            local cy = height - radius

            local x = cx + math.cos(a) * radius
            local y = cy + math.sin(a) * radius

            return x, y, false
        end

        distance -= arcLength

        -- BOTTOM: phải -> trái
        if distance <= straightTop then
            local x = width - radius - distance
            return x, height, true
        end

        distance -= straightTop

        -- BOTTOM LEFT CORNER
        if distance <= arcLength then
            local a = math.pi / 2 + (distance / arcLength) * (math.pi / 2)

            local cx = radius
            local cy = height - radius

            local x = cx + math.cos(a) * radius
            local y = cy + math.sin(a) * radius

            return x, y, false
        end

        distance -= arcLength

        -- LEFT
        if distance <= straightSide then
            local y = height - radius - distance
            return 0, y, false
        end

        distance -= straightSide

        -- TOP LEFT CORNER
        local a = math.pi + (distance / arcLength) * (math.pi / 2)

        local cx = radius
        local cy = radius

        local x = cx + math.cos(a) * radius
        local y = cy + math.sin(a) * radius

        return x, y, false
    end

    --==================================================
    -- ANIMATION
    --==================================================

    local connection

    connection = RunService.RenderStepped:Connect(function()

        if not notifFrame.Parent then
            connection:Disconnect()
            return
        end

        local baseSpeed = 55
        local time = (os.clock() * baseSpeed) % perimeter

        for i, light in ipairs(lights) do

            -- 3 tia cách đều nhau
            local offset = ((i - 1) / 3) * perimeter
            local distance = time + offset

            local x, y, horizontal = getPoint(distance)

            if horizontal then
                light.Size = UDim2.new(0, 34, 0, 2)
                light.Position = UDim2.new(0, x - 17, 0, y - 1)

                local glow = light:FindFirstChild("Glow")
                if glow then
                    glow.Size = UDim2.new(1, 0, 0, 7)
                    glow.Position = UDim2.new(0, 0, 0.5, -3.5)
                end
            else
                light.Size = UDim2.new(0, 2, 0, 34)
                light.Position = UDim2.new(0, x - 1, 0, y - 17)

                local glow = light:FindFirstChild("Glow")
                if glow then
                    glow.Size = UDim2.new(0, 7, 1, 0)
                    glow.Position = UDim2.new(0.5, -3.5, 0, 0)
                end
            end
        end
    end)

    --==================================================
    -- AUTO REMOVE
    --==================================================

    task.delay(duration, function()

        if connection then
            connection:Disconnect()
            connection = nil
        end

        if notifFrame and notifFrame.Parent then
            notifFrame:Destroy()
        end
    end)
end

return Notification
