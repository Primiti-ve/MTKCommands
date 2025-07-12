local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cmdr = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Packages"):WaitForChild("Cmdr"))

return {
	Name = "CmdrServer",
	Execute = function()
		print("a")

		--Cmdr:RegisterDefaultCommands()
		Cmdr:RegisterCommandsIn(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Commands"))
		Cmdr:RegisterHooksIn(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Hooks"))
		Cmdr:RegisterTypesIn(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Types"))
	end,
}
