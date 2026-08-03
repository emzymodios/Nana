-- Scripts/logic/godmode.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local GodmodeModule = {}
local isGodmodeActive = false
local charConn = nil
local damageConns = {}

local function applyGodmode(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end

    -- Xóa các kết nối cũ nếu có
    for _, conn in ipairs(damageConns) do
        conn:Disconnect()
    end
    damageConns = {}

    -- Phương pháp 1: Khóa máu liên tục bằng Heartbeat để ép server nhận diện client override
    local runService = game:GetService("RunService")
    table.insert(damageConns, runService.Heartbeat:Connect(function()
        if isGodmodeActive then
            if humanoid.MaxHealth ~= math.huge then
                humanoid.MaxHealth = math.huge
            end
            if humanoid.Health < math.huge then
                humanoid.Health = math.huge
            end
        end
    end))

    -- Phương pháp 2: Chặn StateChanged (Ngăn nhân vật bị chuyển sang trạng thái Dead)
    table.insert(damageConns, humanoid.StateChanged:Connect(function(_, newState)
        if isGodmodeActive and newState == Enum.HumanoidStateType.Dead then
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
            humanoid.Health = math.huge
        end
    end))
end

function GodmodeModule.Toggle(state)
    isGodmodeActive = state

    if state then
        if player.Character then
            applyGodmode(player.Character)
        end

        if charConn then charConn:Disconnect() end
        charConn = player.CharacterAdded:Connect(function(newChar)
            if isGodmodeActive then
                task.wait(0.5)
                applyGodmode(newChar)
            end
        end)
    else
        isGodmodeActive = false
        if charConn then
            charConn:Disconnect()
            charConn = nil
        end
        for _, conn in ipairs(damageConns) do
            conn:Disconnect()
        end
        damageConns = {}

        if player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end
    end
end

return GodmodeModule
