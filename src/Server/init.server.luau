local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Configuration = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Configuration"))

local Components = script:GetChildren()
local Coroutines = {} :: { [string]: thread }

type Component = {
	Name: string,
	Execute: () -> (),
}

for _, Component in pairs(Components) do
	local ComponentData = require(Component) :: Component
	local Coroutine = coroutine.create(ComponentData.Execute)

	print(string.format("%s Loading component %s", Configuration.ServerPrefix, ComponentData.Name))

	coroutine.resume(Coroutine)
	Coroutines[ComponentData.Name] = Coroutine
end

game:BindToClose(function()
	for Component: string, Coroutine: thread in pairs(Coroutines) do
		print(string.format("%s Closing component %s", Configuration.ServerPrefix, Component))
		coroutine.close(Coroutine)
	end
end)
