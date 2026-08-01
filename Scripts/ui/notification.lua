-- Scripts/ui/notification.lua
local Notification = {}

local players = game:GetService("Players")
local player = players.LocalPlayer

function Notification.Show(title, text, duration, iconId)
    duration = duration or 2
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("NanaHubUI")
    if not screenGui then return end

    -- Tạo khung thông báo mờ nhìn xuyên thấu
    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "Notification"
    notifFrame.Size = UDim2.new(0, 260, 0, 65) -- Tăng chiều rộng lên một chút để chứa icon cho đẹp
    notifFrame.Position = UDim2.new(1, -270, 1, -85) 
    notifFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    notifFrame.BackgroundTransparency = 0.35 -- Độ mờ nhìn xuyên thấu
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
    if iconId then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Size = UDim2.new(0, 40, 0, 40)
        iconImg.Position = UDim2.new(0, 12, 0, 12)
        iconImg.BackgroundTransparency = 1
        iconImg.Image = iconId
        iconImg.Parent = notifFrame
    end

    -- Xác định vị trí chữ thụt vào nếu có icon hoặc nằm sát mép nếu không có icon
    local textOffsetLeft = iconId and 60 or 12
    local textWidthSize = iconId and -70 or -20

    -- Tiêu đề (In đậm ở trên)
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

    -- Nội dung chi tiết (Ở dưới)
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

    -- Tự động hủy bảng thông báo sau 2 giây
    task.delay(duration, function()
        if notifFrame then
            notifFrame:Destroy()
        end
    end)
end

return Notification
