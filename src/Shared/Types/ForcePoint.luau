return function (registry)
	registry:RegisterType("forcePoint", registry.Cmdr.Util.MakeEnumType("Force Point", {"Spawn", "Winpad"}))
end