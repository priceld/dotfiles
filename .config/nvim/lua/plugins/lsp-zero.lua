return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local lsp_zero = require("lsp-zero")

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			-- lsp_zero.default_keymaps({ buffer = bufnr })
			local opts = { buffer = bufnr, remap = false }

			-- TODO: use C-j, C-k in cmp for up/down
			-- from: https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/plugins/autopairs_and_cmp.lua
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<C-u>"] = cmp.mapping.scroll_docs(-4), -- scroll up preview
					["<C-d>"] = cmp.mapping.scroll_docs(4), -- scroll down preview
				}),
			})

			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "gD", function()
				vim.lsp.buf.declaration()
			end, opts)
			vim.keymap.set("n", "gy", function()
				vim.lsp.buf.type_definition()
			end, opts)
			vim.keymap.set("n", "gI", function()
				vim.lsp.buf.implementation()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>cr", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
		end)

		require("mason").setup({
			ensure_installed = { "prettier" },
		})
		require("mason-lspconfig").setup({
			ensure_installed = { "tsserver", "rust_analyzer", "html", "lua_ls", "jsonls" },
			handlers = {
				lsp_zero.default_setup,
			},
		})

		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						-- Don't warn about undefined global 'vim' in lua files
						globals = { "vim" },
					},
				},
			},
		})
	end,
}
