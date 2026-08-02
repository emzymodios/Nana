-- Scripts/logic/server.lua
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local ServerModule = {}

function ServerModule.Rejoin()
    local success, err = pcall(function()
        if #Players:GetPlayers() <= 1 then
            Players.LocalPlayer:Kick("\nRejoining...")
            task.wait(1)
            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
        end
    end)
    if not success then
        warn("Rejoin error: " .. tostring(err))
    end
end

function ServerModule.ServerHop()
    local success, err = pcall(function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        local body = HttpService:JSONDecode(req)
        
        if body and body.data then
            for _, server in ipairs(body.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server.id)
                end
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
        else
            if UI and UI.Notify then
                UI.Notify("Không tìm thấy server trống phù hợp!", 3)
            end
        end
    end)
    if not success then
        warn("Server Hop error: " .. tostring(err))
    end
end

return ServerModule
