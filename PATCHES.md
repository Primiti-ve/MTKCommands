# Required MTK Patches
MTKCommands runs on a modified version of MTK v4. Below is a list of functions and what to replace them with:

## MultiTowerServer Patches
### Command Runner
Place this just above the last do-end block.
```lua
do
	local CommandsNamespace = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Commands"))
	local Utils = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Utils"))

	CommandsNamespace.packets.LoadTower.listen(function(Data: {Player: string, TowerName: string, ResetTimer: boolean}, Executor: Player?)
		if Executor and Utils.CheckPermissions(Executor) then
			local Player = PlayersService:FindFirstChild(Data.Player) :: Player

			if Player then
				PlayerLoadTower(Player.Name, Data.TowerName, Data.ResetTimer)
			end
		end
	end)
	CommandsNamespace.packets.UnloadTower.listen(function(Data: string, Executor: Player?)
		if Executor and Utils.CheckPermissions(Executor) then
			local Player = PlayersService:FindFirstChild(Data) :: Player

			if Player then
				if Player:GetAttribute("TowersLocked") then return end
				
				RemoteEvents.UnloadTower:FireClient(Player)
				Player:LoadCharacter()
			end
		end
	end)
	
	CommandsNamespace.packets.ForceWin.listen(function(Data: string, Executor: Player?)
		if Executor and Utils.CheckPermissions(Executor) then
			local Player = PlayersService:FindFirstChild(Data) :: Player
			local PlayerInfo = Players[Player.Name] :: PlayerInfo

			if Player and PlayerInfo then
				local TowerName = PlayerInfo.CurrentTower
				local Tower = Towers[TowerName].Folder :: Folder
				
				if Tower then
					local Winpad = Tower.Obby:WaitForChild("WinPad") or Tower.Obby:WaitForChild("Winpad")
					
					if not Winpad then
						Winpad = Tower:WaitForChild("WinPad") or Tower:WaitForChild("Winpad")
					end
					
					if Winpad then
						local EndingID:string = Attributes:GetString(Winpad, "EndingID") or ""
						
						if EndingID == "" then
							Winpad:SetAttribute("EndingID", TowerName)
							
							EndingID = TowerName
						end
						
						Player:SetAttribute("DisableAC", true)
						
						Teleport:TeleportPlayerToPart(Player, Winpad)
						Player.Character:PivotTo(Player.Character:GetPivot() * CFrame.new(0, Player.Character:GetExtentsSize(), 0))
						--PlayerTouchedWinpad(Player.Name, Tower.Name, EndingID)
						
						Player.CharacterAdded:Once(function()
							Player:SetAttribute("DisableAC", false)
						end)
					end
				end
			end
		end
	end)
	
	CommandsNamespace.packets.Lock.listen(function(Data: string, Executor: Player?)
		if Executor and Utils.CheckPermissions(Executor) then
			local Player = PlayersService:FindFirstChild(Data) :: Player

			if Player then
				Player:SetAttribute("TowersLocked", true)
			end
		end
	end)
	CommandsNamespace.packets.Unlock.listen(function(Data: string, Executor: Player?)
		if Executor and Utils.CheckPermissions(Executor) then
			local Player = PlayersService:FindFirstChild(Data) :: Player

			if Player then
				Player:SetAttribute("TowersLocked", false)
			end
		end
	end)
end
```

### Init
Replace the very last do-end block with this:
```lua
do
	if RunService:IsStudio() then
		for k:number, v:Instance in StarterPackStudio:GetChildren() do
			v:SetAttribute("DebugItem",true)
			v.Parent = StarterPack
		end
	end
	-- Make sure all tools are tagged with the attribute, since a StringValue isn't secure
	for k:number,v:Instance in StarterPack:GetChildren() do
		if not v:IsA("Tool") then continue end
		local BoostNameValue:Instance? = v:FindFirstChild("BoostName")
		if BoostNameValue and BoostNameValue:IsA("StringValue") then
			Util:Warn("Boost item "..v.Name.." uses a StringValue for BoostName, please change it to an attribute, as a StringValue can be manipulated (or even deleted) by the client")
			v:SetAttribute("BoostName",BoostNameValue.Value)
		end
	end
	
	task.spawn(Util.Init, Util, RemoteEvents, GameData)
	task.spawn(Announcements.Init, Announcements, RemoteEvents, GameData)
	
	EverpresentCOs.Parent = ServerStorage
	
	InitTowers()
	InitPortals()
	InitMarkers()
end
```

