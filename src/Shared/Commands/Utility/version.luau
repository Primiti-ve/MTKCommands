local cmdrVersion = "v1.12.0"
local mtkcVersion = "v0.0.1"

return {
	Name = "version",
	Args = {},
	Description = "Shows the current version of MTKCommands and Cmdr",
	Group = "DefaultDebug",

	Run = function()
		return ("Cmdr Version %s\nMTKc Version %s"):format(cmdrVersion, mtkcVersion)
	end,
}
