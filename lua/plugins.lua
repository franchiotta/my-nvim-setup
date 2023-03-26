require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'scrooloose/nerdtree'
  use {
      'junegunn/fzf',
      run = ":call fzf#install()"
  }
  use 'junegunn/fzf.vim'
  use {
      'wincent/command-t',
      run = 'cd lua/wincent/commandt/lib && make',
      setup = function ()
        vim.g.CommandTPreferredImplementation = 'lua'
      end,
      config = function()
        require('wincent.commandt').setup({
        })
      end,
  }
  use 'ellisonleao/gruvbox.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use {
        "hrsh7th/nvim-cmp",
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        }
  }

  use 'udalov/kotlin-vim'
  use 'Einenlum/yaml-revealer'
  use 'preservim/nerdcommenter'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes' 
  use 'tpope/vim-fugitive'
  use {
      'iamcco/markdown-preview.nvim',
      run = "cd app && npm install",
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" }
  }
  use 'szw/vim-maximizer'
end)

-- command-t
vim.g.CommandTWildIgnore = ",venv,build,*.egg-info"
vim.cmd('nnoremap <leader>t :CommandTGit<CR>')

-- fzf
vim.cmd('nnoremap <leader>b :Buffers<CR>')
vim.cmd('nnoremap <leader>f :Files<CR>')
vim.cmd('nnoremap <leader>gf :GFiles<CR>')

-- nerdtree
vim.cmd('nnoremap <leader>nt :NERDTree<CR>')
vim.cmd('nnoremap <leader>ntf :NERDTreeFind<CR>')
vim.cmd('nnoremap <leader>ntfc :NERDTreeFocus<CR>')
vim.cmd('nnoremap <leader>ntt :NERDTreeToggle<CR>')
vim.cmd('nnoremap <leader>ntb :NERDTreeFromBookmark ')
--vim.api.nvim_command('autocmd VimEnter * NERDTree')

vim.g.NERDTreeShowBookmarks = 1
vim.g.NERDTreeChDirMode = 2

-- gruvbox
vim.o.background = "dark"
require("gruvbox").setup({
  contrast = "hard"
})
vim.cmd("colorscheme gruvbox")

-- vim-airline
vim.api.nvim_set_var('airline#extensions#tabline#enabled', 1)
vim.api.nvim_set_var('airline#extensions#branch#enabled', 1)
vim.g.airline_solarized_bg = 'dark'
vim.g.airline_powerline_fonts = 1

-- vim-maximizer
vim.cmd('nnoremap <C-w>m :MaximizerToggle!<CR>')

-- nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
     vim.fn["vsnip#anonymous"](args.body)
    end
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- set capabilities in lsp server configs (see below).
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsd-config
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require'lspconfig'.jedi_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require'lspconfig'.jdtls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require'lspconfig'.kotlin_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- mason
require("mason").setup({
    log_level = vim.log.levels.DEBUG,
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Don't remove return, otherwise it will not load.
return
