return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})

		vim.keymap.set("n", "<leader>j", require("treesj").toggle, { desc = "Toggle split/join code block" })
	end,
}
