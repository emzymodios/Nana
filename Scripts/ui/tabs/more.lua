-- Scripts/ui/tabs/more_tab.lua
local MoreTab = {}

function MoreTab.Create(container, UI)
    local success, Elements = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua"))()
    end)
    
    if not success or not Elements then return end

    local posSection = Elements.CreateSection(container, "Teleport Position", UDim2.new(0, 0, 0, 0))

    local inputValues = {x = 0, y = 0, z = 0}

    Elements.CreateTextbox(posSection, "Position X", "Nhập X...", function(value)
        inputValues.x = tonumber(value) or 0
    end)
    
    Elements.CreateTextbox(posSection, "Position Y", "Nhập Y...", function(value)
        inputValues.y = tonumber(value) or 0
    end)
    
    Elements.CreateTextbox(posSection, "Position Z", "Nhập Z...", function(value)
        inputValues.z = tonumber(value) or 0
    end)

    Elements.CreateButton(posSection, "Teleport to Coords", function()
        if UI.OnTeleportCoords then
            UI.OnTeleportCoords(inputValues.x, inputValues.y, inputValues.z)
        end
    end)
end

return MoreTab
