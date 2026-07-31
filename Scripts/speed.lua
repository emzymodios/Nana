-- Khoi tao dich vu Roblox
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Tao ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiniMenu_UI"
ScreenGui.Parent = (gethui and gethui()) or CoreGui
ScreenGui.ResetOnSpawn = false

-- 1. Khung Main Menu
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.fromOffset(300, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(45, 45, 45)
MainStroke.Thickness = 1.5

-- Fast Dragging (Kéo thả menu)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 2. Thanh Tieude (Header)
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -15, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.Text = "Mini Hub v1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.BuilderSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- 3. Container chứa duy nhất 1 mục
local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -45)
Container.Position = UDim2.fromOffset(10, 38)
Container.BackgroundTransparency = 1

-- ========================================================
-- [ MỤC DUY NHẤT: TOGGLE BẬT / TẮT ]
-- ========================================================
local ToggleButton = Instance.new("TextButton", Container)
ToggleButton.Name = "SingleToggle"
ToggleButton.Size = UDim2.new(1, 0, 0, 40)
ToggleButton.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
ToggleButton.AutoButtonColor = false
ToggleButton.Text = ""

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(0, 6)

local ToggleTitle = Instance.new("TextLabel", ToggleButton)
ToggleTitle.Size = UDim2.new(1, -50, 1, 0)
ToggleTitle.Position = UDim2.fromOffset(10, 0)
ToggleTitle.Text = "Tính năng duy nhất"
ToggleTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
ToggleTitle.TextSize = 12
ToggleTitle.Font = Enum.Font.BuilderSansMedium
ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
ToggleTitle.BackgroundTransparency = 1

-- Nút công tắc Bật/Tắt (Switch)
local SwitchFrame = Instance.new("Frame", ToggleButton)
SwitchFrame.Size = UDim2.fromOffset(36, 18)
SwitchFrame.Position = UDim2.new(1, -10, 0.5, 0)
SwitchFrame.AnchorPoint = Vector2.new(1, 0.5)
SwitchFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local SwitchCorner = Instance.new("UICorner", SwitchFrame)
SwitchCorner.CornerRadius = UDim.new(0.5, 0)

local Dot = Instance.new("Frame", SwitchFrame)
Dot.Size = UDim2.fromOffset(12, 12)
Dot.Position = UDim2.new(0, 3, 0.5, 0)
Dot.AnchorPoint = Vector2.new(0, 0.5)
Dot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)

local DotCorner = Instance.new("UICorner", Dot)
DotCorner.CornerRadius = UDim.new(0.5, 0)

-- Logic Bật/Tắt & Hiệu ứng Chuyển động (Tween)
local IsToggled = false

local function ToggleState(State)
    IsToggled = State
    
    local TargetDotPos = IsToggled and UDim2.new(1, -3, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
    local TargetDotAnchor = IsToggled and Vector2.new(1, 0.5) or Vector2.new(0, 0.5)
    local TargetDotColor = IsToggled and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(150, 150, 150)
    
    TweenService:Create(Dot, TweenInfo.new(0.2), {
        Position = TargetDotPos,
        AnchorPoint = TargetDotAnchor,
        BackgroundColor3 = TargetDotColor
    }):Play()

    -- [CODE HACK / CHỨC NĂNG CỦA BẠN ĐẶT Ở ĐÂY]
    if IsToggled then
        print(">>> Tính năng đã BẬT!")
    else
        print(">>> Tính năng đã TẮT!")
    end
end

ToggleButton.Activated:Connect(function()
    ToggleState(not IsToggled)
end)
