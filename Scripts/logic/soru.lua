-- logic/soru.lua
local SoruModule = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local soruEnabled = false
local mouseConnection = nil
local oldZoom = nil
local firstClickTime = 0
local RESET_TIME = 2
local lastEventTime = 0
local DEBOUNCE = 0.05 -- chặn event trùng

function SoruModule.Toggle(state)
    if soruEnabled == state then return end
    soruEnabled = state

    if mouseConnection then
        mouseConnection:Disconnect()
        mouseConnection = nil
    end

    if soruEnabled then
        oldZoom = player.CameraMaxZoomDistance
        player.CameraMaxZoomDistance = 2000

        -- 👈 QUAN TRỌNG: reset sạch mỗi lần bật
        firstClickTime = 0
        lastEventTime = 0

        local mouse = player:GetMouse()
        mouseConnection = mouse.Button1Down:Connect(function()
            if not soruEnabled then return end

            local now = tick()

            -- 👈 Chặn event fire trùng trong 0.05s
            if now - lastEventTime < DEBOUNCE then return end
            lastEventTime = now

            -- Lần bấm đầu (hoặc đã quá 2s) → chờ
            if firstClickTime == 0 or (now - firstClickTime) > RESET_TIME then
                firstClickTime = now
                return
            end

            -- Lần bấm thứ 2 trong 2s → soru
            firstClickTime = 0

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
