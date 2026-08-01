-- logic/jump.lua
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local JumpModule = {}
local jumpEnabled = false
local jumpConnection

function JumpModule.Toggle(state)
    jumpEnabled = state
    if jumpEnabled then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if jumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if jumpConnection then
            jumpConnection:Disconnect()
        end
    end
end

function JumpModule.IsEnabled()
    return jumpEnabled
end

return JumpModule
