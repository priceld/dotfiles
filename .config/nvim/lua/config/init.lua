require("config.options")
require("config.remap")
require("config.lazy")
require("config.vertical-splits")
require("config.build")

local my_group = vim.api.nvim_create_augroup("LPConfig", {})
local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- This if from the Primeagen's config and I think it just removes
-- traling spaces before save, which I probably don't need thanks
-- to prettier, but it is probably safe to leave for the files that
-- prettier does not modify.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = my_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
