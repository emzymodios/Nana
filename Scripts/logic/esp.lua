-- logic/esp.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ESPModule = {}
local espEnabled = false
local espConnections = {}

local function createESP(player)
    if player == LocalPlayer then return end
    
    local function addBillboard(char)
        if char:FindFirstChild("NanaESP") then return end
        local bgGui = Instance.new("BillboardGui")
        bgGui.Name = "NanaESP"
        bgGui.Size = UDim2.new(0, 100, 0, 40)
        bgGui.StudsOffset = Vector3.new(0, 2.5, 0)
        bgGui.AlwaysOnTop = true
        bgGui.Parent = char:WaitForChild("Head")

        local textLbl = Instance.new("TextLabel")
        textLbl.Size = UDim2.new(1, 0, 1, 0)
        textLbl.BackgroundTransparency = 1
        textLbl.TextColor3 = Color3.fromRGB(0, 255, 150)
        textLbl.TextStrokeTransparency = 0
        textLbl.TextSize = 12
        textLbl.Font = Enum.Font.GothamBold
        textLbl.Text = player.Name
        textLbl.Parent = bgGui
    end

    if player.Character then
        addBillboard(player.Character)
    end
    table.insert(espConnections, player.CharacterAdded:Connect(addBillboard))
end

local function removeESP()
    for _, conn in ipairs(espConnections) do
        conn:Disconnect()
    end
    espConnections = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            local esp = p.Character.Head:FindFirstChild("NanaESP")
            if esp then esp:Destroy() end
        end
    end
end

function ESPModule.Toggle(state)
    espEnabled = state
    if espEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            createESP(p)
        end
        table.insert(espConnections, Players.PlayerAdded:Connect(createESP))
    else
        removeESP()
    end
end

return ESPModule
