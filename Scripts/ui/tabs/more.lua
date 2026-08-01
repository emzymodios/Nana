-- Scripts/ui/tabs/more_tab.lua
local MoreTab = {}

function MoreTab.Create(container, UI)
    -- Sử dụng trực tiếp module Elements đã được truyền sẵn từ ui.lua qua tham số hoặc tải an toàn
    local Elements = safeLoad and safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua") 
    
    if not Elements then
        local success, result = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua"))()
        end)
        if success then Elements = result else return end
    end

    local posSection = Elements.CreateSection(container, "Teleport Position", UDim2.new(0, 0, 0, 0))

    local coords = {x = 0, y = 0, z = 0}

    Elements.CreateTextbox(posSection, "Position X", "Nhập X...", function(value)
        coords.x = tonumber(value) or 0
    end)
    
    Elements.CreateTextbox(posSection, "Position Y", "Nhập Y...", function(value)
        coords.y = tonumber(value) or 0
    end)
    
    Elements.CreateTextbox(posSection, "Position Z", "Nhập Z...", function(value)
        coords.z = tonumber(value) or 0
    end)

    Elements.CreateButton(posSection, "Teleport to Coords", function()
        if UI.OnTeleportCoords then
            UI.OnTeleportCoords(coords.x, coords.y, coords.z)
        end
        
        if UI.Notify then
            UI.Notify.Show("NANA HUB", "Đã dịch chuyển tới: " .. coords.x .. ", " .. coords.y .. ", " .. coords.z, 3, "rbxassetid://93925828218201")
        end
    end)
end

return MoreTab
