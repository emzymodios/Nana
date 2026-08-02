-- Scripts/logic/godmode.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local GodmodeModule = {}
local connection = nil

function GodmodeModule.Toggle(state)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if state then
        if humanoid then
            -- Khóa MaxHealth và Health ở mức tối đa liên tục
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            
            -- Lắng nghe sự kiện hồi sinh nếu nhân vật chết để tái áp dụng
            connection = humanoid.HealthChanged:Connect(function()
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end)
        end
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if humanoid then
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end
    end
end

return GodmodeModule
