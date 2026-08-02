-- Scripts/ui/tabs/more.lua
local MoreTab = {}

function MoreTab.Create(container, UI)
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = "MoreTabContent"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 300)
    tabContent.ScrollBarThickness = 4
    tabContent.Parent = container

    -- Thêm một tiêu đề hoặc nút test tạm thời trong tab More để kiểm tra hiển thị
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 40)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Nana Hub - More Settings"
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = tabContent

    return tabContent
end

return MoreTab
