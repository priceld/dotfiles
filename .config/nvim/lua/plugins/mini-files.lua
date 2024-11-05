return {
	"echasnovski/mini.files",
	keys = {
		{
			"<leader>e",
			mode = { "n" },
			"<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
			desc = "File explorer",
		},
	},
	config = function()
		require("mini.files").setup()
	end,
}
