local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Dọn sạch tất cả UI cũ có thể bị kẹt
if playerGui:FindFirstChild("RedzHubBloxFruits") then
    playerGui.RedzHubBloxFruits:Destroy()
end
if game.CoreGui:FindFirstChild("RedzHubBloxFruits") then
    game.CoreGui.RedzHubBloxFruits:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedzHubBloxFruits"
screenGui.ResetOnSpawn = false
-- Thử đưa vào CoreGui nếu executor hỗ trợ, nếu không sẽ về PlayerGui
pcall(function()
    screenGui.Parent = game:GetService("CoreGui")
end)
if not screenGui.Parent then
    screenGui.Parent = playerGui
end

-- Nút mở/đóng Hub (Nút tròn nhỏ có chữ F)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 45, 0, 45)
toggleButton.Position = UDim2.new(0.02, 0, 0.08, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 20
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "⚡"
toggleButton.BorderSizePixel = 0
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleButton

-- Khung Hub chính (Giao diện ngang lớn)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 400)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Thanh tiêu đề trên cùng (Topbar)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 32)
topBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = topBar

-- Khúc dưới thanh topbar để làm phẳng góc bo tròn
local fixBar = Instance.new("Frame")
fixBar.Size = UDim2.new(1, 0, 0, 5)
fixBar.Position = UDim2.new(0, 0, 1, -5)
fixBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
fixBar.BorderSizePixel = 0
fixBar.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -15, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
titleLabel.TextSize = 12
titleLabel.Font = Enum.Font.GothamMedium
titleLabel.Text = "Redz Hub : Blox Fruits  <font color='#888899'>by redz999</font>"
titleLabel.RichText = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Sidebar (Thanh menu dọc bên trái)
local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(0, 160, 1, -32)
sidebar.Position = UDim2.new(0, 0, 0, 32)
sidebar.BackgroundColor3 = Color3.fromRGB(21, 21, 26)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 2
sidebar.Parent = mainFrame

local sideLayout = Instance.new("UIListLayout")
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Padding = UDim.new(0, 3)
sideLayout.Parent = sidebar

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0, 8)
sidePadding.PaddingLeft = UDim.new(0, 8)
sidePadding.PaddingRight = UDim.new(0, 8)
sidePadding.Parent = sidebar

-- Khung chứa nội dung bên phải (Content Area)
local contentArea = Instance.new("ScrollingFrame")
contentArea.Size = UDim2.new(1, -168, 1, -38)
contentArea.Position = UDim2.new(0, 164, 0, 36)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.ScrollBarThickness = 3
contentArea.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 8)
contentLayout.Parent = contentArea

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingRight = UDim.new(0, 10)
contentPadding.Parent = contentArea

-- Hàm tạo tiêu đề nhóm (Ví dụ: Farm, Bones,...)
local function createHeader(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(170, 170, 185)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = contentArea
end

-- Hàm tạo công tắc gạt (Toggle Switch) chuẩn phong cách Hub
local function createToggle(name, desc, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 46)
    card.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    card.BorderSizePixel = 0
    card.Parent = contentArea

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = card

    local nLabel = Instance.new("TextLabel")
    nLabel.Size = UDim2.new(1, -65, 0, 18)
    nLabel.Position = UDim2.new(0, 10, 0, 5)
    nLabel.BackgroundTransparency = 1
    nLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
    nLabel.TextSize = 12
    nLabel.Font = Enum.Font.GothamBold
    nLabel.Text = name
    nLabel.TextXAlignment = Enum.TextXAlignment.Left
    nLabel.Parent = card

    local dLabel = Instance.new("TextLabel")
    dLabel.Size = UDim2.new(1, -65, 0, 15)
    dLabel.Position = UDim2.new(0, 10, 0, 23)
    dLabel.BackgroundTransparency = 1
    dLabel.TextColor3 = Color3.fromRGB(120, 120, 135)
    dLabel.TextSize = 10
    dLabel.Font = Enum.Font.Gotham
    dLabel.Text = desc
    dLabel.TextXAlignment = Enum.TextXAlignment.Left
    dLabel.Parent = card

    -- Nút gạt bên phải
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 38, 0, 20)
    btn.Position = UDim2.new(1, -46, 0.5, -10)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.Parent = card

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0)
    btnCorner.Parent = btn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 14, 0, 14)
    circle.Position = UDim2.new(0, 3, 0.5, -7)
    circle.BackgroundColor3 = Color3.fromRGB(140, 140, 150)
    circle.BorderSizePixel = 0
    circle.Parent = btn

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(80, 100, 255)
            circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            circle:TweenPosition(UDim2.new(1, -17, 0.5, -7), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            circle.BackgroundColor3 = Color3.fromRGB(140, 140, 150)
            circle:TweenPosition(UDim2.new(0, 3, 0.5, -7), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
        if callback then callback(active) end
    end)
end

-- Hàm tạo các mục chọn ở menu bên trái
local function createTab(name)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, 0, 0, 32)
    tab.BackgroundColor3 = Color3.fromRGB(21, 21, 26)
    tab.TextColor3 = Color3.fromRGB(150, 150, 165)
    tab.TextSize = 12
    tab.Font = Enum.Font.GothamMedium
    tab.Text = "   " .. name
    tab.TextXAlignment = Enum.TextXAlignment.Left
    tab.BorderSizePixel = 0
    tab.AutoButtonColor = false
    tab.Parent = sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = tab
    return tab
end

-- Tạo các danh mục menu trái
createTab("📁  Farm")
createTab("💀  Bones")
createTab("⚡  Speed Control")

-- Thêm các tính năng chức năng vào bảng điều khiển
createHeader("Farm Settings")
createToggle("Auto Farm Level", "Tự động đánh quái luyện cấp tối ưu", function(state)
    print("Auto Farm Level:", state)
end)

createToggle("Auto Farm Mastery", "Tự động farm thông thạo kiếm/súng/trái cây", function(state)
    print("Auto Farm Mastery:", state)
end)

createHeader("Bones Options")
createToggle("Auto Farm Bones", "Tự động thu thập xương tại vùng lạnh/ma ám", function(state)
    print("Auto Farm Bones:", state)
end)

createHeader("Player Enhancements")
-- Logic tốc độ tích hợp sẵn
local currentSpeed = 16
RunService.RenderStepped:Connect(function()
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            hum.WalkSpeed = currentSpeed
        end
    end
end)

createToggle("Super Speed (100)", "Bật tốc độ di chuyển nhanh vượt trội", function(state)
    if state then
        currentSpeed = 100
    else
        currentSpeed = 16
    end
end)

-- Nút mở/đóng giao diện chính
local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
    toggleButton.BackgroundColor3 = isOpen and Color3.fromRGB(80, 100, 255) or Color3.fromRGB(25, 25, 30)
end)

print("✅ Redz Hub Blox Fruits UI đã tải thành công!")
