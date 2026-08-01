-- Ví dụ cấu trúc trong tab More của bạn
local MoreTab = {}

function MoreTab.Create(tabView, LogicBridge)
    -- Tạo một Section/Folder giao diện
    local section = tabView:CreateSection("Position Controls")

    -- Ô nhập tọa độ X
    local inputX = section:CreateTextbox({
        Name = "Position X",
        Placeholder = "Nhập tọa độ X...",
        Callback = function(value)
            -- Lưu giá trị X tạm thời
        end
    })

    -- Ô nhập tọa độ Y
    local inputY = section:CreateTextbox({
        Name = "Position Y",
        Placeholder = "Nhập tọa độ Y...",
        Callback = function(value)
            -- Lưu giá trị Y tạm thời
        end
    })

    -- Ô nhập tọa độ Z
    local inputZ = section:CreateTextbox({
        Name = "Position Z",
        Placeholder = "Nhập tọa độ Z...",
        Callback = function(value)
            -- Lưu giá trị Z tạm thời
        end
    })

    -- Nút bấm dịch chuyển đến tọa độ đã nhập
    section:CreateButton({
        Name = "Teleport to Position",
        Callback = function()
            local x = tonumber(inputX.GetText()) or 0
            local y = tonumber(inputY.GetText()) or 0
            local z = tonumber(inputZ.GetText()) or 0
            
            if LogicBridge and LogicBridge.OnTeleportCoords then
                LogicBridge.OnTeleportCoords(x, y, z)
            end
        end
    })
end

return MoreTab
