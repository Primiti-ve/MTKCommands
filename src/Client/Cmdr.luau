local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient") :: ModuleScript)

return {
	Name = "CmdrClient",
	Execute = function()
        print("a")
        
		Cmdr:SetPlaceName("MTKc")
		Cmdr:RegisterHooksIn(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Hooks"))
		Cmdr:RegisterTypesIn(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Types"))
	end,
}
