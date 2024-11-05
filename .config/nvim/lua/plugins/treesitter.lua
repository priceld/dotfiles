return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the first five listed parsers should always be installed per nvim-treesitter)
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"rust",
					"bash",
					"css",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"html",
					"json",
					"tsx",
					"toml",
					"yaml",
					"diff",
					"jsdoc",
					"markdown",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = {
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true,
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>ss",
						node_incremental = "<leader>si",
						scope_incremental = "<leader>sc",
						node_decremental = "<leader>sd",
					},
				},

				-- TODO: I wonder if I should use mini.ai for this instead
				-- textobjects = {
				-- 	select = {
				-- 		enable = true,
				-- 		lookahed = true,
				-- 		keymaps = {
				-- 			["ap"] = "@parameter.outer",
				-- 		},
				-- 	},
				-- },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-textobjects",
	-- },
}
