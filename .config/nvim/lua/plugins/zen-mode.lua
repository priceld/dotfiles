return {
	"folke/zen-mode.nvim",
	keys = {
		{
			"<leader>zz",
			mode = { "n" },
			function()
				require("zen-mode").setup({
					window = {
						width = 120,
						options = {},
					},
				})
				require("zen-mode").toggle()
				vim.wo.wrap = true
				vim.wo.number = true
				vim.wo.rnu = true
				vim.opt.colorcolumn = ""
			end,
			desc = "Zen-mode",
		},
	},
	cmds = { "ZenMode" },
	opts = {},
}
