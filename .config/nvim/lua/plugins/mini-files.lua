return {
	"echasnovski/mini.files",
	version = false,
	event = "VeryLazy",
	config = function()
		require("mini.files").setup()
		vim.keymap.set(
			"n",
			"<leader>e",
			"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
			{ desc = "File explorer" }
		)
	end,
}
