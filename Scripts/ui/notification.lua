-- Scripts/ui/notification.lua
local Notification = {}

local players = game:GetService("Players")
local player = players.LocalPlayer

function Notification.Show(title, text, duration, iconId)
    duration = duration or 2
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Tránh bị phụ thuộc vào NanaHubUI, tạo ScreenGui riêng cho thông báo luôn để đảm bảo luôn hiện
    local screenGui = playerGui:FindFirstChild("NanaNotificationGui")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NanaNotificationGui"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui
    end

    -- Tạo khung thông báo mờ nhìn xuyên thấu
    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "Notification"
    notifFrame.Size = UDim2.new(0, 260, 0, 65)
    notifFrame.Position = UDim2.new(1, -270, 1, -85) 
    notifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    notifFrame.BackgroundTransparency = 0.35
    notifFrame.BorderSizePixel = 0
    notifFrame.Parent = screenGui

    -- Bo góc
    local nCorner = Instance.new("UICorner")
    nCorner.CornerRadius = UDim.new(0, 8)
    nCorner.Parent = notifFrame

    -- Viền sáng nổi bật
    local nStroke = Instance.new("UIStroke")
    nStroke.Color = Color3.fromRGB(120, 80, 255)
    nStroke.Thickness = 1.5
    nStroke.Parent = notifFrame

    -- Tạo phần hiển thị Icon bên trái (nếu có truyền ID ảnh)
    if iconId and iconId ~= "" then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Size = UDim2.new(0, 40, 0, 40)
        iconImg.Position = UDim2.new(0, 12, 0, 12)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = iconId
        iconImg.Parent = notifFrame
    end

    local textOffsetLeft = (iconId and iconId ~= "") and 60 or 12
    local textWidthSize = (iconId and iconId ~= "") and -70 or -20

    -- Tiêu đề
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, textWidthSize, 0, 22)
    titleLbl.Position = UDim2.new(0, textOffsetLeft, 0, 6)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 13
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = notifFrame

    -- Nội dung chi tiết
    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, textWidthSize, 0, 30)
    descLbl.Position = UDim2.new(0, textOffsetLeft, 0, 28)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = text
    descLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    descLbl.TextSize = 11
    descLbl.Font = Enum.Font.GothamMedium
    descLbl.TextWrapped = true
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.Parent = notifFrame

    -- Tự động hủy bảng thông báo sau thời gian định sẵn
    task.delay(duration, function()
        if notifFrame and notifFrame.Parent then
            notifFrame:Destroy()
        end
    end)
end

return Notification
