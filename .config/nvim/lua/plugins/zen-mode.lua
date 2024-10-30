return {
	"folke/zen-mode.nvim",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>zz", function()
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
		end)
	end,
}
