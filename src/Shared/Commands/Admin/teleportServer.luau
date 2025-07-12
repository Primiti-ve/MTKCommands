return function (_, fromPlayers, destination)
	local cframe

	if typeof(destination) == "Player" then
		if destination.Character and destination.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = destination.Character.PrimaryPart

			cframe = hrp.CFrame
		else
			return "Target player has no character."
		end
	elseif typeof(destination) == "Vector3" then
		cframe = CFrame.new(destination)
	end

	for _, player in ipairs(fromPlayers) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = cframe
		end
	end

	return ("Teleported %d players."):format(#fromPlayers)
end
