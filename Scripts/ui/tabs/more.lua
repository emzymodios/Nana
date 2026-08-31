-- Nana Hub More Tab
-- Đã bỏ chức năng Select Image / Apply / Reset.

local MoreTab = {}

function MoreTab.Create(container, UI, backgroundImage)
    container.CanvasSize = UDim2.new(0, 0, 0, 120)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "MoreTitle"
    titleLabel.Size = UDim2.new(1, -20, 0, 35)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 17
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Other More"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 2
    titleLabel.Parent = container

    local info = Instance.new("TextLabel")
    info.Name = "BackgroundInfo"
    info.Size = UDim2.new(1, -20, 0, 50)
    info.Position = UDim2.new(0, 10, 0, 55)
    info.BackgroundTransparency = 1
    info.TextColor3 = Color3.fromRGB(220, 220, 220)
    info.TextSize = 14
    info.Font = Enum.Font.Gotham
    info.Text = "Menu background is fixed when the script loads."
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.TextWrapped = true
    info.ZIndex = 2
    info.Parent = container
end

return MoreTab
