return {
	"pwntester/octo.nvim",
	cmd = { "Octo" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		-- https://github.com/pwntester/octo.nvim#-faq
		suppress_missing_scope = {
			projects_v2 = true,
		},
	},
}
