local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommandsNamespace =
	require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Commands"))

return {
	Name = "unload",
	Description = "Unloads the tower for a player or set of players.",
	Group = "MTK",
	Args = {
		{
			Type = "players",
			Name = "players",
			Description = "The players to unload the tower for.",
		},
	},

	ClientRun = function(_Context, Players)
		for _, Player in pairs(Players) do
			CommandsNamespace.packets.UnloadTower.send(Player.Name)
		end

		return "Unloaded tower for players."
	end,
}
