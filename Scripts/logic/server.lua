-- Scripts/logic/server.lua
local ServerModule = {}

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceID = game.PlaceId

-- Hàm Rejoin sử dụng giao diện ErrorPrompt gốc của Roblox
function ServerModule.Rejoin()
    pcall(function()
        local CoreGui = game:GetService("CoreGui")
        local promptOverlay = CoreGui:FindFirstChild("RobloxPromptGui") and CoreGui.RobloxPromptGui:FindFirstChild("promptOverlay")
        local errorPrompt = promptOverlay and promptOverlay:WaitForChild("ErrorPrompt", 2)
        
        if errorPrompt then
            errorPrompt.Size = UDim2.new(0, 400, 0, 230)
            local leave = errorPrompt.MessageArea.ErrorFrame.ButtonArea:FindFirstChild("LeaveButton")
            
            if leave then
                errorPrompt.MessageArea.MessageAreaPadding.PaddingTop = UDim.new(0, -20)
                errorPrompt.MessageArea.ErrorFrame.ErrorFrameLayout.Padding = UDim.new(0, 5)
                errorPrompt.MessageArea.ErrorFrame.ButtonArea.ButtonLayout.CellPadding = UDim2.new(0, 0, 0, 5)
                
                local rejoin = errorPrompt.MessageArea.ErrorFrame.ButtonArea:FindFirstChild("Rejoin")
                if not rejoin then
                    rejoin = leave:Clone()
                    rejoin.Parent = leave.Parent
                    rejoin.Name = "Rejoin"
                    rejoin.ButtonText.Text = "Rejoin"
                    
                    rejoin.MouseButton1Click:Connect(function()
                        if #Players:GetPlayers() <= 1 then
                            LocalPlayer:Kick("Rejoining...")
                            task.wait(1)
                            TeleportService:Teleport(PlaceID, LocalPlayer)
                        else
                            TeleportService:TeleportToPlaceInstance(PlaceID, game.JobId, LocalPlayer)
                        end
                    end)
                end
            end
        end
        
        -- Fallback trực tiếp nếu không bật được Prompt
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("Rejoining...")
            task.wait(1)
            TeleportService:Teleport(PlaceID, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceID, game.JobId, LocalPlayer)
        end
    end)
end

-- Hàm Server Hop (Sử dụng hệ thống chống trùng server đã tối ưu cho Mobile)
function ServerModule.ServerHop()
    pcall(function()
        local AllIDs = {}
        local actualHour = os.date("!*t").hour
        
        local successFile = pcall(function()
            AllIDs = HttpService:JSONDecode(readfile("NanaHub_Servers.json"))
        end)
        
        if not successFile or type(AllIDs) ~= "table" then
            AllIDs = { actualHour }
            pcall(function()
                writefile("NanaHub_Servers.json", HttpService:JSONEncode(AllIDs))
            end)
        else
            if AllIDs[1] ~= actualHour then
                AllIDs = { actualHour }
                pcall(function()
                    writefile("NanaHub_Servers.json", HttpService:JSONEncode(AllIDs))
                end)
            end
        end
        
        local servers = {}
        local url = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
        
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success and result then
            local data = HttpService:JSONDecode(result)
            if data and data.data then
                for _, server in ipairs(data.data) do
                    local id = tostring(server.id)
                    if server.playing < server.maxPlayers and id ~= game.JobId then
                        local isExist = false
                        for _, existingId in ipairs(AllIDs) do
                            if id == tostring(existingId) then
                                isExist = true
                                break
                            end
                        end
                        if not isExist then
                            table.insert(servers, id)
                        end
                    end
                end
            end
        end
        
        if #servers > 0 then
            local randomServerId = servers[math.random(1, #servers)]
            table.insert(AllIDs, randomServerId)
            pcall(function()
                writefile("NanaHub_Servers.json", HttpService:JSONEncode(AllIDs))
            end)
            TeleportService:TeleportToPlaceInstance(PlaceID, randomServerId, LocalPlayer)
        else
            TeleportService:Teleport(PlaceID, LocalPlayer)
        end
    end)
end

return ServerModule
