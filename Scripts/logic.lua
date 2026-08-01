-- ╔════════════════════════════════════════╗
-- ║   NANA HUB - LOGIC.LUA                  ║
-- ║   File: Xử lý chức năng (Speed, Fly...) ║
-- ║   Tác giả: emzymodios                   ║
-- ╚════════════════════════════════════════╝

local Logic = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local speedEnabled = false
local flyEnabled = false
local noclipEnabled = false
local jumpEnabled = false
local espEnabled = false
local fpsBoostEnabled = false

local currentSpeed = 16
local flySpeed = 50

-- Lưu trữ giá trị cũ
local originalGraphicsSettings = {}

local bg, bv
local noclipConnection, flyConnection, jumpConnection
local espConnections = {}

-- ✅ SPEED
function Logic.ToggleSpeed(state)
    speedEnabled = state
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speedEnabled and currentSpeed or 16
    end
end

function Logic.SetSpeed(speed)
    currentSpeed = speed
    if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    end
end

-- ✅ FLY SPEED
function Logic.SetFlySpeed(speed)
    flySpeed = speed
end

-- ✅ FLY
function Logic.ToggleFly(state)
    flyEnabled = state
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local hrp = character.HumanoidRootPart
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if flyEnabled then
        humanoid.PlatformStand = true
        bg = Instance.new("BodyGyro")
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = hrp.CFrame
        bg.Parent = hrp

        bv = Instance.new("BodyVelocity")
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = hrp

        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled then return end
            local camera = workspace.CurrentCamera
            local moveDir = humanoid.MoveDirection
            
            if moveDir.Magnitude > 0 then
                local camCF = camera.CFrame
                local relativeDir = camCF:VectorToObjectSpace(moveDir)
                bv.velocity = camCF:VectorToWorldSpace(Vector3.new(relativeDir.X, moveDir.Y, relativeDir.Z)) * flySpeed
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            bg.cframe = camera.CFrame
        end)
    else
        humanoid.PlatformStand = false
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
        if flyConnection then flyConnection:Disconnect() end
    end
end

-- ✅ NOCLIP
function Logic.ToggleNoClip(state)
    noclipEnabled = state
    if noclipEnabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        local character = LocalPlayer.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- ✅ INFINITE JUMP
function Logic.ToggleInfiniteJump(state)
    jumpEnabled = state
    if jumpEnabled then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if jumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if jumpConnection then
            jumpConnection:Disconnect()
        end
    end
end

-- ✅ FPS BOOST
function Logic.ToggleFPSBoost(state)
    fpsBoostEnabled = state
    
    if fpsBoostEnabled then
        -- Lưu giá trị gốc
        originalGraphicsSettings.GlobalShadows = Lighting.GlobalShadows
        originalGraphicsSettings.Brightness = Lighting.Brightness
        originalGraphicsSettings.Ambient = Lighting.Ambient
        originalGraphicsSettings.ClockTime = Lighting.ClockTime
        
        -- Giảm chất lượng đồ họa
        Lighting.GlobalShadows = false
        Lighting.Brightness = 3
        Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Lighting.ClockTime = 12
        
        -- Giảm chất lượng texture
        for _, obj in pairs(workspace:FindPartBoundsInRadius(LocalPlayer.Character.HumanoidRootPart.Position, 10000)) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.Plastic
            end
        end
        
        print("✅ FPS Boost ON")
    else
        -- Khôi phục giá trị gốc
        if originalGraphicsSettings.GlobalShadows ~= nil then
            Lighting.GlobalShadows = originalGraphicsSettings.GlobalShadows
        end
        if originalGraphicsSettings.Brightness ~= nil then
            Lighting.Brightness = originalGraphicsSettings.Brightness
        end
        if originalGraphicsSettings.Ambient ~= nil then
            Lighting.Ambient = originalGraphicsSettings.Ambient
        end
        if originalGraphicsSettings.ClockTime ~= nil then
            Lighting.ClockTime = originalGraphicsSettings.ClockTime
        end
        
        print("❌ FPS Boost OFF")
    end
end

-- ✅ ESP
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

function Logic.ToggleESP(state)
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

-- ✅ RESET CONFIG
function Logic.ResetConfig()
    Logic.ToggleSpeed(false)
    Logic.ToggleFly(false)
    Logic.ToggleNoClip(false)
    Logic.ToggleInfiniteJump(false)
    Logic.ToggleFPSBoost(false)
    Logic.SetSpeed(16)
    print("✅ Config reset to default")
end

-- ✅ Character respawn handler
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(1)
    if speedEnabled then Logic.ToggleSpeed(true) end
    if flyEnabled then Logic.ToggleFly(true) end
    if noclipEnabled then Logic.ToggleNoClip(true) end
    if jumpEnabled then Logic.ToggleInfiniteJump(true) end
    if fpsBoostEnabled then Logic.ToggleFPSBoost(true) end
end)

return Logic

