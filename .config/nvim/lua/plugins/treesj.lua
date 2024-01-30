return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
	config = function()
		require("treesj").setup({})

		vim.keymap.set("n", "<leader>sj", require("treesj").toggle, { desc = "Toggle split/join" })
	end,
}
