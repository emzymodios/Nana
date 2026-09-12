-- Scripts/ui/notification.lua
-- Nana Hub Notification - 3 Cyan Animated Border Lights
-- Rounded Rectangle Path + Smooth Corner Rotation

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
    -- BORDER LIGHT
    --==================================================

    local lights = {}

    local LIGHT_LENGTH = 30
    local LIGHT_THICKNESS = 2

    local function createLight(index)
        local light = Instance.new("Frame")
        light.Name = "BorderLight_" .. index

        -- Anchor ở chính giữa để xoay quanh tâm
        light.AnchorPoint = Vector2.new(0.5, 0.5)

        light.Size = UDim2.new(
            0,
            LIGHT_LENGTH,
            0,
            LIGHT_THICKNESS
        )

        light.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        light.BackgroundTransparency = 0.03
        light.BorderSizePixel = 0
        light.ZIndex = 4
        light.Parent = notifFrame

        local lightCorner = Instance.new("UICorner")
        lightCorner.CornerRadius = UDim.new(1, 0)
        lightCorner.Parent = light

        --==================================================
        -- GLOW
        --==================================================

        local glow = Instance.new("Frame")
        glow.Name = "Glow"
        glow.AnchorPoint = Vector2.new(0.5, 0.5)
        glow.Size = UDim2.new(
            1,
            0,
            0,
            8
        )

        glow.Position = UDim2.new(
            0.5,
            0,
            0.5,
            0
        )

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

    --==================================================
    -- GET POINT + TANGENT ANGLE
    --
    -- angle = hướng của tia
    --
    -- 0   = ngang
    -- 90  = dọc
    -- -90 = dọc ngược
    --==================================================

    local function getPoint(distance)

        distance = distance % perimeter

        --==============================================
        -- TOP
        --==============================================

        if distance <= straightTop then

            local x = radius + distance
            local y = 0

            return x, y, 0
        end

        distance -= straightTop

        --==============================================
        -- TOP RIGHT CORNER
        --==============================================

        if distance <= arcLength then

            local t = distance / arcLength

            local a =
                -math.pi / 2 +
                t * (math.pi / 2)

            local cx = width - radius
            local cy = radius

            local x = cx + math.cos(a) * radius
            local y = cy + math.sin(a) * radius

            -- Tiếp tuyến của cung tròn
            local tangent = a + math.pi / 2

            return x, y, tangent
        end

        distance -= arcLength

        --==============================================
        -- RIGHT
        --==============================================

        if distance <= straightSide then

            local x = width
            local y = radius + distance

            return x, y, math.pi / 2
        end

        distance -= straightSide

        --==============================================
        -- BOTTOM RIGHT CORNER
        --==============================================

        if distance <= arcLength then

            local t = distance / arcLength

            local a =
                t * (math.pi / 2)

            local cx = width - radius
            local cy = height - radius

            local x = cx + math.cos(a) * radius
            local y = cy + math.sin(a) * radius

            local tangent = a + math.pi / 2

            return x, y, tangent
        end

        distance -= arcLength

        --==============================================
        -- BOTTOM
        --==============================================

        if distance <= straightTop then

            local x =
                width -
                radius -
                distance

            local y = height

            return x, y, math.pi
        end

        distance -= straightTop

        --==============================================
        -- BOTTOM LEFT CORNER
        --==============================================

        if distance <= arcLength then

            local t = distance / arcLength

            local a =
                math.pi / 2 +
                t * (math.pi / 2)

            local cx = radius
            local cy = height - radius

            local x = cx + math.cos(a) * radius
            local y = cy + math.sin(a) * radius

            local tangent = a + math.pi / 2

            return x, y, tangent
        end

        distance -= arcLength

        --==============================================
        -- LEFT
        --==============================================

        if distance <= straightSide then

            local x = 0
            local y =
                height -
                radius -
                distance

            return x, y, -math.pi / 2
        end

        distance -= straightSide

        --==============================================
        -- TOP LEFT CORNER
        --==============================================

        local t = distance / arcLength

        local a =
            math.pi +
            t * (math.pi / 2)

        local cx = radius
        local cy = radius

        local x = cx + math.cos(a) * radius
        local y = cy + math.sin(a) * radius

        local tangent = a + math.pi / 2

        return x, y, tangent
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
        local time =
            (os.clock() * baseSpeed)
            % perimeter

        for i, light in ipairs(lights) do

            -- 3 tia cách đều nhau
            local offset =
                ((i - 1) / 3)
                * perimeter

            local distance =
                time +
                offset

            local x, y, angle =
                getPoint(distance)

            --==================================================
            -- ĐẶT TIA
            --==================================================

            light.Position = UDim2.new(
                0,
                x,
                0,
                y
            )

            -- Xoay theo hướng border
            light.Rotation =
                math.deg(angle)

            --==================================================
            -- GLOW LUÔN GIỮ ĐÚNG HƯỚNG VỚI TIA
            --==================================================

            local glow = light:FindFirstChild("Glow")

            if glow then
                glow.Position = UDim2.new(
                    0.5,
                    0,
                    0.5,
                    0
                )

                glow.Size = UDim2.new(
                    1,
                    0,
                    0,
                    8
                )
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
