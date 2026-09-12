-- Nana Hub Main - Shadow Glade UI Style
-- Giữ nguyên các tab/chức năng của Nana Hub, thay toàn bộ layout sang phong cách Shadow Glade

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Tìm parent GUI phù hợp
local function getGuiParent()
    local success = pcall(function()
        local test = Instance.new("Folder")
        test.Parent = CoreGui
        test:Destroy()
    end)

    if success then
        return CoreGui
    end

    return player:WaitForChild("PlayerGui")
end

local TargetParent = getGuiParent()

-- Các module của Nana Hub giữ nguyên
local function safeLoad(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    if success and result then
        return result
    end

    warn("[Nana Hub] Load Error: " .. tostring(url))
    return nil
end

local Config = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/config.lua")
local Components = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/components.lua")
local Elements = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/elements.lua")
local Notification = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/notification.lua")
local HUD = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/hud.lua")

-- CHỈ giữ các tab của Nana Hub
local MainTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/main_tab.lua")
local CombatTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/combat_tab.lua")
local ESPTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/esp_tab.lua")
local MoreTab = safeLoad("https://raw.githubusercontent.com/emzymodios/Nana/refs/heads/main/Scripts/ui/tabs/more.lua")

local UI = {}
UI.Notify = Notification

local ICON_ID = (Config and Config.IconImageId) or "rbxassetid://86285862396979"
local BACKGROUND_ID = (Config and Config.BackgroundImageId) or "rbxassetid://116222439691339"

function UI.Init()
    -- Xóa UI cũ
    local oldGui = TargetParent:FindFirstChild("NanaHubUI")
    if oldGui then
        oldGui:Destroy()
    end

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "NanaHubUI"
    gui.ResetOnSpawn = false
    gui.Parent = TargetParent

    -- HUD Nana giữ nguyên
    if HUD and HUD.Init then
        pcall(function()
            HUD.Init(gui)
        end)
    end

    -- =========================================================
    -- NÚT ICON TRÒN - STYLE FILE 1
    -- =========================================================
    local openBtn = Instance.new("ImageButton")
    openBtn.Name = "OpenButton"
    openBtn.Size = UDim2.new(0, 50, 0, 50)
    openBtn.Position = UDim2.new(0, 20, 0.5, -25)
    openBtn.Image = ICON_ID
    openBtn.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
    openBtn.BackgroundTransparency = 0.2
    openBtn.BorderSizePixel = 0
    openBtn.Active = true
    openBtn.Draggable = true
    openBtn.ZIndex = 100
    openBtn.Parent = gui

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 25)
    btnCorner.Parent = openBtn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(0, 255, 220)
    btnStroke.Thickness = 2.5
    btnStroke.Parent = openBtn

    -- =========================================================
    -- MAIN FRAME - STYLE FILE 1
    -- =========================================================
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 580, 0, 380)
    mainFrame.Position = UDim2.new(0.5, -290, 0.5, -190)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 22)
    mainFrame.BackgroundTransparency = 0.65
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = false
    mainFrame.Active = true
    -- Không dùng Draggable trên toàn MainFrame vì có thể cướp input của button/scroll.
    -- Kéo menu sẽ được xử lý riêng bằng vùng tiêu đề bên dưới.
    mainFrame.Draggable = false
    mainFrame.ZIndex = 1
    mainFrame.Parent = gui

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = mainFrame

    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = Color3.fromRGB(0, 220, 255)
    frameStroke.Thickness = 1.8
    frameStroke.Parent = mainFrame

    -- Background giống file 1
    local panelBackground = Instance.new("ImageLabel")
    panelBackground.Name = "PanelBackground"
    panelBackground.Size = UDim2.new(1, 0, 1, 0)
    panelBackground.Position = UDim2.new(0, 0, 0, 0)
    panelBackground.BackgroundTransparency = 1
    panelBackground.BorderSizePixel = 0
    panelBackground.ScaleType = Enum.ScaleType.Crop
    panelBackground.ZIndex = 1
    panelBackground.Image = BACKGROUND_ID
    panelBackground.ImageTransparency = 0.35
    panelBackground.Parent = mainFrame

    local panelBgCorner = Instance.new("UICorner")
    panelBgCorner.CornerRadius = UDim.new(0, 12)
    panelBgCorner.Parent = panelBackground

    -- =========================================================
    -- TIÊU ĐỀ
    -- =========================================================
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 35)
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.Text = "ＳＨＡＤＯＷ ＧＬＡＤＥ HUB"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 15
    titleLabel.TextColor3 = Color3.fromRGB(0, 255, 230)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.BackgroundTransparency = 1
    titleLabel.ZIndex = 5
    titleLabel.Parent = mainFrame

    -- =========================================================
    -- DRAG FIX
    -- Chỉ vùng header kéo menu, không chặn button/scroll bên trong.
    -- =========================================================
    local dragHandle = Instance.new("TextButton")
    dragHandle.Name = "DragHandle"
    dragHandle.Size = UDim2.new(1, 0, 0, 45)
    dragHandle.Position = UDim2.new(0, 0, 0, 0)
    dragHandle.BackgroundTransparency = 1
    dragHandle.BorderSizePixel = 0
    dragHandle.Text = ""
    dragHandle.AutoButtonColor = false
    dragHandle.Active = true
    dragHandle.ZIndex = 6
    dragHandle.Parent = mainFrame

    local dragging = false
    local dragStart = nil
    local startPos = nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- =========================================================
    -- SIDEBAR - CHỈ ĐỔI STYLE, KHÔNG ĐỔI TAB NANA
    -- =========================================================
    local sideBar = Instance.new("Frame")
    sideBar.Name = "SideBar"
    sideBar.Position = UDim2.new(0, 12, 0, 45)
    sideBar.Size = UDim2.new(0, 130, 1, -57)
    sideBar.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
    sideBar.BackgroundTransparency = 0.5
    sideBar.BorderSizePixel = 0
    sideBar.ZIndex = 2
    sideBar.Parent = mainFrame

    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 8)
    sideCorner.Parent = sideBar

    local sideStroke = Instance.new("UIStroke")
    sideStroke.Color = Color3.fromRGB(0, 180, 220)
    sideStroke.Transparency = 0.5
    sideStroke.Thickness = 1
    sideStroke.Parent = sideBar

    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Name = "TabsScroll"
    tabScroll.Size = UDim2.new(1, 0, 1, 0)
    tabScroll.BackgroundTransparency = 1
    tabScroll.BorderSizePixel = 0
    tabScroll.ScrollBarThickness = 3
    tabScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
    tabScroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    tabScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    tabScroll.CanvasSize = UDim2.new(0, 0, 1, 0)
    tabScroll.ZIndex = 3
    tabScroll.Parent = sideBar

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.Parent = tabScroll

    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingTop = UDim.new(0, 8)
    tabPadding.PaddingLeft = UDim.new(0, 8)
    tabPadding.PaddingRight = UDim.new(0, 8)
    tabPadding.Parent = tabScroll

    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local h = tabLayout.AbsoluteContentSize.Y
        local sh = tabScroll.AbsoluteSize.Y

        if h > sh and sh > 0 then
            tabScroll.CanvasSize = UDim2.new(0, 0, 0, h + 16)
        else
            tabScroll.CanvasSize = UDim2.new(0, 0, 1, 0)
        end
    end)

    -- =========================================================
    -- CONTENT AREA
    -- =========================================================
    -- =========================================================
    -- CONTENT AREA - SCROLL FIX
    -- Dùng ScrollingFrame để nội dung từng tab có thể cuộn xuống.
    -- AutomaticCanvasSize giúp tự tính chiều cao nội dung.
    -- =========================================================
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Position = UDim2.new(0, 152, 0, 45)
    contentFrame.Size = UDim2.new(1, -164, 1, -57)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 4
    contentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
    contentFrame.ScrollBarImageTransparency = 0.15
    contentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    contentFrame.ScrollingEnabled = true
    contentFrame.Active = true
    contentFrame.Selectable = false
    contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.CanvasPosition = Vector2.new(0, 0)
    contentFrame.ZIndex = 2
    contentFrame.Parent = mainFrame

    -- =========================================================
    -- RESIZE - GÓC PHẢI DƯỚI
    -- MainFrame đứng yên, chỉ thanh kéo này mới resize được.
    -- =========================================================
   -- MainFrame đứng yên, chỉ vùng góc phải dưới mới resize được.
