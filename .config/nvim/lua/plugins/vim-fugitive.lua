return {
	"tpope/vim-fugitive",
	cmd = { "Git" },
	keys = {
		{ "<leader>gg", mode = { "n" }, "<cmd>Git<cr>", desc = "Open Git Fugitive" },
	},
}
