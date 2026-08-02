-- Scripts/ui/tabs/more_tab.lua
local MoreTab = {}

function MoreTab.Create(container, UI)
    -- Giữ lại khung trống của tab More để giao diện không bị lỗi hụt
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = "MoreTabContent"
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabContent.Parent = container

    return TabContent
end

return MoreTab