local resizeBtn = Instance.new("TextButton")
resizeBtn.Name = "ResizeButton"
resizeBtn.Size = UDim2.new(0, 28, 0, 28)
resizeBtn.AnchorPoint = Vector2.new(1, 1)
resizeBtn.Position = UDim2.new(1, 0, 1, 0)

resizeBtn.Text = ""
resizeBtn.BackgroundTransparency = 1
resizeBtn.BorderSizePixel = 0
resizeBtn.AutoButtonColor = false
resizeBtn.Active = true
resizeBtn.ZIndex = 100
resizeBtn.Parent = mainFrame


    local resizeStroke = Instance.new("UIStroke")
    resizeStroke.Color = Color3.fromRGB(0, 220, 255)
    resizeStroke.Transparency = 1
    resizeStroke.Thickness = 1
    resizeStroke.Parent = resizeBtn

    local resizeCorner = Instance.new("UICorner")
    resizeCorner.CornerRadius = UDim.new(0, 5)
    resizeCorner.Parent = resizeBtn

    local isResizing = false
    local startInputPos = nil
    local startFrameSize = nil

    resizeBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            isResizing = true
            startInputPos = input.Position
            startFrameSize = mainFrame.AbsoluteSize
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not isResizing then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - startInputPos

            local newWidth = math.max(450, startFrameSize.X + delta.X)
            local newHeight = math.max(280, startFrameSize.Y + delta.Y)

            mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            isResizing = false
        end
    end)

    -- =========================================================
    -- TAB NANA HUB - GIỮ NGUYÊN 4 MỤC
    -- =========================================================
    local tabsData = {
        {Name = "Main", Module = MainTab},
        {Name = "Combat", Module = CombatTab},
        {Name = "ESP", Module = ESPTab},
        {Name = "More", Module = MoreTab}
    }

    local activeBtn = nil
    local currentTab = nil

    local function switchTab(tabModule)
        if currentTab and typeof(currentTab) == "Instance" then
            pcall(function()
                currentTab:Destroy()
            end)
        end

        for _, child in ipairs(contentFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                pcall(function()
                    child:Destroy()
                end)
            end
        end

        currentTab = nil

        -- Reset scroll mỗi khi chuyển tab.
        pcall(function()
            contentFrame.CanvasPosition = Vector2.new(0, 0)
        end)

        if tabModule and tabModule.Create then
            local success, result = pcall(function()
                return tabModule.Create(contentFrame, UI, panelBackground)
            end)

            if success then
                currentTab = result

                -- Cho phép Roblox cập nhật AutomaticCanvasSize sau khi tab tạo xong.
                task.defer(function()
                    if contentFrame and contentFrame.Parent then
                        pcall(function()
                            contentFrame.CanvasPosition = Vector2.new(0, 0)
                        end)
                    end
                end)
            else
                warn("[Nana Hub] Tab error: " .. tostring(result))
            end
        end
    end

    for idx, tab in ipairs(tabsData) do
        local btn = Instance.new("TextButton")
        btn.Name = tab.Name .. "Tab"
        btn.Size = UDim2.new(1, 0, 0, 34)
        btn.Text = tab.Name
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 12
        btn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
        btn.BackgroundTransparency = 0.3
        btn.TextColor3 = Color3.fromRGB(200, 240, 255)
        btn.BorderSizePixel = 0
        btn.ZIndex = 4
        btn.Parent = tabScroll

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Color3.fromRGB(0, 200, 255)
        btnStroke.Transparency = 0.6
        btnStroke.Thickness = 1
        btnStroke.Parent = btn

        btn.MouseButton1Click:Connect(function()
            if activeBtn then
                activeBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
                activeBtn.TextColor3 = Color3.fromRGB(200, 240, 255)
            end

            btn.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            activeBtn = btn

            switchTab(tab.Module)
        end)

        if idx == 1 then
            btn.BackgroundColor3 = Color3.fromRGB(0, 160, 220)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            activeBtn = btn
        end
    end

    -- Mở / đóng menu bằng icon
    openBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)

    -- Mở Main mặc định
    switchTab(MainTab)
end

-- Các callback của Nana giữ nguyên
UI.OnSpeedToggled = nil
UI.OnSpeedChanged = nil
UI.OnFlySpeedChanged = nil
UI.OnFlyToggled = nil
UI.OnNoClipToggled = nil
UI.OnJumpToggled = nil
UI.OnSoruToggled = nil
UI.OnFPSBoostToggled = nil
UI.OnESPToggled = nil
UI.OnESPTextSizeChanged = nil
UI.OnResetClicked = nil
UI.OnAimbotToggled = nil
UI.OnAimbotModeChanged = nil
UI.OnAimbotTargetChanged = nil
UI.OnTeleportPlayerToggled = nil
UI.OnGodmodeToggled = nil

return UI
