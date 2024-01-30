return {
	"nat-418/boole.nvim",
	event = "VeryLazy",
	config = function()
		require("boole").setup()

		vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>Boole increment<cr>", { desc = "Boole increment" })
		vim.keymap.set({ "n", "v" }, "<C-x>", "<cmd>Boole decrement<cr>", { desc = "Boole decrement" })
	end,
}
