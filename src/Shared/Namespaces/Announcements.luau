local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ByteNet = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Packages"):WaitForChild("ByteNet"))

return ByteNet.defineNamespace("Announcements", function()
	return {
		packets = {
			Announce = ByteNet.definePacket({
				value = ByteNet.struct({
                    Message = ByteNet.string,
                    PlayerName = ByteNet.playerName
                }),
			}),
		},
	}
end)
