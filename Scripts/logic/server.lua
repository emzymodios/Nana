-- Scripts/logic/server.lua

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Server = {}

-- Rejoin server hiện tại
function Server.Rejoin()
	local success, err = pcall(function()
		TeleportService:TeleportToPlaceInstance(
			game.PlaceId,
			game.JobId,
			LocalPlayer
		)
	end)

	if not success then
		warn("[Rejoin] "..tostring(err))
	end
end

-- Server Hop
function Server.ServerHop()
	local success, err = pcall(function()

		local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100")
			:format(game.PlaceId)

		local response = game:HttpGet(url)
		local data = HttpService:JSONDecode(response)

		if not data or not data.data then
			warn("Không lấy được danh sách server.")
			return
		end

		local available = {}

		for _, server in ipairs(data.data) do
			if server.id ~= game.JobId
				and server.playing < server.maxPlayers then

				table.insert(available, server.id)
			end
		end

		if #available == 0 then
			warn("Không tìm thấy server khác.")
			return
		end

		local target = available[math.random(#available)]

		TeleportService:TeleportToPlaceInstance(
			game.PlaceId,
			target,
			LocalPlayer
		)

	end)

	if not success then
		warn("[ServerHop] "..tostring(err))
	end
end

return Server
