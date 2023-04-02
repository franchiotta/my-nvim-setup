local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.jedi_language_server.setup {
    capabilities = capabilities
}

require'lspconfig'.kotlin_language_server.setup {
    capabilities = capabilities
}

require'lspconfig'.groovyls.setup{
    capabilities = capabilities
}

require'lspconfig'.gradle_ls.setup{
    capabilities = capabilities
}

require'lspconfig'.lua_ls.setup {
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
}

return
