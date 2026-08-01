-- Nana Hub Components (components.lua)
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
    
    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Color3.fromRGB(100, 70, 180)
    boxStroke.Thickness = 1.5
    boxStroke.Parent = box
    
    local boxShadow = Instance.new("UIStroke")
    boxShadow.Color = Color3.fromRGB(0, 0, 0)
    boxShadow.Thickness = 2
    boxShadow.Transparency = 0.7
    boxShadow.Parent = box
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 40))
    })
    gradient.Rotation = 90
    gradient.Parent = box
    
    if titleText then
        local titleTag = Instance.new("TextLabel")
        titleTag.Size = UDim2.new(0.4, 0, 0, 16)
        titleTag.Position = UDim2.new(0.02, 0, 0, -8)
        titleTag.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
        titleTag.TextColor3 = Color3.fromRGB(150, 120, 200)
        titleTag.TextSize = 11
        titleTag.Font = Enum.Font.GothamBold
        titleTag.Text = titleText
        titleTag.TextXAlignment = Enum.TextXAlignment.Left
        titleTag.Parent = box
    end
    
    return box
end

return Components
