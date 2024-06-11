-- https://github.com/wincent/wincent/blob/16888a4f51dff6a17294c537c0646588b680815b/aspects/nvim/files/.config/nvim/after/compiler/tsc.vim#L7
-- https://www.reddit.com/r/neovim/comments/v3bgwk/writing_compiler_with_lua/
--
vim.opt_local.makeprg = "build-ultra-package.sh"
-- Most of this error format, is taken straight from the official tsc compiler
-- from nvim/runtime/compiler/tsc.vim
-- To get it to work for ultra packages, I had to print the name of the package
-- directory, so that the quickfix list uses the correct file path.
-- See :h quickfix-directory-stack
vim.opt_local.errorformat = "%DBuilding '%f'," .. "%f %#(%l\\,%c): %trror TS%n: %m," .. "%trror TS%n: %m," .. "%-G%.%#"
