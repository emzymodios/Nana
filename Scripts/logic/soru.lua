-- logic/soru.lua
local SoruModule = {}
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local soruEnabled = false
local mouseConnection = nil

function SoruModule.Toggle(state)
    soruEnabled = state
    
    if soruEnabled then
        local mouse = player:GetMouse()
        
        -- Lắng nghe mỗi lần click chuột trái khi Soru đang bật
        mouseConnection = mouse.Button1Down:Connect(function()
            if not soruEnabled then return end
            
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                local targetPos = mouse.Hit.Position
                
                -- Dịch chuyển nhân vật tới vị trí trỏ chuột (nâng lên một chút để tránh kẹt sàn)
                rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
            end
        end)
    else
        -- Ngắt kết nối khi tắt Soru
        if mouseConnection then
            mouseConnection:Disconnect()
            mouseConnection = nil
        end
    end
end

return SoruModule
