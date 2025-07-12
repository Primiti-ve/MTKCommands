local Players = game:GetService("Players")
local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()

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

	print(string.format("%s Loading component %s", Configuration.ClientPrefix, ComponentData.Name))

	coroutine.resume(Coroutine)
	Coroutines[ComponentData.Name] = Coroutine
end

Player:GetPropertyChangedSignal("Parent"):Connect(function()
	print("a")
	for Component: string, Coroutine: thread in pairs(Coroutines) do
		print(string.format("%s Closing component %s", Configuration.ClientPrefix, Component))

		coroutine.close(Coroutine)
	end
end)
