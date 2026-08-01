-- logic/init.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Tải các module con qua GitHub raw links
local Speed = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/speed.lua"))()
local Fly = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/fly.lua"))()
local Noclip = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/noclip.lua"))()
local Jump = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/jump.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/logic/esp.lua"))()

local Logic = {}

function Logic.ToggleSpeed(state)
    Speed.Toggle(state)
end

function Logic.SetSpeed(speed)
    Speed.Set(speed)
end

function Logic.SetFlySpeed(speed)
    Fly.SetSpeed(speed)
end

function Logic.ToggleFly(state)
    Fly.Toggle(state)
end

function Logic.ToggleNoClip(state)
    Noclip.Toggle(state)
end

function Logic.ToggleInfiniteJump(state)
    Jump.Toggle(state)
end

function Logic.ToggleESP(state)
    ESP.Toggle(state)
end

-- Thêm hàm điều chỉnh kích thước chữ ESP
function Logic.SetESPTextSize(size)
    ESP.SetTextSize(size)
end

function Logic.ResetConfig()
    Speed.Toggle(false)
    Fly.Toggle(false)
    Noclip.Toggle(false)
    Jump.Toggle(false)
    Speed.Set(16)
end

-- Xử lý hồi sinh nhân vật
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(1)
    if Speed.IsEnabled() then Speed.Toggle(true) end
    if Fly.IsEnabled() then Fly.Toggle(true) end
    if Noclip.IsEnabled() then Noclip.Toggle(true) end
    if Jump.IsEnabled() then Jump.Toggle(true) end
end)

return Logic
