-- https://github.com/folke/todo-comments.nvim
return {
	"folke/todo-comments.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {},
}
