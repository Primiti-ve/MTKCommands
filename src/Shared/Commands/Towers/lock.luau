local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommandsNamespace =
	require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Commands"))

return {
	Name = "lock",
	Description = "Locks a player or a set of players from loading/unloading towers.",
	Group = "Towers",
	Args = {
		{
			Type = "players",
			Name = "players",
			Description = "The players to lock.",
		},
	},

	ClientRun = function(_Context, Players)
		for _, Player in pairs(Players) do
			CommandsNamespace.packets.Lock.send(Player.Name)
		end

		return "Locked player."
	end,
}
