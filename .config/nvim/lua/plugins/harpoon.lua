return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	branch = "harpoon2",
	keys = {
		{
			"<A-a>",
			mode = { "n" },
			function()
				require("harpoon"):list():add()
			end,
			desc = "[A]dd file to harpoon list",
		},
		{
			"<A-i>",
			mode = { "n" },
			function()
				require("harpoon"):list():next()
			end,
			desc = "Next file in harpoon list",
		},
		{
			"<A-u>",
			mode = { "n" },
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Prev file in harpoon list",
		},
		{
			"<A-o>",
			mode = { "n" },
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "[O]pen harpoon list",
		},
	},
}
