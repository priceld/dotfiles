-- Plugin/config for loading nvim settings from a local file. This allows
-- different projects to use different neovim settings. E.g. turn of prettier
-- for projects that don't use it.
-- NOTE: I've also looked at using "folke/neoconf.nvim" to do this, but that
-- plugin only seems to work with LSP settings.
return {
	{
		"klen/nvim-config-local",
		config = function()
			require("config-local").setup()
		end,
	},
}
