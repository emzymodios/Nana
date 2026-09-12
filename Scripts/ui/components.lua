-- Nana Hub Components (components.lua đã xóa hoàn toàn title)
local Components = {}

function Components.CreateFrameBox(parent, posY, height, titleText)
    local box = Instance.new("Frame")
    box.Size = UDim2.new(0.95, 0, 0, height)
    box.Position = UDim2.new(0.025, 0, 0, posY)
    box.BackgroundColor3 = Color3.fromRGB(32, 32, 45)
    box.BorderSizePixel = 0
    box.Parent = parent

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 8)
    boxCorner.Parent = box

    -- Viền Cyan đơn giản, sạch sẽ
    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Color3.fromRGB(0, 200, 255)
    boxStroke.Thickness = 1.5
    boxStroke.Parent = box

    -- Dark gradient
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 40))
    })
    gradient.Rotation = 90
    gradient.Parent = box

    return box
end

return Components
