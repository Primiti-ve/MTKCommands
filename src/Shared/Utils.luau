local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Configuration = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Configuration"))
local Utils = {}

function HasGroupPermission(Player: Player): boolean
	for _, Group in pairs(Configuration.Permissions.Groups) do
		local GroupID = Group.ID
		local GroupType = Group.Type

		if GroupType == "Rank" then
			local PlayerRank = Player:GetRankInGroup(GroupID)

			local GroupMinimumRank = Group.MinimumRank or 0
			local GroupMaximumRank = Group.MaximumRank or 255

			if PlayerRank >= GroupMinimumRank and PlayerRank <= GroupMaximumRank then
				return true
			end
		elseif GroupType == "Role" then
			local PlayerRole = Player:GetRoleInGroup(GroupID)
			local GroupRoles = string.split(Group.Roles, "|")

			if table.find(GroupRoles, PlayerRole) then
				return true
			end
		end
	end

	return false
end

function Utils.CheckPermissions(Player: Player): boolean
	local HasPermission = false

	if table.find(Configuration.Permissions.IDs, Player.UserId) then
		HasPermission = true
	end

	if not HasPermission then
		HasPermission = HasGroupPermission(Player)
	end

	if not HasPermission then
		return false
	end

	return true
end

return Utils
