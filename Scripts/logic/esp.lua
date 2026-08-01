local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ESPModule = {}
local espEnabled = false
local currentTextSize = 12
local espConnections = {}

local function addBillboard(player, char)
    if not char then return end
    local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 3)
    if not head then return end
    
    if head:FindFirstChild("NanaESP") then return end
    
    local bgGui = Instance.new("BillboardGui")
    bgGui.Name = "NanaESP"
    bgGui.Size = UDim2.new(0, 100, 0, 40)
    bgGui.StudsOffset = Vector3.new(0, 2.5, 0)
    bgGui.AlwaysOnTop = true
    bgGui.Parent = head

    local textLbl = Instance.new("TextLabel")
    textLbl.Name = "ESPText"
    textLbl.Size = UDim2.new(1, 0, 1, 0)
    textLbl.BackgroundTransparency = 1
    textLbl.TextColor3 = Color3.fromRGB(0, 255, 150)
    textLbl.TextStrokeTransparency = 0
    textLbl.TextSize = currentTextSize
    textLbl.Font = Enum.Font.GothamBold
    textLbl.Text = player.Name
    textLbl.Parent = bgGui
end

local function removeBillboard(char)
    if char and char:FindFirstChild("Head") then
        local esp = char.Head:FindFirstChild("NanaESP")
        if esp then esp:Destroy() end
    end
end

local function setupPlayer(player)
    if player == LocalPlayer then return end

    -- Khi nhân vật xuất hiện hoặc hồi sinh
    local function onCharacterAdded(char)
        removeBillboard(char)
        addBillboard(player, char)
        
        -- Lắng nghe ngay khi nhân vật chết/bị xóa để gỡ ESP lập tức ko delay
        local removeConn
        removeConn = char.AncestryChanged:Connect(function(_, parent)
            if not parent then
                removeBillboard(char)
                if removeConn then removeConn:Disconnect() end
            end
        end)
        table.insert(espConnections, removeConn)
    end

    if player.Character then
        task.spawn(function()
            onCharacterAdded(player.Character)
        end)
    end
    
    table.insert(espConnections, player.CharacterAdded:Connect(onCharacterAdded))
end

local function removeAllESP()
    for _, conn in ipairs(espConnections) do
        if conn and typeof(conn) == "RBXScriptConnection" then
            conn:Disconnect()
        end
    end
    espConnections = {}

    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            removeBillboard(p.Character)
        end
    end
end

function ESPModule.Toggle(state)
    espEnabled = state
    if espEnabled then
        removeAllESP()
        for _, p in ipairs(Players:GetPlayers()) do
            setupPlayer(p)
        end
        table.insert(espConnections, Players.PlayerAdded:Connect(setupPlayer))
        table.insert(espConnections, Players.PlayerRemoving:Connect(function(p)
            if p.Character then
                removeBillboard(p.Character)
            end
        end))
    else
        removeAllESP()
    end
end

function ESPModule.SetTextSize(size)
    currentTextSize = size
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("Head") then
            local esp = p.Character.Head:FindFirstChild("NanaESP")
            if esp then
                local txt = esp:FindFirstChild("ESPText")
                if txt then
                    txt.TextSize = currentTextSize
                end
            end
        end
    end
end

return ESPModule
