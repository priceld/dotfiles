return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	config = function()
		require("gitblame").setup({
			ignored_filetypes = { "oil", "octo", "help", "fugitive" },
		})
	end,
}
