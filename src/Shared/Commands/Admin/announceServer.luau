local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local Chat = game:GetService("Chat")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnnouncementsNamespace = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Announcements"))

return function (context, text)
	local filterResult = TextService:FilterStringAsync(text, context.Executor.UserId, Enum.TextFilterContext.PublicChat)

	for _, player in ipairs(Players:GetPlayers()) do
		if Chat:CanUsersChatAsync(context.Executor.UserId, player.UserId) then
			AnnouncementsNamespace.packets.Announce.sendTo({
				Message = filterResult:GetChatForUserAsync(player.UserId),
				PlayerName = context.Executor.Name
			}, player)
		end
	end

	return "Created announcement."
end