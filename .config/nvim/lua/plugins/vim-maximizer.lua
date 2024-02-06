return {
	"szw/vim-maximizer",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>m", "<cmd>MaximizerToggle<cr>", { desc = "Toggle [M]aximize window" })
	end,
}
