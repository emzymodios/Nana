-- Scripts/logic/server.lua
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ServerModule = {}

function ServerModule.Rejoin()
    TeleportService:Teleport(game.PlaceId, player)
end

function ServerModule.ServerHop()
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)

    if success and result and result.data then
        local servers = {}
        for _, s in ipairs(result.data) do
            if type(s) == "table" and s.playing and s.maxPlayers and s.playing < s.maxPlayers and s.id ~= game.JobId then
                table.insert(servers, s.id)
            end
        end

        if #servers > 0 then
            local targetServer = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(game.PlaceId, targetServer, player)
        else
            warn("Không tìm thấy server trống phù hợp!")
        end
    else
        warn("Lỗi khi lấy danh sách server!")
    end
end

return ServerModule
