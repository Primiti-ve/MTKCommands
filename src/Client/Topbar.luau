local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TopbarPlus = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Packages"):WaitForChild("TopbarPlus") :: ModuleScript)
local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient") :: ModuleScript)

return {
	Name = "TopbarClient",
	Execute = function()
        local Button = TopbarPlus.new()

        Button:setName("MTKCommands")
        Button:setImage("rbxassetid://11419714821")
        Button:setCaption("Command Bar")
        Button:setCaptionHint(Enum.KeyCode.F2)
        Button:align("Right")
        Button:oneClick()

        Button.selected:Connect(function()
            Cmdr:Toggle()
        end)
	end,
}
