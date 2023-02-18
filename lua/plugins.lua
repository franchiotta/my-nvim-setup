require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'scrooloose/nerdtree'
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }
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
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
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
end)

-- command-t
vim.g.CommandTWildIgnore = ",venv,build,*.egg-info"
vim.cmd('nnoremap <leader>t :CommandTGit<CR>')

-- fzf
vim.cmd('nnoremap <leader>b :Buffers<CR>')
vim.cmd('nnoremap <leader>f :Files<CR>')

-- nerdtree
vim.cmd('nnoremap <leader>nt :NERDTree<CR>')
vim.cmd('nnoremap <leader>ntf :NERDTreeFind<CR>')
vim.cmd('nnoremap <leader>ntfc :NERDTreeFocus<CR>')
vim.cmd('nnoremap <leader>ntt :NERDTreeToggle<CR>')
vim.cmd('nnoremap <leader>ntb :NERDTreeFromBookmark ')
vim.g.NERDTreeShowBookmarks = 1
vim.g.NERDTreeChDirMode = 2

-- gruvbox
vim.o.background = "dark"
require("gruvbox").setup({
  contrast = "hard"
})
vim.cmd("colorscheme gruvbox")

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
    on_attach = on_attach
}

require'lspconfig'.jdtls.setup {
    on_attach = on_attach
}

require'lspconfig'.kotlin_language_server.setup {
    on_attach = on_attach
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

-- vim-airline
vim.api.nvim_set_var('airline#extensions#tabline#enabled', 1)
vim.api.nvim_set_var('airline#extensions#branch#enabled', 1)
vim.g.airline_solarized_bg = 'dark'
vim.g.airline_powerline_fonts = 1
return
