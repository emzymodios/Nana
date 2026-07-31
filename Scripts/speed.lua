local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Xóa UI cũ nếu tồn tại
if playerGui:FindFirstChild("BloxFruitsHubUI") then
    playerGui:FindFirstChild("BloxFruitsHubUI"):Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BloxFruitsHubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Nút mở/đóng Hub chính ngoài màn hình
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.02, 0, 0.05, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 22
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "⚡"
toggleButton.BorderSizePixel = 0
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = toggleButton

-- Khung Hub chính (Main Window)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 700, 0, 450)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Topbar (Thanh tiêu đề trên cùng)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 10)
topBarCorner.Parent = topBar

-- Ẩn góc dưới của Topbar để nó phẳng phần khớp với thân
local fixTopBar = Instance.new("Frame")
fixTopBar.Size = UDim2.new(1, 0, 0, 5)
fixTopBar.Position = UDim2.new(0, 0, 1, -5)
fixTopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
fixTopBar.BorderSizePixel = 0
fixTopBar.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamMedium
titleLabel.Text = "Redz Hub : Blox Fruits  <font color='#707080'>by redz999</font>"
titleLabel.RichText = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Sidebar (Thanh menu danh mục bên trái)
local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(0, 180, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 2
sidebar.Parent = mainFrame

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.Padding = UDim.new(0, 4)
sidebarLayout.Parent = sidebar

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 10)
sidebarPadding.PaddingLeft = UDim.new(0, 10)
sidebarPadding.PaddingRight = UDim.new(0, 10)
sidebarPadding.Parent = sidebar

-- Container chứa nội dung bên phải (Content Area)
local contentArea = Instance.new("ScrollingFrame")
contentArea.Size = UDim2.new(1, -190, 1, -45)
contentArea.Position = UDim2.new(0, 185, 0, 40)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.ScrollBarThickness = 4
contentArea.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 10)
contentLayout.Parent = contentArea

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingRight = UDim.new(0, 15)
contentPadding.Parent = contentArea

-- Hàm tạo tiêu đề nhóm (Group Title như "Farm", "Bones",...)
local function createGroupHeader(text)
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 25)
    header.BackgroundTransparency = 1
    header.TextColor3 = Color3.fromRGB(200, 200, 210)
    header.TextSize = 15
    header.Font = Enum.Font.GothamBold
    header.Text = text
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = contentArea
end

-- Hàm tạo một dòng chức năng có nút gạt (Toggle Switch)
local function createToggle(name, description, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 50)
    card.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
    card.BorderSizePixel = 0
    card.Parent = contentArea

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = card

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -70, 0, 20)
    nameLabel.Position = UDim2.new(0, 12, 0, 6)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(230, 230, 240)
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = name
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = card

    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -70, 0, 15)
    descLabel.Position = UDim2.new(0, 12, 0, 26)
    descLabel.BackgroundTransparency = 1
    descLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
    descLabel.TextSize = 11
    descLabel.Font = Enum.Font.Gotham
    descLabel.Text = description
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = card

    -- Nút gạt (Switch)
    local switchButton = Instance.new("TextButton")
    switchButton.Size = UDim2.new(0, 40, 0, 22)
    switchButton.Position = UDim2.new(1, -52, 0.5, -11)
    switchButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    switchButton.Text = ""
    switchButton.AutoButtonColor = false
    switchButton.BorderSizePixel = 0
    switchButton.Parent = card

    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switchButton

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 3, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
    circle.BorderSizePixel = 0
    circle.Parent = switchButton

    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle

    local enabled = false
    switchButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            switchButton.BackgroundColor3 = Color3.fromRGB(80, 100, 255)
            circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            circle:TweenPosition(UDim2.new(1, -19, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            switchButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            circle.BackgroundColor3 = Color3.fromRGB(150, 150, 160)
            circle:TweenPosition(UDim2.new(0, 3, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
        if callback then
            callback(enabled)
        end
    end)
end

-- Hàm tạo nút bấm chọn danh mục ở Sidebar bên trái
local function createTab(name, iconText)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 36)
    tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    tabBtn.TextColor3 = Color3.fromRGB(160, 160, 175)
    tabBtn.TextSize = 13
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.Text = "   " .. iconText .. "   " .. name
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.BorderSizePixel = 0
    tabBtn.AutoButtonColor = false
    tabBtn.Parent = sidebar

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabBtn

    return tabBtn
end

-- Tạo các Tab mẫu giống như giao diện bạn muốn
createTab("Farm", "📁")
createTab("Stats", "📊")
createTab("Raid", "⚔️")
createTab("Items", "📦")
createTab("Shop", "🛒")

-- Xây dựng nội dung chức năng trong bảng điều khiển chính
createGroupHeader("Farm")
createToggle("Auto Farm Level", "Tự động đánh quái luyện cấp tối ưu nhất", function(state)
    print("Auto Farm Level:", state)
end)

createToggle("Auto Farm Mastery", "Tự động farm thông thạo vũ khí/trái cây", function(state)
    print("Auto Farm Mastery:", state)
end)

createToggle("Auto Elite Hunter", "Tự động tìm và tiêu diệt Elite Boss", function(state)
    print("Auto Elite Hunter:", state)
end)

createGroupHeader("Bones")
createToggle("Auto Farm Bones", "Tự động farm xương tại Haunted Castle", function(state)
    print("Auto Farm Bones:", state)
end)

createToggle("Auto Trade Bones", "Tự động đổi xương lấySurprise Gift", function(state)
    print("Auto Trade Bones:", state)
end)

createGroupHeader("Speed Control (Tùy chỉnh tốc độ)")
-- Tích hợp tính năng đổi tốc độ từ code cũ của bạn vào đây
local currentSpeed = 50
RunService.RenderStepped:Connect(function()
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            hum.WalkSpeed = currentSpeed
        end
    end
end)

createToggle("Enable Super Speed", "Bật/Tắt tốc độ chạy tuỳ chỉnh (120)", function(state)
    if state then
        currentSpeed = 120
    else
        currentSpeed = 16 -- Tốc độ mặc định của Roblox
    end
end)

-- Xử lý nút mở/đóng Hub chính
local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
    toggleButton.BackgroundColor3 = isOpen and Color3.fromRGB(80, 100, 255) or Color3.fromRGB(40, 40, 50)
end)

print("✅ Blox Fruits Hub UI đã load thành công!")
