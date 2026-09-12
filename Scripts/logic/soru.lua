
-- logic/soru.lua
local SoruModule = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local soruEnabled = false
local mouseConnection = nil
local oldZoom = nil -- nhớ zoom cũ để khôi phục

function SoruModule.Toggle(state)
    if soruEnabled == state then return end
    soruEnabled = state

    -- Dọn connection cũ
    if mouseConnection then
        mouseConnection:Disconnect()
        mouseConnection = nil
    end

    if soruEnabled then
        -- Tăng zoom camera để bấm được xa
        oldZoom = player.CameraMaxZoomDistance
        player.CameraMaxZoomDistance = 2000

        local mouse = player:GetMouse()
        mouseConnection = mouse.Button1Down:Connect(function()
            if not soruEnabled then return end

            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end

            local rootPart = character.HumanoidRootPart

            -- Lấy vị trí chuột đang trỏ tới (có thể rất xa)
            local targetPos = mouse.Hit.Position

            -- Chiếu tia từ trên cao xuống để bám mặt đất
            local rayOrigin = targetPos + Vector3.new(0, 500, 0)
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {character}
            rayParams.FilterType = Enum.RaycastFilterType.Exclude

            local result = workspace:Raycast(rayOrigin, Vector3.new(0, -2000, 0), rayParams)

            local finalPos
            if result then
                finalPos = result.Position + Vector3.new(0, 3, 0)
            else
                -- Không tìm thấy đất (trỏ vào trời) → dùng thẳng vị trí chuột
                finalPos = targetPos + Vector3.new(0, 3, 0)
            end

            rootPart.CFrame = CFrame.new(finalPos)
        end)
    else
        -- Khôi phục zoom cũ khi tắt
        if oldZoom then
            player.CameraMaxZoomDistance = oldZoom
            oldZoom = nil
        end
    end
end

return SoruModule
