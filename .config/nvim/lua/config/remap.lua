-- keymaps
-- leader to space
vim.g.mapleader = " "

-- ; to :
vim.keymap.set("n", ";", ":", { desc = "Command mode" })

-- Easy ESC
vim.keymap.set("i", "jk", "<esc>")

-- keep search results centered
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })

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

-- leader o - new file adjacent to current (jonhoo)
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
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

]])

vim.keymap.set("n", "<leader>/", ":Rg ", { desc = "Ripgrep" })
vim.keymap.set("n", "<leader>f", ":Files<cr>", { desc = "Project files" })
vim.keymap.set("n", "<leader>b", ":Buffers<cr>", { desc = "Buffers" })

vim.keymap.set("n", "<leader>mr", ":CellularAutomaton make_it_rain<cr>", { desc = "Make it rain" })
