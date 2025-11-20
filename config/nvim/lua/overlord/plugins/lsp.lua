return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = vim.lsp
    -- Lua
    lspconfig.enable('lua_ls', {
      cmd = 'lua-language-server',
      filetypes = { 'lua' },
      capabilities = capabilities,
    })
    -- BASH
    lspconfig.enable('bashls', {
      cmd = 'bash-language-server',
      filetypes = { 'bash' , 'sh' },
      capabilities = capabilities,
    })
    -- CSS
    lspconfig.enable('cssls', {
      cmd = { 'vscode-css-language-server', '--stdio' },
      filetypes = { 'css', 'scss', 'less' },
      capabilities = capabilities,
    })
    -- JSON
    lspconfig.enable('jsonls', {
      cmd = { 'vscode-json-language-server', '--stdio' },
      filetypes = { 'json', 'jsonc' },
      capabilities = capabilities,
    })
  end
}
