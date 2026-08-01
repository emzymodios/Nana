-- Scripts/ui/tabs/more_tab.lua
local MoreTab = {}

function MoreTab.Create(container, UI)
    -- Tải module Elements an toàn tương tự các tab khác
    local success, Elements = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua"))()
    end)
    
    if not success or not Elements then
        warn("Failed to load Elements for MoreTab")
        return
    end

    -- Tạo Section chứa các chức năng Position
    local posSection = Elements.CreateSection(container, "Teleport Position", UDim2.new(0, 0, 0, 0))

    local inputX, inputY, inputZ

    -- Ô nhập tọa độ X
    if Elements.CreateTextbox then
        inputX = Elements.CreateTextbox(posSection, "Position X", "Nhập tọa độ X...", function(value)
            -- Xử lý khi nhập giá trị X nếu cần
        end)
        
        -- Ô nhập tọa độ Y
        inputY = Elements.CreateTextbox(posSection, "Position Y", "Nhập tọa độ Y...", function(value)
            -- Xử lý khi nhập giá trị Y nếu cần
        end)
        
        -- Ô nhập tọa độ Z
        inputZ = Elements.CreateTextbox(posSection, "Position Z", "Nhập tọa độ Z...", function(value)
            -- Xử lý khi nhập giá trị Z nếu cần
        end)
    end

    -- Nút bấm thực hiện dịch chuyển
    if Elements.CreateButton then
        Elements.CreateButton(posSection, "Teleport to Coords", function()
            -- Lấy dữ liệu từ các ô nhập (tuỳ thuộc vào hàm trả về của Elements.CreateTextbox trong dự án của bạn)
            local x = tonumber(inputX and inputX.GetText and inputX.GetText() or 0) or 0
            local y = tonumber(inputY and inputY.GetText and inputY.GetText() or 0) or 0
            local z = tonumber(inputZ and inputZ.GetText and inputZ.GetText() or 0) or 0

            -- Gửi tín hiệu qua cầu nối UI xuống Logic
            if UI.OnTeleportCoords then
                UI.OnTeleportCoords(x, y, z)
            end
            
            if UI.Notify then
                UI.Notify.Show("NANA HUB", "Đã dịch chuyển tới: " .. x .. ", " .. y .. ", " .. z, 3, "rbxassetid://93925828218201")
            end
        end)
    end
end

return MoreTab
