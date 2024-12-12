-- always set leader first!
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
vim.opt.cursorline = true

vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.termguicolors = true

-- Easier jumplist nav
vim.keymap.set("n", "<bs>", "<C-o>", { desc = "Go back in jumplist" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- TODO: I would really like a keymap for visual mode that takes the selected text and searches for it with Rg.
vim.keymap.set("n", "<leader>/", ":Rg ", { desc = "Ripgrep" })
vim.keymap.set("n", "<leader>f", ":Files<cr>", { desc = "Project files" })
vim.keymap.set("n", "<leader>b", ":Buffers<cr>", { desc = "Buffers" })

-- Yank, delete, change should copy to system clipboard.
-- Apparently, this can increase startup time. So schedule it to be set after
-- the `UiEnter` event.
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L114
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Easier window navigation (<C-j> to <C-w>j, etc)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Keeps the cursor in the middle of the screen except at the top/bottom of buffers.
-- Seems to work better (for scrolling) the answer given here:
-- https://stackoverflow.com/questions/13398631/always-keep-the-cursor-centered-in-vim/63326139#63326139
vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

-- Spell check please
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- Yank, delete, change should copy to system clipboard.
-- Apparently, this can increase startup time. So schedule it to be set after
-- the `UiEnter` event.
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L114
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99
-- very basic "continue indent" mode (autoindent) is always on in neovim
-- could try smartindent/cindent, but meh.
-- vim.opt.cindent = true
-- XXX
-- vim.opt.cmdheight = 2
-- vim.opt.completeopt = 'menuone,noinsert,noselect'
-- not setting updatedtime because I use K to manually trigger hover effects
-- and lowering it also changes how frequently files are written to swap.
-- vim.opt.updatetime = 300
-- if key combos seem to be "lagging"
-- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
-- vim.opt.timeoutlen = 300
-- keep more context on screen while scrolling
-- vim.opt.scrolloff = 2
-- never show me line breaks if they're not there
vim.opt.wrap = false
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = "yes"
-- sweet sweet relative line numbers
vim.opt.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true
--" Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = "list:longest"
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"
-- tabs
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.incsearch = true
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep
vim.opt.vb = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append("iwhite")
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")
-- show a column at 120 characters as a guide for long lines
vim.opt.colorcolumn = "120"
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"

-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------
-- quick-save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
-- make missing : less annoying
vim.keymap.set("n", ";", ":")
-- Jump to start and end of line using the home row keys
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")
-- Neat X clipboard integration
-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
vim.keymap.set("n", "<leader>p", "<cmd>read !wl-paste<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>w !wl-copy<cr><cr>")
-- <leader><leader> toggles between buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>")
-- <leader>, shows/hides hidden characters
vim.keymap.set("n", "<leader>,", ":set invlist<cr>")
-- always center search results
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })
-- "very magic" (less escaping needed) regexes by default
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("c", "%s/", "%sm/")
-- open new file adjacent to current file
vim.keymap.set("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <cr>')
-- no arrow keys --- force yourself to use the home row
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set("n", "<left>", ":bp<cr>")
vim.keymap.set("n", "<right>", ":bn<cr>")
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })
-- handy keymap for replacing up to next _ (like in variable names)
-- vim.keymap.set("n", "<leader>m", "ct_")

-------------------------------------------------------------------------------
--
-- autocommands
--
-------------------------------------------------------------------------------
-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	command = "silent! lua vim.highlight.on_yank({ timeout = 200 })",
})
-- jump to last edit position on opening file
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function(ev)
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			-- except for in git commit messages
			-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
			if not vim.fn.expand("%:p"):find(".git", 1, true) then
				vim.cmd('exe "normal! g\'\\""')
			end
		end
	end,
})
-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup("text", { clear = true })
for _, pat in ipairs({ "text", "markdown", "mail", "gitcommit" }) do
	vim.api.nvim_create_autocmd("Filetype", {
		pattern = pat,
		group = text,
		command = "setlocal spell tw=72 colorcolumn=73",
	})
end

vim.api.nvim_create_user_command("Bd", function(opts)
	if opts.bang then
		vim.cmd("bp|bd! #")
	else
		vim.cmd("bp|bd #")
	end
end, { desc = "Delete current buffer (preserving splits)", bang = true })

