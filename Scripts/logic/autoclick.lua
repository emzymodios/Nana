-- logic/autoclick.lua
local AutoClickModule = {}
local autoClickEnabled = false

function AutoClickModule.Toggle(state)
    autoClickEnabled = state
    if autoClickEnabled then
        task.spawn(function()
            local vim = game:GetService("VirtualInputManager")
            local vimService = game:GetService("VirtualUser") -- Thường dùng kết hợp cho ổn định hơn
            
            while autoClickEnabled do
                pcall(function()
                    -- Lấy tọa độ màn hình hiện tại để click đúng chỗ con trỏ
                    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                    local x, y = mouse.X, mouse.Y + 36 -- +36 để bù trừ thanh tiêu đề cửa sổ game nếu cần
                    
                    -- Gửi sự kiện nhấn và nhả chuột trái (0 là chuột trái)
                    vim:SendMouseButtonEvent(x, y, 0, true, game, 1)
                    task.wait(0.02)
                    vim:SendMouseButtonEvent(x, y, 0, false, game, 1)
                end)
                
                -- Tốc độ click (có thể chỉnh to nhỏ tùy ý, ví dụ 0.1 giây mỗi cú click)
                task.wait(0.1) 
            end
        end)
    end
end

return AutoClickModule
