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
		end)
		vim.keymap.set("n", "<A-i>", function()
			harpoon:list():next()
		end)
		vim.keymap.set("n", "<A-u>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<A-o>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
	end,
}
