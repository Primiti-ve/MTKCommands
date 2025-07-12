local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommandsNamespace =
	require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Commands"))

return {
	Name = "load",
	Description = "Loads a tower for a player or a set of players.",
	Group = "MTK",
	Args = {
		{
			Type = "players",
			Name = "players",
			Description = "The players to load the tower for.",
		},
		{
			Type = "tower",
			Name = "name",
			Description = "The name of the tower to load.",
		},
		{
			Type = "boolean",
			Name = "resetTimer",
			Description = "Whether or not to reset the timer for the players.",
		},
	},

	ClientRun = function(_Context, Players, TowerName, ResetTimer)
		for _, Player in pairs(Players) do
			CommandsNamespace.packets.LoadTower.send({
				Player = Player.Name,
				TowerName = TowerName,
				ResetTimer = ResetTimer,
			})
		end

		return "Loaded tower for players."
	end,
}
