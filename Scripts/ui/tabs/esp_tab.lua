local Elements = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua"))()
local ESPTab = {}

function ESPTab.Create(otherContainer, UI)
    Elements.CreateSlider(otherContainer, 15, "ESP Text Size", 8, 30, 12, function(val)
        if UI.OnESPTextSizeChanged then UI.OnESPTextSizeChanged(val) end
    end)

    Elements.CreateToggleRow(otherContainer, 80, "ESP Player", function(state)
        if UI.OnESPToggled then UI.OnESPToggled(state) end
    end)
end

return ESPTab
