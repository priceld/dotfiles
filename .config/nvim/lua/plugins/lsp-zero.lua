return {
	"VonHeikemen/lsp-zero.nvim",
	event = "VeryLazy",
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
			ensure_installed = { "ts_ls", "rust_analyzer", "html", "lua_ls", "jsonls" },
			handlers = {
				lsp_zero.default_setup,
			},
		})

		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},
					},
				},
			},
		})

		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = {
							"vim",
						},
					},
					-- The following is from: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L554-L565
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						-- Tells lua_ls where to find all the Lua files that you have loaded
						-- for your neovim configuration.
						library = {
							"${3rd}/luv/library",
							unpack(vim.api.nvim_get_runtime_file("", true)),
							"/Applications/Hammerspoon.app/Contents/Resources/extensions/hs",
							"/Users/Logan.Price/.hammerspoon/Spoons/EmmyLua.spoon/annotations",
						},
						-- If lua_ls is really slow on your computer, you can try this instead:
						-- library = { vim.env.VIMRUNTIME },
					},
				},
			},
		})

		require("lspconfig").eslint.setup({
			settings = {
				format = false,
			},
		})
	end,
}
