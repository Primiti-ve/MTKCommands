return function (registry)
    local Towers = workspace.Towers:GetChildren()
    local TowerNames = {}

    for _, Tower in pairs(Towers) do 
        table.insert(TowerNames, Tower.Name)
    end

	registry:RegisterType("tower", registry.Cmdr.Util.MakeEnumType("Tower", TowerNames))
end