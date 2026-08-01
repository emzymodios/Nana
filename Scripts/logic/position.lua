local PositionModule = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function PositionModule.TeleportToCoords(x, y, z)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end

-- Hoặc tính năng lấy vị trí hiện tại (Copy Position)
function PositionModule.GetCurrentPosition()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        return char.HumanoidRootPart.Position
    end
    return Vector3.new(0, 0, 0)
end

return PositionModule
