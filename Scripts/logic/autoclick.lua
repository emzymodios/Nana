-- logic/autoclick.lua
local AutoClickModule = {}
local autoClickEnabled = false

function AutoClickModule.Toggle(state)
    autoClickEnabled = state
    if autoClickEnabled then
        task.spawn(function()
            local vim = game:GetService("VirtualInputManager")
            while autoClickEnabled do
                pcall(function()
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(0.05)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end)
                task.wait(0.05)
            end
        end)
    end
end

return AutoClickModule
