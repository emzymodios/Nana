-- LocalScript
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ModernUI"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- Toggle Button
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(50,50)
toggle.Position = UDim2.new(0.02,0,0.3,0)
toggle.Text = "⚡"
toggle.TextSize = 22
toggle.Font = Enum.Font.GothamBold
toggle.TextColor3 = Color3.new(1,1,1)
toggle.BackgroundColor3 = Color3.fromRGB(70,120,255)
toggle.Parent = gui

Instance.new("UICorner",toggle).CornerRadius = UDim.new(0,12)

-- Main Window
local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(520,320)
main.Position = UDim2.new(0.25,0,0.18,0)
main.BackgroundColor3 = Color3.fromRGB(28,28,28)
main.Visible = false
main.Parent = gui

Instance.new("UICorner",main).CornerRadius = UDim.new(0,10)

-- TopBar
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,34)
top.BackgroundColor3 = Color3.fromRGB(20,20,20)
top.Parent = main

Instance.new("UICorner",top).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,-40,1,0)
title.Position = UDim2.fromOffset(10,0)
title.Text = "My UI"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1,1,1)
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30,30)
close.Position = UDim2.new(1,-35,0,2)
close.Text = "✕"
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(220,60,60)
close.Parent = top

Instance.new("UICorner",close).CornerRadius = UDim.new(1,0)

-- Sidebar
local side = Instance.new("Frame")
side.Size = UDim2.new(0,120,1,-34)
side.Position = UDim2.fromOffset(0,34)
side.BackgroundColor3 = Color3.fromRGB(23,23,23)
side.Parent = main

local home = Instance.new("TextButton")
home.Size = UDim2.new(1,-10,0,36)
home.Position = UDim2.fromOffset(5,10)
home.Text = "🏠 Home"
home.Font = Enum.Font.GothamBold
home.TextSize = 15
home.TextColor3 = Color3.new(1,1,1)
home.BackgroundColor3 = Color3.fromRGB(45,45,45)
home.Parent = side

Instance.new("UICorner",home).CornerRadius = UDim.new(0,8)

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1,-120,1,-34)
content.Position = UDim2.fromOffset(120,34)
content.BackgroundTransparency = 1
content.Parent = main

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,-20,0,30)
label.Position = UDim2.fromOffset(10,10)
label.BackgroundTransparency = 1
label.Text = "Welcome!"
label.Font = Enum.Font.GothamBold
label.TextSize = 20
label.TextColor3 = Color3.new(1,1,1)
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = content

-- Toggle Window
toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible

	if main.Visible then
		main.Size = UDim2.fromOffset(0,0)
		TweenService:Create(
			main,
			TweenInfo.new(0.25,Enum.EasingStyle.Quint),
			{Size = UDim2.fromOffset(520,320)}
		):Play()
	end
end)

close.MouseButton1Click:Connect(function()
	main.Visible = false
end)

-- Drag Window
local dragging = false
local dragStart
local startPos

top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
