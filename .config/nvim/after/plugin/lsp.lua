local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({
  ensure_installed = { 'prettier' },
})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer', 'html', 'lua_ls', 'jsonls' },
  handlers = {
    lsp_zero.default_setup,
  },
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        -- Don't warn about undefined global 'vim' in lua files
        globals = { 'vim' },
      },
    },
  },
})
