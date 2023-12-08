-- Sets up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- colorschemes
	"rebelot/kanagawa.nvim",
	"sainnhe/everforest",
	-- which key
	"folke/which-key.nvim",
	-- treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	-- treesitter-context
	"nvim-treesitter/nvim-treesitter-context",
	-- treesitter-textobjects
	"nvim-treesitter/nvim-treesitter-textobjects",
	-- Fuzzy finding
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	"junegunn/fzf.vim",
	-- LSP Zero
	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	-- End LSP Zero
	"mbbill/undotree",
	"folke/zen-mode.nvim",
	"eandrju/cellular-automaton.nvim",
	"stevearc/conform.nvim",
})