-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------
-- first, grab the manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- then, setup!
require("lazy").setup({
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"gzip",
				"tarPlugin",
				"tohtml",
				-- uncomment if you need vim tutor
				"tutor",
				"zipPlugin",
			},
		},
	},

	spec = {
		-- main color scheme
		{
			"wincent/base16-nvim",
			lazy = false, -- load at start
			priority = 1000, -- load first
			config = function()
				vim.cmd([[colorscheme base16-gruvbox-material-dark-medium]])
				vim.o.background = "dark"
				-- Make it clearly visible which argument we're at.
				local marked = vim.api.nvim_get_hl(0, { name = "PMenu" })
				vim.api.nvim_set_hl(
					0,
					"LspSignatureActiveParameter",
					{ fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true }
				)
			end,
		},
		-- nice bar at the bottom
		{
			"itchyny/lightline.vim",
			lazy = false, -- also load at start since it's UI
			config = function()
				-- no need to also show mode in cmd line when we have bar
				vim.o.showmode = false
				vim.g.lightline = {
					active = {
						left = {
							{ "mode", "paste" },
							{ "readonly", "filename", "modified" },
						},
						right = {
							{ "lineinfo" },
							{ "percent" },
							{ "fileencoding", "filetype" },
						},
					},
					component_function = {
						filename = "v:lua.LightlineFilename",
					},
					mode_map = {
						n = "N",
						i = "I",
						R = "R",
						v = "V",
						V = "VL",
						["<C-v>"] = "VB",
						c = "C",
						s = "S",
						S = "SL",
						["<C-s>"] = "SB",
						t = "T",
					},
				}
				function LightlineFilename(opts)
					if vim.fn.expand("%:t") == "" then
						return "[No Name]"
					else
						return vim.fn.getreg("%")
					end
				end
			end,
		},
		{
			"folke/flash.nvim",
			event = "BufReadPre",
			---@type Flash.Config
			opts = {},
    -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
		},
		-- better %
		{
			"andymass/vim-matchup",
			-- TODO: I wonder if I could lazy load this when % is pressed instead of the event.
			event = "BufReadPre",
			config = function()
				vim.g.matchup_matchparen_offscreen = { method = "popup" }
			end,
		},
		-- fzf support for ^p
		{
			"junegunn/fzf.vim",
			dependencies = {
				{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
			},
			config = function()
				-- stop putting a giant window over my editor
				vim.g.fzf_layout = { down = "~20%" }
				-- when using :Files, pass the file list through
				--
				--   https://github.com/jonhoo/proximity-sort
				--
				-- to prefer files closer to the current file.
				function list_cmd()
					local base = vim.fn.fnamemodify(vim.fn.expand("%"), ":h:.:S")
					if base == "." then
						-- if there is no current file,
						-- proximity-sort can't do its thing
						return "fd --type file --follow --hidden"
					else
						return vim.fn.printf(
							"fd --type file --follow --hidden | proximity-sort %s",
							vim.fn.shellescape(vim.fn.expand("%"))
						)
					end
				end
				vim.api.nvim_create_user_command("Files", function(arg)
					vim.fn["fzf#vim#files"](
						arg.qargs,
						{ source = list_cmd(), options = { "--tiebreak=index", "--info=hidden" } },
						arg.bang
					)
				end, { bang = true, nargs = "?", complete = "dir" })
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			event = "BufReadPre",
			-- TODO: there are probably other commands that should be listed here:
			cmd = { "TSUpdate" },
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
		-- LSP
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
			},
			config = function()
				require("mason").setup({
					-- ensure_installed = { "prettier", "stylua" },
				})
				require("mason-lspconfig").setup({
					-- ensure_installed = { "ts_ls", "lua_ls", "rust_analyzer", "html", "jsonls" },
				})
				-- Setup language servers.
				local lspconfig = require("lspconfig")

				-- Typescript
				lspconfig.ts_ls.setup({})

				-- C/C++
				lspconfig.clangd.setup({})

				-- Rust
				lspconfig.rust_analyzer.setup({
					-- Server-specific settings. See `:help lspconfig-setup`
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							imports = {
								group = {
									enable = false,
								},
							},
							completion = {
								postfix = {
									enable = false,
								},
							},
						},
					},
				})

				-- Bash LSP
				local configs = require("lspconfig.configs")
				if not configs.bash_lsp and vim.fn.executable("bash-language-server") == 1 then
					configs.bash_lsp = {
						default_config = {
							cmd = { "bash-language-server", "start" },
							filetypes = { "sh" },
							root_dir = require("lspconfig").util.find_git_ancestor,
							init_options = {
								settings = {
									args = {},
								},
							},
						},
					}
				end
				if configs.bash_lsp then
					lspconfig.bash_lsp.setup({})
				end

				-- Global mappings.
				-- See `:help vim.diagnostic.*` for documentation on any of the below functions
				vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
				vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

				-- Use LspAttach autocommand to only map the following keys
				-- after the language server attaches to the current buffer
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("UserLspConfig", {}),
					callback = function(ev)
						-- Enable completion triggered by <c-x><c-o>
						vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

						-- Buffer local mappings.
						-- See `:help vim.lsp.*` for documentation on any of the below functions
						local opts = { buffer = ev.buf }
						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
						--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
						vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
						vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

						local client = vim.lsp.get_client_by_id(ev.data.client_id)
					end,
				})
			end,
		},
		-- LSP-based code-completion
		{
			"hrsh7th/nvim-cmp",
			-- load cmp on InsertEnter
			event = "InsertEnter",
			-- these dependencies will only be loaded when cmp loads
			-- dependencies are always lazy-loaded unless specified otherwise
			dependencies = {
				"neovim/nvim-lspconfig",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					snippet = {
						-- REQUIRED by nvim-cmp. get rid of it once we can
						expand = function(args)
							vim.fn["vsnip#anonymous"](args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						-- Accept currently selected item.
						-- Set `select` to `false` to only confirm explicitly selected items.
						["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
					}, {
						{ name = "path" },
					}),
					experimental = {
						ghost_text = true,
					},
				})

				-- Enable completing paths in :
				cmp.setup.cmdline(":", {
					sources = cmp.config.sources({
						{ name = "path" },
					}),
				})
			end,
		},
		{
			"f-person/git-blame.nvim",
			-- event = "VeryLazy",
			event = "BufReadPre",
			config = function()
				require("gitblame").setup({
					ignored_filetypes = {
						--"oil",
						--"octo",
						"help",
						--"fugitive"
					},
				})
			end,
		},
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			-- lazy.nvim will actually define commands of these names that will load
			-- the plugin, then turn around an execute the command again with the
			-- same name. This only works though, because lazy.nvim will remove the
			-- command it created. So it is important that these event be defined
			-- (if desired) as part of the definition of the plugin.
			cmd = { "ConformInfo", "Format" },
			config = function()
				require("conform").setup({
					formatters_by_ft = {
						["lua"] = { "stylua" },
						-- Conform will run multiple formatters sequentially
						-- Use a sub-list to run only the first available formatter
						["javascript"] = { "prettier" },
						["javascriptreact"] = { "prettier" },
						["typescript"] = { "prettier" },
						["typescriptreact"] = { "prettier" },
						["css"] = { "prettier" },
						["scss"] = { "prettier" },
						["less"] = { "prettier" },
						["html"] = { "prettier" },
						["json"] = { "prettier" },
						["jsonc"] = { "prettier" },
						-- Disable formatting for YAML files since it messes up our locale file conventions
						--["yaml"] = { "prettier" },
						["markdown"] = { "prettier" },
						["markdown.mdx"] = { "prettier" },
					},
					-- I disabled this while working on Ally
					format_on_save = {
						timeout_ms = 5000,
						lsp_fallback = true,
					},
				})

				-- Define a command to trigger formatting of the current buffer/selection.
				-- NOTE: it is important that this happen as part of loading the plugin
				-- definition
				vim.api.nvim_create_user_command("Format", function(args)
					local range = nil
					if args.count ~= -1 then
						local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
						range = {
							start = { args.line1, 0 },
							["end"] = { args.line2, end_line:len() },
						}
					end
					require("conform").format({ async = true, lsp_format = "fallback", range = range })
				end, { range = true })
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			-- TODO: fix event
			-- event = "VeryLazy",
			-- Only load when the file type is set?
			event = "BufReadPre",
			config = function()
				require("gitsigns").setup({
					on_attach = function(bufnr)
						local gs = package.loaded.gitsigns

						local function map(mode, l, r, opts)
							opts = opts or {}
							opts.buffer = bufnr
							vim.keymap.set(mode, l, r, opts)
						end

						-- Navigation
						map("n", "]c", function()
							if vim.wo.diff then
								return "]c"
							end
							vim.schedule(function()
								gs.next_hunk()
							end)
							return "<Ignore>"
						end, { expr = true, desc = "Go to next hunk" })

						map("n", "[c", function()
							if vim.wo.diff then
								return "[c"
							end
							vim.schedule(function()
								gs.prev_hunk()
							end)
							return "<Ignore>"
						end, { expr = true, desc = "Go to prev hunk" })

						-- Actions
						map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
						map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
						map("v", "<leader>hs", function()
							gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
						end, { desc = "Stage hunk" })
						map("v", "<leader>hr", function()
							gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
						end, { desc = "Reset hunk" })
						map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
						map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
						map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
						map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
						map("n", "<leader>hd", gs.diffthis, { desc = "Diff against index" })
						map("n", "<leader>hD", function()
							gs.diffthis("~")
						end, { desc = "Diff against last commit" })
						map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

						-- Text object
						map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
					end,
				})
			end,
		},
		-- inline function signatures
		{
			"ray-x/lsp_signature.nvim",
			-- only load this plugin when entering insert mode
			event = "InsertEnter",
			opts = {},
			config = function(_, opts)
				-- Get signatures (and _only_ signatures) when in argument lists.
				require("lsp_signature").setup({
					doc_lines = 0,
					handler_opts = {
						border = "none",
					},
				})
			end,
		},
		-- toml
		{
			"cespare/vim-toml",
			ft = { "toml" },
		},
		-- yaml
		{
			"cuducos/yaml.nvim",
			ft = { "yaml" },
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
		},
		-- rust
		{
			"rust-lang/rust.vim",
			ft = { "rust" },
			config = function()
				vim.g.rustfmt_autosave = 1
				vim.g.rustfmt_emit_files = 1
				vim.g.rustfmt_fail_silently = 0
				vim.g.rust_clip_command = "wl-copy"
			end,
		},
		-- markdown
		{
			"plasticboy/vim-markdown",
			ft = { "markdown" },
			dependencies = {
				"godlygeek/tabular",
			},
			config = function()
				-- never ever fold!
				vim.g.vim_markdown_folding_disabled = 1
				-- support front-matter in .md files
				vim.g.vim_markdown_frontmatter = 1
				-- 'o' on a list item should insert at same level
				vim.g.vim_markdown_new_list_item_indent = 0
				-- don't add bullets when wrapping:
				-- https://github.com/preservim/vim-markdown/issues/232
				vim.g.vim_markdown_auto_insert_bullets = 0
			end,
		},
		{
			"nat-418/boole.nvim",
			keys = {
				{ "<C-a>", "<cmd>Boole increment<cr>", mode = { "n", "v" }, desc = "Boole increment" },
				{ "<C-x>", "<cmd>Boole decrement<cr>", mode = { "n", "v" }, desc = "Boole decrement" },
			},
			config = function()
				require("boole").setup()
			end,
		},
		-- Not sure I like using the file browser because it does not search recursively
		-- {
		-- 	"nvim-telescope/telescope.nvim",
		-- 	keys = {
		-- 		-- hijacking <leader>f to test out telescope
		-- 		{ "<leader>f", "<cmd>Telescope file_browser<cr>", mode = { "n" }, desc = "Telescope file browser" },
		-- 	},
		-- 	dependencies = {
		-- 		"nvim-telescope/telescope-file-browser.nvim",
		-- 		"nvim-lua/plenary.nvim", -- required by telescope
		-- 	},
		-- },
		{
			"kawre/leetcode.nvim",
			-- Lazy load this plugin always, unless "leetcode.nvim" is the first arg
			lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
			build = ":TSUpdate html",
			dependencies = {
				"nvim-telescope/telescope.nvim",
				"nvim-lua/plenary.nvim", -- required by telescope
				"MunifTanjim/nui.nvim",
			},
			opts = {
				lang = "typescript",
			},
		},
	},
})

