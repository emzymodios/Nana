-- Scripts/logic/server.lua
local ServerModule = {}

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceID = game.PlaceId

-- Hàm Rejoin (Vào lại server hiện tại)
function ServerModule.Rejoin()
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("\nĐang kết nối lại...")
            task.wait(1)
            TeleportService:Teleport(PlaceID, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceID, game.JobId, LocalPlayer)
        end
    end)
end

-- Hàm Server Hop tối ưu kết hợp lưu lịch sử (An toàn cho Mobile)
function ServerModule.ServerHop()
    pcall(function()
        local AllIDs = {}
        local actualHour = os.date("!*t").hour
        
        -- Đọc file lưu lịch sử server cũ (có bảo vệ pcall nếu executor không hỗ trợ file)
        local successFile = pcall(function()
            AllIDs = HttpService:JSONDecode(readfile("NanaHub_Servers.json"))
        end)
        
        if not successFile or type(AllIDs) ~= "table" then
            AllIDs = { actualHour }
            pcall(function()
                writefile("NanaHub_Servers.json", HttpService:JSONEncode(AllIDs))
            end)
        else
            -- Reset danh sách nếu sang giờ mới
            if AllIDs[1] ~= actualHour then
                AllIDs = { actualHour }
                pcall(function()
                    writefile("NanaHub_Servers.json", HttpService:JSONEncode(AllIDs))
                end)
            end
        end
        
        -- Lấy danh sách server công khai từ API Roblox
        local cursor = ""
        local servers = {}
        
        local function fetchServers(cursorToken)
            local url = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
            if cursorToken and cursorToken ~= "" then
                url = url .. "&cursor=" .. cursorToken
            end
            
            local success, result = pcall(function()
                return game:HttpGet(url)
            end)
            
            if success and result then
                local data = HttpService:JSONDecode(result)
                return data
            end
            return nil
        end
        
        -- Quét tìm server chưa từng vào
        local siteData = fetchServers("")
        if siteData and siteData.data then
            for _, server in ipairs(siteData.data) do
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
        
        if #servers > 0 then
            local randomServerId = servers[math.random(1, #servers)]
            table.insert(AllIDs, randomServerId)
            
            pcall(function()
                writefile("NanaHub_Servers.json", HttpService:JSONEncode(AllIDs))
            end)
            
            TeleportService:TeleportToPlaceInstance(PlaceID, randomServerId, LocalPlayer)
        else
            -- Fallback nếu hết server mới: Teleport ngẫu nhiên mặc định
            TeleportService:Teleport(PlaceID, LocalPlayer)
        end
    end)
end

return ServerModule
