return {
	"github/copilot.vim",
	event = "VeryLazy",
	config = function()
		-- vim.g.copilot_no_tab_map = true
		-- vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
		-- 	expr = true,
		-- 	replace_keycodes = false,
		-- })
		--
		vim.g.copilot_filetypes = {
			-- I don't know if this works..
			oil = false,
		}
	end,
}
