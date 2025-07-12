local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ByteNet = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Packages"):WaitForChild("ByteNet"))

return ByteNet.defineNamespace("Commands", function()
	return {
		packets = {
			LoadTower = ByteNet.definePacket({
				value = ByteNet.struct({
					TowerName = ByteNet.string,
					ResetTimer = ByteNet.bool,

					Player = ByteNet.playerName,
				}),
			}),
			UnloadTower = ByteNet.definePacket({
				value = ByteNet.playerName,
			}),

			ForceWin = ByteNet.definePacket({
				value = ByteNet.playerName,
			}),

			Fling = ByteNet.definePacket({
				value = ByteNet.playerName,
			}),

			Lock = ByteNet.definePacket({
				value = ByteNet.playerName,
			}),
			Unlock = ByteNet.definePacket({
				value = ByteNet.playerName,
			}),
		},
	}
end)
