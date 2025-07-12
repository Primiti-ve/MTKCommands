local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommandsNamespace =
	require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Commands"))

return {
	Name = "unlock",
	Description = "Unlocks a player or set of players from loading/unloading towers.",
	Group = "Towers",
	Args = {
		{
			Type = "players",
			Name = "players",
			Description = "The players to unlock.",
		},
	},

	ClientRun = function(_Context, Players)
		for _, Player in pairs(Players) do
			CommandsNamespace.packets.Unlock.send(Player.Name)
		end

		return "Unlocked player."
	end,
}
