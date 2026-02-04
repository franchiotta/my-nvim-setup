local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('jedi_language_server', {
    capabilities = capabilities
})

vim.lsp.config('kotlin_language_server', {
    capabilities = capabilities
})

vim.lsp.config('groovyls', {
    capabilities = capabilities
})

vim.lsp.config('gradle_ls', {
    capabilities = capabilities
})

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  -- Copied from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      },
      diagnostics = {
        globals = {'vim'}, -- Get the language server to recognize the `vim` global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
        checkThirdParty = false
      },
      telemetry = {
        enable = false, -- Do not send telemetry data containing a randomized but unique identifier
      }
    }
  }
})

return
