-- logic/speed.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local SpeedModule = {}

local isSpeedEnabled = false
local currentSpeed = 16

local SLIDE_TIME = 0.5 -- thời gian trượt sau khi thả phím
local slideTimer = 0   -- đếm ngược

function SpeedModule.Toggle(state)
    isSpeedEnabled = state
    if not isSpeedEnabled then
        slideTimer = 0
        local char = LocalPlayer.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if humanoid then
            humanoid.WalkSpeed = 16
        end
        if root then
            root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
        end
    end
end

function SpeedModule.SetSpeed(val)
    currentSpeed = val
end

RunService.RenderStepped:Connect(function(dt)
    if not isSpeedEnabled then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not (humanoid and rootPart) then return end
    
    humanoid.WalkSpeed = currentSpeed
    
    local vel = rootPart.AssemblyLinearVelocity
    local isMoving = humanoid.MoveDirection.Magnitude > 0
    
    if isMoving then
        -- Đang bấm phím → reset đồng hồ trượt
        slideTimer = SLIDE_TIME
    else
        -- Thả phím → trượt dần
        if slideTimer > 0 then
            slideTimer -= dt
            
            -- Giảm dần vận tốc ngang (không đụng Y để không ảnh hưởng rơi)
            local decay = math.clamp(slideTimer / SLIDE_TIME, 0, 1)
            rootPart.AssemblyLinearVelocity = Vector3.new(
                vel.X * decay,
                vel.Y,
                vel.Z * decay
            )
            
            -- Hết thời gian trượt → dừng hẳn
            if slideTimer <= 0 then
                slideTimer = 0
                rootPart.AssemblyLinearVelocity = Vector3.new(0, vel.Y, 0)
            end
        end
    end
end)

return SpeedModule
