return {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		-- TODO: what keymaps to use
		vim.keymap.set("n", "<A-a>", function()
			harpoon:list():append()
		end, { desc = "[A]dd file to harpoon list" })
		vim.keymap.set("n", "<A-i>", function()
			harpoon:list():next()
		end, { desc = "Next file in harpoon list" })
		vim.keymap.set("n", "<A-u>", function()
			harpoon:list():prev()
		end, { desc = "Prev file in harpoon list" })
		vim.keymap.set("n", "<A-o>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "[O]pen harpoon list" })
	end,
}
