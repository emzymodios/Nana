-- Nana Hub Main Loader (main.lua)

-- Tải các module bất đồng bộ song song để không bị nghẽn mạng trên luồng chính
local UI, Logic, Notification

task.spawn(function()
    UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/ui.lua"))()
end)

task.spawn(function()
    Logic = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/init.lua"))()
end)

task.spawn(function()
    Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/notification.lua"))()
end)

-- Chờ một xíu cực ngắn để đảm bảo các module đã tải xong (hoặc check điều kiện)
repeat task.wait() until UI and Logic and Notification

UI.Init()

-- Các cầu nối cơ bản
UI.OnSpeedToggled = function(state) Logic.ToggleSpeed(state) end
UI.OnSpeedChanged = function(value) Logic.SetSpeed(value) end
UI.OnFlySpeedChanged = function(value) Logic.SetFlySpeed(value) end
UI.OnFlyToggled = function(state) Logic.ToggleFly(state) end
UI.OnNoClipToggled = function(state) Logic.ToggleNoClip(state) end
UI.OnJumpToggled = function(state) Logic.ToggleInfiniteJump(state) end
UI.OnSoruToggled = function(state) Logic.ToggleSoru(state) end
UI.OnFPSBoostToggled = function(state) Logic.ToggleFPSBoost(state) end

-- Cầu nối ESP
UI.OnESPToggled = function(state) Logic.ToggleESP(state) end
UI.OnESPTextSizeChanged = function(value) Logic.SetESPTextSize(value) end

-- Cầu nối Aimbot
UI.OnAimbotToggled = function(state) Logic.ToggleAimbot(state) end
UI.OnAimbotModeChanged = function(mode) Logic.SetAimbotMode(mode) end
UI.OnAimbotTargetChanged = function(targetName) Logic.SetAimbotTarget(targetName) end

-- Cầu nối Teleport qua người chơi dạng Toggle (Bait & Follow)
UI.OnTeleportPlayerToggled = function(state, targetName) 
    Logic.ToggleTeleportPlayer(state, targetName) 
end

-- Cầu nối Reset cấu hình tổng thể
UI.OnResetClicked = function() Logic.ResetConfig() end

Notification.Show("NANA HUB", "Đã load! Chúc bạn bay acc:))", 5, "rbxassetid://93925828218201")
print("Nana Hub loaded successfully")
