-- Nana Hub Main Loader (main.lua)

local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/ui.lua"))()
local Logic = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/init.lua"))()
-- Nạp module thông báo mới tạo
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/notification.lua"))()

-- Kích hoạt giao diện UI
UI.Init()

-- Móc nối các sự kiện từ UI sang Logic
UI.OnSpeedToggled = function(state)
    Logic.ToggleSpeed(state)
end

UI.OnSpeedChanged = function(value)
    Logic.SetSpeed(value)
end

UI.OnFlySpeedChanged = function(value)
    Logic.SetFlySpeed(value)
end

UI.OnFlyToggled = function(state)
    Logic.ToggleFly(state)
end

UI.OnNoClipToggled = function(state)
    Logic.ToggleNoClip(state)
end

UI.OnJumpToggled = function(state)
    Logic.ToggleInfiniteJump(state)
end

-- Kết nối sự kiện Soru (Tab Main) - Thay thế Auto Click
UI.OnSoruToggled = function(state)
    Logic.ToggleSoru(state)
end

-- Kết nối sự kiện FPS Boost
UI.OnFPSBoostToggled = function(state)
    Logic.ToggleFPSBoost(state)
end

UI.OnESPToggled = function(state)
    Logic.ToggleESP(state)
end

-- Kết nối sự kiện đổi kích thước chữ ESP
UI.OnESPTextSizeChanged = function(value)
    Logic.SetESPTextSize(value)
end

-- Kết nối các sự kiện Aimbot và Teleport (Tab Combat)
UI.OnAimbotToggled = function(state)
    Logic.ToggleAimbot(state)
end

UI.OnAimbotModeChanged = function(mode)
    Logic.SetAimbotMode(mode)
end

UI.OnAimbotTargetChanged = function(targetName)
    Logic.SetAimbotTarget(targetName)
end

-- Kết nối sự kiện Fly to Target
UI.OnFlyToTargetClicked = function()
    Logic.SmoothTeleportToTarget()
end

UI.OnResetClicked = function()
    Logic.ResetConfig()
end

-- Kết nối tính năng Position trong Tab More
UI.OnSavePositionClicked = function()
    return Logic.SavePosition()
end

UI.OnResetPositionClicked = function()
    return Logic.ResetPosition()
end

UI.OnTeleportPositionClicked = function()
    Logic.TeleportToSaved()
end

-- Hiển thị bảng thông báo mờ ảo góc phải khi load xong
Notification.Show("NANA HUB", "Đã load! Chúc bạn bay acc:))", 5, "rbxassetid://93925828218201")

print("Nana Hub loaded successfully")
