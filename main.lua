local SuccessUI, UI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui.lua"))()
end)

local SuccessLogic, Logic = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic.lua"))()
end)

if not SuccessUI or not SuccessLogic then
    warn("Nana Hub: Lỗi khi tải UI hoặc Logic từ GitHub!")
    return
end

-- Kích hoạt giao diện UI hiển thị
UI.Init()

-- Móc nối các sự kiện từ UI sang Logic
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

UI.OnResetClicked = function()
    Logic.ResetConfig()
end

print("Nana Hub loaded successfully with Full UI!")
