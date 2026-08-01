local Players = game:GetService("Players")
local CombatTab = {}

function CombatTab.Create(combatContainer, UI)
    local player = Players.LocalPlayer

    local function getPlayerNames()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player then
                table.insert(list, p.Name)
            end
        end
        return list
    end

    local currentSelectedTarget = nil

    local dropdownObj, updateDropFunc = Elements.CreateDropdown(combatContainer, 15, "Target Player", getPlayerNames(), function(selectedName)
        currentSelectedTarget = selectedName
        if UI.OnAimbotTargetChanged then UI.OnAimbotTargetChanged(selectedName) end
    end)

    Players.PlayerAdded:Connect(function() updateDropFunc(getPlayerNames()) end)
    Players.PlayerRemoving:Connect(function() updateDropFunc(getPlayerNames()) end)

    Elements.CreateToggleRow(combatContainer, 65, "Bait & Follow Target", function(state)
        if UI.OnTeleportPlayerToggled then 
            UI.OnTeleportPlayerToggled(state, currentSelectedTarget) 
        end
    end)

    Elements.CreateToggleRow(combatContainer, 125, "Aimbot Nearest", function(state)
        if state then
            if UI.OnAimbotModeChanged then UI.OnAimbotModeChanged("Nearest") end
        end
        if UI.OnAimbotToggled then UI.OnAimbotToggled(state) end
    end)

    Elements.CreateToggleRow(combatContainer, 180, "Aimbot Selected", function(state)
        if state then
            if UI.OnAimbotModeChanged then UI.OnAimbotModeChanged("Selected") end
        end
        if UI.OnAimbotToggled then UI.OnAimbotToggled(state) end
    end)
end

return CombatTab