### TeleportToWinroom
Replace the TeleportToWinroom function with this:
```lua
function TeleportToWinroom(Player:PlayerInfo,WinroomMarker:string) 
	if Player.Player:GetAttribute("TowersLocked") then return end
	
	Player.TouchEventBusy = true
	Player.Player.Team = Teams.Winners

	RemoteEvents.UnloadTower:FireClient(Player.Player)
	ResetPlayerInfo(Player)
    
	local WinroomPart:Instance?

	if WinroomMarker ~= "" then
		WinroomPart = Markers:FindFirstChild(WinroomMarker,true)
	else
		WinroomPart = Markers:FindFirstChild("WinroomSpawn",true)
	end
    
	if WinroomPart and WinroomPart:IsA("BasePart") then
		Teleport:TeleportPlayerToPartWithWait(Player.Player,WinroomPart)
	end

	Player.TouchEventBusy = false
end
```

### PlayerLoadTower
Replace the PlayerLoadTower function with this:
```lua
function PlayerLoadTower(PlayerName:string,TowerName:string, ResetTimer:boolean)
	local Player:PlayerInfo? = Players[PlayerName]
	local Tower:TowerInfo? = Towers[TowerName]
	
	if Player and Tower then
		if Player.IsLoadingTower then return end
		if Player.Player:GetAttribute("TowersLocked") then return end
		
		if ResetTimer then
			Player.TowerTimer = 0
			Player.BoostItemUsed = false
			Player.BoostItemNames = {}
		end
		
		Player.CurrentTower = TowerName
		Player.CurrentTowerCheckpoint = 1
		Player.IsLoadingTower = true
		
		Player.Player:LoadCharacter()
		
		if not Player.Player.Character then
			Player.Player.CharacterAdded:Wait()
		end
		
		local Character:Model? = Player.Player.Character
		
		if Character then
			local ForceField:Instance? = Character:FindFirstChildOfClass("ForceField")
			if ForceField then ForceField:Destroy() end
			
			Teleport:TeleportPlayerToPartWithWait(Player.Player, Tower.SpawnLocation)
		end
		
		local OldCOFolder:Instance? = Player.Player:FindFirstChild("ClientSidedObjects")
		
		if OldCOFolder then
			OldCOFolder:Destroy()
		end
		
		local Purist:boolean = true
		
		if Tower.ClientObjects then
			Purist = false
			local COFolder:Instance = Tower.ClientObjects:Clone()
			COFolder.Name = "ClientSidedObjects"
			COFolder.Parent = Player.Player
		end
		
		RemoteEvents.LoadTower:FireClient(Player.Player, TowerName, Purist, ResetTimer)
		Player.IsLoadingTower = false
	end
	
	if not Tower then
		Util:Warn("Unknown tower \""..TowerName.."\"")
	end
end
```

## MultiTowerClient Patches
### Announcement Runner
Place this just above the last do-end block.
```lua
do
	local AnnouncementsNamespace = require(ReplicatedStorage:WaitForChild("MTKCommands"):WaitForChild("Namespaces"):WaitForChild("Announcements"))

	AnnouncementsNamespace.packets.Announce.listen(function(Data: {Message: string, PlayerName: string}, _Player: Player?)
		Announcements:DisplayMessage(string.format("[%s] %s", Data.PlayerName, Data.Message), Color3.fromRGB(255, 255, 255), false)
	end)
end
```