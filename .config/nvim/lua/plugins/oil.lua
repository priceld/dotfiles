-- Do not show column line for oil buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		vim.opt_local.colorcolumn = ""
	end,
})

return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			delete_to_trash = true,
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
				-- ["<C-\\>"] = "actions.select_vsplit",
				-- ["<C-enter>"] = "actions.select_split", -- this is used to navigate left
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				-- ["`"] = "actions.cd",
				-- ["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
			},
			use_default_keymaps = false,
		})

		vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })
		vim.keymap.set("n", "-", function()
			require("oil").toggle_float()
		end, { desc = "Toggle oil float" })
	end,
}
