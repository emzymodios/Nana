-- logic/soru.lua
local SoruModule = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local soruEnabled = false
local mouseConnection = nil
local oldZoom = nil
local firstClickTime = 0
local RESET_TIME = 2 -- 2 giây không bấm lần 2 thì reset

function SoruModule.Toggle(state)
    if soruEnabled == state then return end
    soruEnabled = state

    if mouseConnection then
        mouseConnection:Disconnect()
        mouseConnection = nil
    end

    if soruEnabled then
        -- Tăng zoom khi bật soru
        oldZoom = player.CameraMaxZoomDistance
        player.CameraMaxZoomDistance = 2000

        firstClickTime = 0 -- reset khi bật

        local mouse = player:GetMouse()
        mouseConnection = mouse.Button1Down:Connect(function()
            if not soruEnabled then return end

            local now = tick()

            -- Lần bấm đầu tiên (hoặc đã quá 2s)
            if firstClickTime == 0 or (now - firstClickTime) > RESET_TIME then
                firstClickTime = now
                return -- chờ lần bấm thứ 2
            end

            -- Đã bấm lần 2 trong vòng 2s → teleport
            firstClickTime = 0 -- reset để lần sau bấm lại từ đầu

            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local targetPos = mouse.Hit.Position

                local ray = Ray.new(targetPos + Vector3.new(0, 100, 0), Vector3.new(0, -500, 0))
                local hitPart, hitPos = workspace:FindPartOnRay(ray, character)

                if hitPart then
                    rootPart.CFrame = CFrame.new(hitPos + Vector3.new(0, 3, 0))
                end
            end
        end)
    else
        if oldZoom then
            player.CameraMaxZoomDistance = oldZoom
            oldZoom = nil
        end
    end
end

return SoruModule
