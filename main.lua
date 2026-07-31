-- 1. Tải giao diện và phần logic từ GitHub của bạn
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

-- 2. Kết nối các tính năng từ UI sang Logic
-- (Giả định cấu trúc UI của bạn có các hàm/sự kiện tương ứng để hook vào)

-- Ví dụ kết nối WalkSpeed Slider/Input
if UI.OnSpeedChanged then
    UI.OnSpeedChanged(function(value)
        Logic.SetSpeed(value)
    end)
end

-- Ví dụ kết nối Fly Toggle
if UI.OnFlyToggled then
    UI.OnFlyToggled(function(state)
        Logic.ToggleFly(state)
    end)
end

-- Ví dụ kết nối NoClip Toggle
if UI.OnNoClipToggled then
    UI.OnNoClipToggled(function(state)
        Logic.ToggleNoClip(state)
    end)
end

-- Ví dụ kết nối Reset Config Button
if UI.OnResetClicked then
    UI.OnResetClicked(function()
        Logic.ResetConfig()
    end)
end

print("Nana Hub loaded successfully on Mobile!")
