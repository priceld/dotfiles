-- keymaps
-- leader to space
vim.g.mapleader = " "

-- ; to :
vim.keymap.set("n", ";", ":", { desc = "Command mode" })

-- Easy ESC
vim.keymap.set("i", "jk", "<esc><right>")
vim.keymap.set("i", "jj", "<esc><right>")

-- keep search results centered
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })
vim.keymap.set("n", "G", "Gzz", { silent = true })
vim.keymap.set("n", "%", "%zz", { silent = true })

-- Easier window navigation (<C-j> to <C-w>j, etc)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Alt+hjkl move lines of code (from lazy, I think)
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Easier jumplist nav
vim.keymap.set("n", "<bs>", "<C-o>", { desc = "Go back in jumplist" })
-- This is a default mapping in vim already. I'm adding it here to get the whichkey description
vim.keymap.set("n", "<tab>", "<C-i>", { desc = "Go forward in jumplist" })

-- Easier buffer nav
vim.keymap.set("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Easier quicklist nav
-- From: https://github.com/dmmulroy/kickstart.nix/blob/ee5dc1ae5e479bff40e31d595e5b67466f3cf333/config/nvim/lua/user/keymaps.lua
-- Place all dignostics into a qflist
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
-- Navigate to next qflist item
vim.keymap.set("n", "<leader>cn", ":cnext<cr>zz", { desc = "Quickfix [N]ext" })
-- Navigate to previos qflist item
vim.keymap.set("n", "<leader>cp", ":cprevious<cr>zz", { desc = "Quickfix [P]revious" })
-- Open the qflist
vim.keymap.set("n", "<leader>co", ":copen<cr>zz", { desc = "Quickfix [O]pen" })
-- Close the qflist
vim.keymap.set("n", "<leader>cc", ":cclose<cr>zz", { desc = "Quickfix [C]lose" })

-- These mappings control the size of splits (width)
-- I took these from TJ DeVries' config, but the are weird.
-- In the left split, they work as I would expect, but in the right split they work the opposite of what I would expect.
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- leader o - new file adjacent to current (jonhoo)
-- See :h c_^r for more info (look at the expression register)
vim.keymap.set(
	"n",
	"<leader>o",
	':e <C-R>=expand("%:p:h") . "/" <cr>',
	{ desc = "Open new file adjacent to current file" }
)

-- NOTE you can change FZF's preview command with FZF_PREVIEW_COMMAND
vim.cmd([[
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --hidden '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow --hidden' : printf('fd --type file --follow --hidden | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

]])

-- TODO: I would really like a keymap for visual mode that takes the selected text and searches for it with Rg.
vim.keymap.set("n", "<leader>/", ":Rg ", { desc = "Ripgrep" })
vim.keymap.set("v", "<leader>/", function()
	local selected_text = "Not Yet Implemented"
	vim.cmd("Rg " .. selected_text)
end, { desc = "Ripgrep" })
vim.keymap.set("n", "<leader>f", ":Files<cr>", { desc = "Project files" })
vim.keymap.set("n", "<leader>b", ":Buffers<cr>", { desc = "Buffers" })

vim.keymap.set("n", "<leader>iq", ":CellularAutomaton make_it_rain<cr>", { desc = "Make it rain ([I] [q]uit)" })

-- TODO: this doesn't seem to be working
vim.keymap.set("n", "<leader>rv", "<cmd>source $MYVIMRC<cr>", { desc = "[R]eload Neo[v]im" })

vim.keymap.set("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Open Git Fugitive" })

vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<leader>p", "<cmd>put", { desc = "Paste on the next line" })
vim.keymap.set("n", "<leader>P", "<cmd>put!", { desc = "Paste on the previous line" })
