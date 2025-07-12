local ReplicatedStorage = game:GetService("ReplicatedStorage")

return {
	Name = "restart",
	Description = "Restarts the tower for a player or set of players.",
	Group = "MTK",
	Args = {
		{
			Type = "players",
			Name = "players",
			Description = "The players to restart.",
		},
	},

	ClientRun = function(_Context, Players)
		for _, Player in pairs(Players) do
			ReplicatedStorage.TowerGame.RestartRequested:FireServer(Player)
		end

		return "Restarted tower for players."
	end,
}
