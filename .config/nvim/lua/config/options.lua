vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.wrap = false

-- Yank, delete, change should copy to system clipboard.
vim.opt.clipboard = "unnamedplus"

-- TODO: figure out what I want here. Not sure about swap/backup,
-- but I think I want undodir...but it should probably take the NVIM_APPNAME
-- into account?
--
-- vim.opt.swapfile = false
-- vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

-- Keeps the cursor in the middle of the screen except at the top/bottom of buffers.
-- Seems to work better (for scrolling) the answer given here:
-- https://stackoverflow.com/questions/13398631/always-keep-the-cursor-centered-in-vim/63326139#63326139
vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

-- vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"
vim.opt.signcolumn = "yes"

-- Spell check please
vim.opt.spelllang = "en_us"
vim.opt.spell = true
