local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Utils = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Utils"))

return function(Registry)
	Registry:RegisterHook("BeforeRun", function(Context)
		local Player = Players:GetPlayerByUserId(Context.Executor.UserId)
		local HasPermission = Utils.CheckPermissions(Player)

		if not HasPermission then
			return "You don't have permission to run this command"
		end
	end)
end
