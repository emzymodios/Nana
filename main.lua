-- Nana Hub Main Loader (main.lua)

local SuccessUI, UI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/ui.lua"))()
end)

local SuccessLogic, Logic = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/init.lua"))()
end)

if not SuccessUI or not SuccessLogic then
    warn("Nana Hub: error acc bạn đã bị ban")
    return
end

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

UI.OnESPToggled = function(state)
    Logic.ToggleESP(state)
end

-- Thêm đoạn kết nối này để nhận sự kiện đổi kích thước chữ ESP
UI.OnESPTextSizeChanged = function(value)
    Logic.SetESPTextSize(value)
end

UI.OnResetClicked = function()
    Logic.ResetConfig()
end

print("Nana Hub loaded successfully")