-- Define a command to trigger formatting of the current buffer/selection.
-- NOTE: I tried using this as a 'cmd' in the Lazy plugin config so conform
-- would only be loaded when this command is executed, but something weird
-- was happening. It would run the first time, but subsequent calls
-- would say it was not a valid command.
-- vim.api.nvim_create_user_command("Format", function(args)
-- 	local range = nil
-- 	if args.count ~= -1 then
-- 		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
-- 		range = {
-- 			start = { args.line1, 0 },
-- 			["end"] = { args.line2, end_line:len() },
-- 		}
-- 	end
-- 	require("conform").format({ async = true, lsp_format = "fallback", range = range })
-- end, { range = true })

--[[

leftover things from init.vim that i may still end up wanting

" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Settings needed for .lvimrc
set exrc
set secure

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" <leader>s for Rg search
noremap <leader>s :Rg
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview('up:60%')
\           : fzf#vim#with_preview('right:50%:hidden', '?'),
\   <bang>0)

" <leader>q shows stats
nnoremap <leader>q g<c-g>

--]]
-- Functions for building and typechecking packages in an ultra worktree.
vim.api.nvim_create_user_command("Build", function()
	local buf_path = vim.api.nvim_buf_get_name(0)
	-- This should only run for packages in an ultra worktree
	local _, _, package = string.find(buf_path, "work/ultra/[^/]+/(packages/[^/]+)")
	if not package then
		return
	end
	vim.cmd("compiler ultratsc")
	-- Use vim's make command so that the quickfix list is populated.
	vim.cmd("make " .. package)
end, {})

vim.api.nvim_create_user_command("TestTypecheck", function()
	local buf_path = vim.api.nvim_buf_get_name(0)
	-- This should only run for packages in an ultra worktree
	local _, _, package = string.find(buf_path, "work/ultra/[^/]+/(packages/[^/]+)")
	if not package then
		return
	end
	vim.cmd("compiler ultratsc")
	vim.cmd("make " .. package .. " tsconfig.test.json --noEmit")
end, {})
