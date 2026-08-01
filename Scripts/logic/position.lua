-- logic/position.lua
local PositionModule = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local savedPosition = nil

function PositionModule.SavePosition()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        savedPosition = character.HumanoidRootPart.CFrame
        return tostring(math.floor(savedPosition.X)) .. ", " .. tostring(math.floor(savedPosition.Y)) .. ", " .. tostring(math.floor(savedPosition.Z))
    end
    return "Chưa có vị trí"
end

function PositionModule.ResetPosition()
    savedPosition = nil
    return "[            ]"
end

function PositionModule.TeleportToSaved()
    if savedPosition then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = savedPosition
        end
    end
end

return PositionModule
