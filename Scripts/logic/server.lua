-- Scripts/logic/server.lua
local ServerModule = {}

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Hàm Rejoin (Vào lại server hiện tại)
function ServerModule.Rejoin()
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("\nĐang kết nối lại...")
            task.wait(1)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)
end

-- Hàm Server Hop (Đổi sang server khác ngẫu nhiên)
function ServerModule.ServerHop()
    pcall(function()
        local cursor = ""
        local servers = {}
        
        -- Lấy danh sách server công khai từ API Roblox
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success and result then
            local data = HttpService:JSONDecode(result)
            if data and data.data then
                for _, server in ipairs(data.data) do
                    -- Lọc các server chưa đầy và không phải server hiện tại
                    if type(server) == "table" and server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server.id)
                    end
                end
            end
        end
        
        if #servers > 0 then
            -- Chọn ngẫu nhiên một server trong danh sách hợp lệ
            local randomServerId = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServerId, LocalPlayer)
        else
            -- Fallback nếu không tìm thấy danh sách qua API
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
end

return ServerModule
