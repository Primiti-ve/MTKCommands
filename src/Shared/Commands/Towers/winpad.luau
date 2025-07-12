local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommandsNamespace =
	require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Commands"))

return {
	Name = "forcewinpad",
	Description = "Force a player or set of players to teleport to the winpad.",
	Group = "Towers",
	Args = {
		{
			Type = "players",
			Name = "players",
			Description = "The players to teleport.",
		},
	},

	ClientRun = function(_Context, Players)
		for _, Player in pairs(Players) do
			CommandsNamespace.packets.ForceWin.send(Player.Name)
		end

		return "Forced player to winpad."
	end,
}
