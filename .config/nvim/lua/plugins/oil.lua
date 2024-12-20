-- Do not show column line for oil buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		vim.opt_local.colorcolumn = ""
	end,
})

return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	enable = false,
	config = function()
		require("oil").setup({
			delete_to_trash = true,
			-- No icons please
			columns = {},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					return name == ".DS_Store"
				end,
			},
			keymaps = {
				["?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				-- TODO: hmm...what I really want is for esc to only close if it is the floating window
				["<esc>"] = "actions.close",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
			},
			use_default_keymaps = false,
			win_options = {
				signcolumn = "yes",
			},
			skip_confirm_for_simple_edits = true,
		})

		vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })
	end,
}
