-- Based on:
-- https://github.com/dmmulroy/kickstart.nix/blob/1eea4a2c3e7ba3e85d8a14232086c7524fca5a4f/config/nvim/lua/user/vertical_help.lua
--
-- Open vim help and fugitive windows in a vertical split rather than a horizontal split.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("vertical-splits", { clear = true }),
	pattern = { "help", "fugitive" },
	callback = function()
		vim.bo.bufhidden = "unload"
		-- TODO: it is too late to do this at this point...the new window has already been created
		-- local win_count = vim.fn.winnr("$")
		-- if win_count > 1 then
		-- 	-- Move the cursor to the rightmost window
		-- 	while vim.fn.winnr("l") ~= vim.fn.winnr() do
		-- 		vim.cmd("wincmd l")
		-- 	end
		-- 	vim.cmd.wincmd("=")
		-- 	return
		-- end
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("fugitive-keybinds", { clear = true }),
	pattern = "fugitive",
	callback = function(o)
		-- Add a buffer local keymap for opening files
		vim.keymap.set(
			"n",
			"<leader>o",
			"<cmd>let f=expand('<cfile>')<cr><c-w>w :execute('e '.f)<cr>",
			{ desc = "[O]pen file", buffer = o.buf }
		)
	end,
})
