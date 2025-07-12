local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommandsNamespace =
	require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Commands"))

return {
	Name = "force",
	Description = "Force a player or set of players to teleport to a specified point in a tower.",
	Group = "MTK",
	Args = {
		{
			Type = "players",
			Name = "players",
			Description = "The players to teleport.",
		},
		{
			Type = "forcePoint",
			Name = "Force Point",
			Description = "The point to teleport the players to.",
		},
	},

	ClientRun = function(_Context, Players, ForcePoint)
		if ForcePoint == "Spawn" then
			for _, Player in pairs(Players) do
				CommandsNamespace.packets.ForceSpawnPoint.send(Player.Name)
			end

			return "Forced players to the spawn point of the tower."
		elseif ForcePoint == "Winpad" then
			for _, Player in pairs(Players) do
				CommandsNamespace.packets.ForceWinpad.send(Player.Name)
			end

			return "Forced players to winpad."
		end
	end,
}
