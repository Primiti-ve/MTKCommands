return table.freeze({
	ClientPrefix = "[MTKc Client]",
	ServerPrefix = "[MTKc Server]",

	Permissions = {
		IDs = { -- Table of User IDs
            3503132553
		},

		Groups = {
			{
				ID = 0,
                Type = "Role", -- Rank or Role

                MinimumRank = 0,
                MaximumRank = 255,

                Roles = "Role1|Role2"
			},
		},
	},
})
